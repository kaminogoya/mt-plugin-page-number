# PageNumber
PageNumber plugin is the outputs Previous, Next and Current page number for Movable Type.

## Installation
Installed plugin should look like this:
```
$MT_HOME/
    plugins/
        PageNumber/
```

## Tags
### mt:CurrentPageNumber
Output the current page number.
### mt:PreviousPageNumber
Output the previous page number from the current page.
### mt:NextPageNumber
Output the next page number from the current page.

## Examples of Usage
Change the URL to be output when use the [Pagination for Static](http://www.movabletype.org/documentation/designer/pagination-static.html).

* mt.cgi: http://www.example.com/mt/mt.cgi
* blog_id: 2
* BlogURL: http://www.example.com/blog/
* entries_per_page: 10
* Main Index template_id: 333

### Main Index (Index Template)
```
<$mt:Var name="entries_per_page" value="10"$>

<mt:Entries limit="$entries_per_page" search_results="1">
  <mt:EntriesHeader>
<ul>
  </mt:EntriesHeader>
  <li><a href="<$mt:EntryPermalink encode_html="1"$>"><$mt:EntryTitle$></a></li>
  <mt:EntriesFooter>
</ul>
  </mt:EntriesFooter>
</mt:Entries>

<mt:Include module="Pagination">
```

### Pagination (Module)
```
<mt:SetVarBlock name="pagination_navigation">
  <mt:If name="search_results">
    <mt:IfPreviousResults>
    <li><a rel="prev" href="<$mt:BlogURL$><$mt:PreviousPageNumber$>">Previous</a></li>
    </mt:IfPreviousResults>
    <mt:IfMoreResults>
    <li><a rel="next" href="<$mt:BlogURL$><$mt:NextPageNumber$>">Next</a></li>
    </mt:IfMoreResults>
  <mt:Else>
    <$mt:BlogEntryCount setvar="total_entries"$>
    <mt:If name="total_entries" gt="$entries_per_page">
    <li><a rel="next" href="<$mt:BlogURL$>2">Next</a></li>
    </mt:If>
  </mt:If>
</mt:SetVarBlock>
<$mt:Var name="pagination_navigation" strip=" " trim="1" setvar="pagination_navigation"$>
<nav>
  <ul>
<$mt:Var name="pagination_navigation"$>
  <ul>
</nav>
</mt:If>
```

### .htaccess
```
RewriteEngine on
RewriteBase /
RewriteRule ^([0-9]+)$ mt/mt-search.cgi?IncludeBlogs=2&template_id=333&limit=10&archive_type=Index&page=$1[L]
```

### Before
```
http://www.example.com/mt/mt-search.cgi?IncludeBlogs=2&template_id=333&limit=10&archive_type=Index&page=2[L]
```

### After
```
http://www.example.com/blog/2
```


This plugin is licensed under the Artistic license and GPL v2.