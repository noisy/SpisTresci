from django_docopt_command import DocOptCommand
from spistresci.stores.manager import StoreManager


class Command(DocOptCommand):
    docs = '''Usage:
    fetch_store_products <store_name>...
    fetch_store_products --all

    Options:
      -a --all     Fetches data for all stores configured in config
    '''

    def handle_docopt(self, arguments):
        try:
            manager = StoreManager(store_names=arguments['<store_name>'] if not arguments['--all'] else None)
        except StoreManager.MissingStoreInStoresConfigException as e:
            exit(e.args[0])

        for store in manager.get_stores():
            store.fetch()
