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

<div style="width:100%;height:0;padding-bottom:56%;position:relative;">
  <iframe src="https://giphy.com/embed/o7RZbs4KAA6tvM4H6j" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
</div>

</nav>
<script data-name="BMC-Widget" data-cfasync="false" src="https://cdnjs.buymeacoffee.com/1.0.0/widget.prod.min.js" data-id="James.Hsueh" data-description="Support me on Buy me a coffee!" data-message="" data-color="#40DCA5" data-position="Right" data-x_margin="18" data-y_margin="18"></script>
