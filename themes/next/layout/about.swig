{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ title }}{%- if theme.index_with_subtitle and subtitle %} - {{ subtitle }}{%- endif %}{% endblock %}
{% block class %}index posts-expand{% endblock %}

{% block content %}
<hr>
<div class="container">
    <div class="left">
        <div class="image-container">
           <div class="image-wrapper">
               <img src="https://gcdnb.pbrd.co/images/LSSIC7plBKbi.png?o=1" alt="personal-image"/>
           </div>
           <div class="content-wrapper">
               <h2>Working Experience</h2>
               <div class="garmin">
                   <div class="content">
                     <div class="title">
                         <h3>GARMIN 台灣國際航電股份有限公司</h3>
                     </div>
                     <p>SRE Backend Developer </p>
                     <p>2024~ Now </p>
                     <ol class="disc-list">
                         <li>Backend: .Net Core</li>
                         <li>Observability: OpenTelemetry, Granafa, Loki, Tempo</li>
                     </ol>
                   </div>
                   <div>
                        <h2>Working Achievement</h2>
                        <ol class="working-achievement-list">
                           <li>Refactor projects make it more maintainable</li>
                           <li>Provide SDK for projects Auto Tracting</li>
                           <li>Provide SDK for Servers Health Check</li>
                        </ol>
                   </div>
               </div>
               <hr>
               <div class="titansoft">
                   <div class="content">
                       <div class="title">
                           <h3>Titansoft, 新加坡商鈦坦科技</h3>
                       </div>
                       <p>product developer</p>
                       <p>2022~ 2024</p>
                       <ol class="disc-list">
                           <li>backend: .net core</li>
                           <li>frontend: vue3</li>
                           <li>use k8s for deployments of projects</li>
                           <li>use gitlab for ci/cd</li>
                       </ol>
                   </div>
                   <div class="working-achievement">
                       <h2>working achievement</h2>
                       <ol class="working-achievement-list">
                           <li>import hexagonal architecture knowledge for members</li>
                           <li>acting as the <b>outlink</b> in the team</li>
                           <li>host refactor workshop for intern team</li>
                           <li>pass ckad</li>
                           <li>host devops workshop, teaching about docker and k8s</li>
                           <li>representing titansoft at the gdg dinner.</li>
                           <li>representing titansoft as speaker at gdg.</li>
                           <li>construct elk for k8s projects</li>
                           <li>refactoring legacy code and fix the 2-year-old bugs</li>
                       </ol>
                   </div>
               </div>
           </div>
        </div>
        <hr>

        <div class="education">
           <h2>Education</h2>
           <ul class="numbered-list">
               <li>
                   <div>
                       <h3>Computer Science and Information Engineering</h3>
                       <p>National Yunlin University of Science and Technology, YunTech</p>
                       <p>Master's Degree</p>
                       <p>2020 ~ 2022</p>
                       <p class="t-2">Study on Blockchain and Network Security Research Area</p>
                   </div>
               </li>
               <li>
                   <div>
                       <h3>Information and Telecommunication Engineering</h3>
                       <p>Ming Chaun University, MCU</p>
                       <p>Bachelor's Degree</p>
                       <p>2016 ~ 2020</p>
                       <p class="t-2">Study on Network Security Research Area</p>
                   </div>
               </li>
           </ul>
        </div>
        <hr>
        <div class="personal-achievement">
            <h2>Personal Achievement</h2>
            <div>
               <div>
                   <ol>
                       <li>Current: Sharing Tech Knowledge on Blog</li>
                       <li>PasswordManager using <b>Vault</b></li>
                       <li>Department Sharing: <a href="https://codemachine0121.github.io/posts/406b4875/">六角架構</a>, <a href="https://codemachine0121.github.io/posts/92d0760d/">分層架構</a> 及<a href="https://codemachine0121.github.io/posts/21be0a47/">Dao 與 Repository 職責</a>
                       </li>
                       <li>iThome 鐵人賽 自我挑戰
                           <ol class="disc-list">
                               <li><a href="https://ithelp.ithome.com.tw/users/20115082/ironman/7165">Side-Project:: 為自己打造個可編輯的區塊鏈</a></li>
                           </ol>
                       </li>
                       <li>Open Source SDK for nuget: <a href="https://www.nuget.org/packages/EccSDK#usedby-body-tab">EccSDK</a></li>
                       <li>Host Refactor WorkShop for Intern Team in TitanSoft</li>
                       <li>Pass CKAD License</li>
                       <li><a href="https://gdg.community.dev/gdg-kaohsiung/">GDG Kaohsiung</a> Speaker
                           <ol class="disc-list">
                               <li><a href="https://gdg.community.dev/events/details/google-gdg-kaohsiung-presents-toocon-9/">當個願望小天使: 使用 Golang 監聽 Discord 頻道延遲</a></li>
                               <li><a href="https://gdg.community.dev/events/details/google-gdg-kaohsiung-presents-toocon-11/">讓 Vim 成為 IDE</a></li>
                           </ol>
                       </li>
                       <li>Host DevOps WorkShop in TitanSoft</li>
                       <li>iThome 鐵人賽 自我挑戰組
                           <ol class="disc-list">
                               <li><a href="https://ithelp.ithome.com.tw/users/20115082/ironman/5988?page=1">在30天內使用 golang 寫出 30種不同的設計模型</a></li>
                           </ol>
                       </li>
                       <li>Join 91's TDD Workshop in TitanSoft</li>
                       <li>Blockchain Trusted Transaction Module</li>
                       <li>Microwave Detection Analyser Module</li>
                       <li>Full Stack Develop - Website of CSIE in YunTech</li>
                       <li>Department Network Administrator in YunTech</li>
                       <li>Custom Blockchain System with <b>ZooKeeper</b></li>
                       <li>Blockchain Cold Wallet Transaction Module</li>
                   </ol>
               </div>
           </div>
        </div>
        <hr>
    </div>
</div>
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}
