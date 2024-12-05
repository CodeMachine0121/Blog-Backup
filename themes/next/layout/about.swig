{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ title }}{%- if theme.index_with_subtitle and subtitle %} - {{ subtitle }}{%- endif %}{% endblock %}
{% block class %}index posts-expand{% endblock %}
{% block content %}
<hr>
<div class="container">
    <div class="left">
        <div style="display: flex; align-items: flex-start; gap: 20px;">
           <div style="flex: 1;">
               <img style="width: 100%; height: auto;" src="https://gcdnb.pbrd.co/images/LSSIC7plBKbi.png?o=1" alt="personal-image"/>
           </div>
           <div style="flex: 2;">
               <h2>Working Experience</h2>
               <div class="title">
                   <h3>GARMIN 台灣國際航電股份有限公司</h3>
               </div>
               <p>SRE Backend Developer </p>
               <p>2024~ </p>
               <ol class="disc-list">
                   <li>Backend: .Net Core</li>
                   <li>Observability: OpenTelemetry, Granafa, Loki, Tempo</li>
               </ol>
               <hr>
               <div class="titansoft" style="display: flex; gap: 40px; padding: 20px; border-radius: 8px;">
                   <div class="content" style="flex: 1;">
                       <div class="title" style="margin-bottom: 15px;">
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
                   <div class="working-achievement" style="flex: 1;">
                       <h2 style="margin-bottom: 15px;">working achievement</h2>
                       <ol style="padding-left: 20px;">
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
           <ol class="numbered-list" style="display: flex; gap: 20px; justify-content: space-around;">
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
           </ol>
        </div>
        <hr>
        <div class="personal-achievement" style="padding: 20px;"> <h2>Personal Achievement</h2>
           <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
               <div>
                   <ol style="margin: 0;">
                       <li>Current: Sharing Tech Knowledge on Blog</li>
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
                   </ol>
               </div>
               <div>
                   <ol start="8" style="margin: 0;">
                       <li>iThome 鐵人賽 自我挑戰組
                           <ol class="disc-list">
                               <li><a href="https://ithelp.ithome.com.tw/users/20115082/ironman/5988?page=1">掘地土撥鼠的設計歷險記系列, 在30天內使用 golang 寫出 30種不同的設計模型</a></li>
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
