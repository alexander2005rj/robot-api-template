import sys
import json
import re
from bs4 import BeautifulSoup
from datetime import datetime

def extract_test_data_from_script(scripts):
    for script in scripts:
        if 'window.output["stats"]' in (script.string or ''):
            match = re.search(r'window.output\["stats"\]\s*=\s*(\[\[.*?\]\]);)', script.string, flags=re.DOTALL | re.MULTILINE)
            if match:
                return json.loads(match.group(1))
    raise ValueError("The desired script element could not be found in the HTML file.")

def calculate_statistics(data):
    total_tests = data[0][0]['pass'] + data[0][0]['fail'] + data[0][0]['skip']
    passed_tests = data[0][0]['pass']
    failed_tests = data[0][0]['fail']
    skipped_tests = data[0][0]['skip']

    pass_percentage = round((passed_tests / total_tests) * 100) if total_tests > 0 else 0 

    elapsed_time = data[0][0]['elapsed']
    parsed_time = datetime.strptime(elapsed_time, "%H:%M:%S")
    formatted_time = f"{parsed_time.minute}m {parsed_time.second}s"

    statistics = f"*Total Tests*: {total_tests}\\n*Pass Percentage*: {pass_percentage}%\\n*Elapsed Time*: {formatted_time}\\n"
    results = f"*Passed*: {passed_tests}\\n*Failed*: {failed_tests}\\n*Skipped*: {skipped_tests}\\n"

    return statistics, results

def extract_results_robot(file_path):
    with open(file_path, 'r') as file:
        contents = file.read()
    
    soup = BeautifulSoup(contents, 'html.parser')
    scripts = soup.find_all('script')

    data = extract_test_data_from_script(scripts)
    statistics, results = calculate_statistics(data)

    return f"{{'title': 'STATISTICS', 'value':'{statistics}', 'short': true}},{{'title':'RESULTS', 'value':'{results}', 'short': true}},"

if __name__ == "__main__":
    if len(sys.argv) > 1:
        print(extract_results_robot(sys.argv[1]))
    else:
        raise ValueError("Please provide the path to the test results HTML file as an argument.")