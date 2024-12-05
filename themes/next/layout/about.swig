{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ title }}{%- if theme.index_with_subtitle and subtitle %} - {{ subtitle }}{%- endif %}{% endblock %}
{% block class %}index posts-expand{% endblock %}

{% block content %}
<hr>
<div class="container">
    <div class="left">
        <div class="working-experience">
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
            <div class="title">
                <h3>Titansoft, 新加坡商鈦坦科技</h3>
            </div>
            <p>Product Developer</p>
            <p>2022~ 2024</p>
            <ol class="disc-list">
                <li>Backend: .Net Core</li>
                <li>Frontend: Vue3</li>
                <li>Use K8S for deployments of projects</li>
                <li>Use Gitlab for CI/CD</li>
            </ol>
        </div>
        <hr>

        <div class="education">
            <h2>Education</h2>

            <ol class="numbered-list">
                <li>
                    <h3>Computer Science and Information Engineering</h3>
                    <p>National Yunlin University of Science and Technology, YunTech</p>
                    <p>Master’s Degree</p>
                    <p>2020 ~ 2022</p>
                    <p class="t-2"> Study on Blockchain and Network Security Research Area </p>
                </li>
                <li>
                    <h3>Information and Telecommunication Engineering</h3>
                    <p>Ming Chaun University, MCU</p>
                    <p>Bachelor’s Degree</p>
                    <p>2016 ~ 2020</p>
                    <p class="t-2">Study on Network Security Research Area</p>
                </li>
            </ol>
        </div>
        <hr>
        <div class="working-achievement">
            <h2>Working Achievement</h2>
            <ol>
                <li> Import Hexagonal Architecture knowledge for members</li>
                <li> Acting as the <b>Outlink</b> in the Team </li>
                <li> Host Refactor Workshop for Intern Team</li>
                <li> Pass CKAD</li>
                <li> Host DevOps Workshop, teaching about Docker and K8s</li>
                <li> Representing TitanSoft at the GDG (Google Developer Groups) dinner.</li>
                <li> Representing TitanSoft as speaker at GDG.</li>
                <li> Construct ELK ( Elasticsearch, Kibana and Filebeat) for k8s projects</li>
                <li> Refactoring Legacy Code and fix the 2-year-old bugs</li>
            </ol>
        </div>
        <hr>
        <div class="personal-achievement">
            <h2>Personal Achievement</h2>
            <ol>
                <li>Current: Sharing Tech Knowledge on Blog</li>
                <li> iThome 鐵人賽 自我挑戰
                    <ol class="disc-list">
                        <li><a href="https://ithelp.ithome.com.tw/users/20115082/ironman/7165">Side-Project::
                                為自己打造個可編輯的區塊鏈</a></li>
                    </ol>
                </li>
                <li> Open Source SDK for nuget: <a href="https://www.nuget.org/packages/EccSDK#usedby-body-tab">EccSDK</a>
                </li>
                <li> Host Refactor WorkShop for Intern Team in TitanSoft</li>
                <li> Pass CKAD License</li>
                <li> <a href="https://gdg.community.dev/gdg-kaohsiung/">GDG Kaohsiung</a>Speaker

                    <ol class="disc-list">
                        <li><a href="https://gdg.community.dev/events/details/google-gdg-kaohsiung-presents-toocon-9/">當個願望小天使:
                                使用 Golang 監聽 Discord 頻道延遲</a></li>
                        <li><a href="https://gdg.community.dev/events/details/google-gdg-kaohsiung-presents-toocon-11/">讓
                                Vim
                                成為 IDE</a></li>
                    </ol>

                </li>
                <li> Host DevOps WorkShop in TitanSoft</li>
                <li> iThome 鐵人賽 自我挑戰組
                    <ol class="disc-list">
                        <li><a href="https://ithelp.ithome.com.tw/users/20115082/ironman/5988?page=1">掘地土撥鼠的設計歷險記系列,
                                在30天內使用 golang 寫出 30種不同的設計模型</a></li>
                    </ol>
                </li>
                <li> Join 91’s TDD Workshop in TitanSoft</li>
                <li> Blockchain Trusted Transaction Module</li>
                <li> Microwave Detection Analyser Module</li>
                <li> Full Stack Develop - Website of CSIE in YunTech</li>
                <li> Department Network Administrator in YunTech</li>
                <li> Custom Blockchain System with <b>ZooKeeper</b></li>
                <li> Blockchain Cold Wallet Transaction Module</li>
            </ol>
        </div>
        <hr>
    </div>
</div>
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}
