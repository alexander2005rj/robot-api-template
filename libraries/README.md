If you can't find a library for a specific use, you can create your own!

We have our own libraries created in Python here.

We can create .py files and extend the use of new keywords here as well.

To create a new keyword, simply perform the following imports:
`from robot.api import logger`
`from robot.api.deco import keyword`

And use the following annotation above the method we created:
`@keyword('keyword_name').`

Ex:

```bash
from robot.api import logger
from robot.api.deco import keyword

@keyword('Hello World Library')
def show_greetings(self, name):
    return f"Hello, {name}"
```
