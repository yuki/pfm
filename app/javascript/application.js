// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"

/*!
* Color mode toggler for Bootstrap's docs (https://getbootstrap.com/)
* Copyright 2011-2022 The Bootstrap Authors
* Licensed under the Creative Commons Attribution 3.0 Unported License.
* 
* Ruben: There are few modifications because my HTML template is different.
*/

(() => {
    'use strict'

    const storedTheme = localStorage.getItem('theme')
    
    const getPreferredTheme = () => {
        if (storedTheme) {
        return storedTheme
        }
    
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }
    
    const setTheme = function (theme) {
        if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.setAttribute('data-bs-theme', 'dark')
        } else {
        document.documentElement.setAttribute('data-bs-theme', theme)
        }
    }
    
    setTheme(getPreferredTheme())
    
    const showActiveTheme = theme => {
        const activeThemeIcon = document.querySelector('.theme-icon-active')
        //this line doesn't work for me, so I changed a bit
        //const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        const btnToActive = document.querySelector('[data-bs-theme-value="'+theme+'"]')
        const svgOfActiveBtn = btnToActive.getAttribute('href')
    
        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
            element.classList.remove('active')
        })
    
        btnToActive.classList.add('active')
        activeThemeIcon.innerHTML=""
        activeThemeIcon.setAttribute('href', svgOfActiveBtn)
        const i = document.createElement("i")
        i.setAttribute('class','opacity-50 theme-icon '+svgOfActiveBtn)
        activeThemeIcon.append(i)
    }
    
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        if (storedTheme !== 'light' || storedTheme !== 'dark') {
        setTheme(getPreferredTheme())
        }
    })
    
    window.addEventListener('DOMContentLoaded', () => {
        showActiveTheme(getPreferredTheme())
    
        document.querySelectorAll('[data-bs-theme-value]')
        .forEach(toggle => {
            toggle.addEventListener('click', () => {
            const theme = toggle.getAttribute('data-bs-theme-value')
            localStorage.setItem('theme', theme)
            setTheme(theme)
            showActiveTheme(theme)
            })
        })
    })
})()

// tooltips
// FIXME: hay un error en /accounts
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
