{% import 'menu-item.swig' as menu_item with context %}

<nav class="site-nav">
{%- if theme.menu %}
  <ul id="menu" class="main-menu menu">
   {%- if theme.algolia_search.enable or theme.local_search.enable %}
      <li class="menu-item menu-item-search">
        <a role="button" class="popup-trigger">
          {%- if theme.menu_settings.icons %}<i class="fa fa-search fa-fw"></i>{%- endif %}{{ __('menu.search') }}
        </a>
      </li>
    {%- endif %}

    {%- for name, path in theme.menu %}
      {%- set respath = path %}
      {%- if path == '[object Object]' %}
        {# Main Menu (default menu item for Submenu) #}
        {%- for subname, subpath in path %}
          {%- set itemName = subname | lower %}
          {%- set respath = subpath %}
          {%- if itemName == 'default' %}
            {%- set itemName = name | lower %}
            {{ menu_item.render(name, itemName, respath) }}
          {%- endif %}
        {%- endfor %}
      {% else %}
        {# Main Menu (standard menu items) #}
        {%- set itemName = name | lower %}
        {{- menu_item.render(name, itemName, respath) | trim }}
      {%- endif %}
    {%- endfor %}


  </ul>
{%- endif %}
</nav>

<div class="coffee" style="display:flex;justify-content:center;padding:10px;">
  <script type="text/javascript" src="https://cdnjs.buymeacoffee.com/1.0.0/button.prod.min.js" data-name="bmc-button" data-slug="James.Hsueh" data-color="#FFDD00" data-emoji="☕"  data-font="Cookie" data-text="Buy me a coffee" data-outline-color="#000000" data-font-color="#000000" data-coffee-color="#ffffff" ></script>
</div>
