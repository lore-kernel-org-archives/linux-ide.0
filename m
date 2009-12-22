From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: storage fixup laptop model dependent ?
Date: Mon, 21 Dec 2009 18:43:50 -0600
Message-ID: <4B301646.6080006@gmail.com>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>	 <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>	 <4B2712FE.10905@kernel.org> <91752840912180522h32077795yba6180d6b839af64@mail.gmail.com> <4B2EFAE9.3080406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:43988 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbZLVAnw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2009 19:43:52 -0500
Received: by gxk3 with SMTP id 3so53375gxk.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Dec 2009 16:43:52 -0800 (PST)
In-Reply-To: <4B2EFAE9.3080406@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Xavier <shiningxc@gmail.com>, linux-ide@vger.kernel.org, Kel Modderman <kel@otaku42.de>, mzxreary@0pointer.de, Kay Sievers <kay.sievers@vrfy.org>

On 12/20/2009 10:34 PM, Tejun Heo wrote:
> (cc'ing Kay and Lennart.  Hello.)
>
> This thread was discussing about drives which unload heads too
> frequently.  These problems happen mostly on laptops.  Either mobile
> HDDs default to too aggressive power saving or laptop firmware
> configures them that way.  Anyways, some drives end up unoading and
> reloading the head more quite a few times per minute.
>
> Mobile drives tend to have higher load cycle limits than desktop ones
> and this information can be found from drive specs published on vendor
> websites.  Most modern mobile ones seem to be rated for 600,000
> cycles.  Unfortunately, with 5 unloads per minute, the drive will
> reach its rated limit only after 83 days of uptime.  IOW, if you use
> the machine 8hrs per day, it will expire before one year has passed.
>
> Very short unload timeout is inherently dangerous as idle IO patterns
> can differ depending on a lot of things and these rapid load/unload
> cycles can happen under various different configurations (it happens
> under windows too).  When this problem first appeared, I thought
> vendors would realize the danger and it would go away sooner or later.
>
> Expecting it to be a temporary problem, I wrote up a simple script
> named storage-fixup which matches the system and harddrive model and
> issues safe powersave configuration.  This is a crude and sub-optimal
> solution which doesn't scale too well.  Many of those configurations
> wouldn't require such APM adjustments and a lot of configurations
> where APM re-configuration is required are out there killing their
> drives.
>
> A proper solution would be....
>
> * Build database of load cycle limits and useable APM values on drive
>    models.  The former shouldn't be difficult.  Each vendor carries
>    only a few product lines at any given time and publish datasheets on
>    the webpage.  Plus, all the mobile drives I've seen are rated for
>    600,000 cycles.  The latter may be a bit more tricky.  Depending on
>    drive model, certain APM values simply don't work (e.g. 255 means
>    max power by spec but some firmwares wrap the value and recognize it
>    as min power), some values overheats the device and so on.  In most
>    cases the value 254 seems safe tho.  storage-fixup.conf should be
>    useable as the source for useable values, I think.
>
> * Monitor load cycle count by smart commands and if it continues to
>    increase at an excessive rate (e.g. such that it reduces uptime to
>    under a year), warn the user and configure higher APM value.
>
> As this problem mostly happens on laptops, I think it's probably best
> to handle this from the new desktop disk management thing so that the
> user can be warned.  Do you think it's feasible to handle this from
> devkit?

I think that would be a good approach if we can do it. The situation 
definitely isn't ideal though. Has anyone approached any of the laptop 
manufacturers or drive manufacturers regarding this problem? I suspect 
there's probably a lack of awareness about it. (Though it could just be 
that Windows usually accesses the drive so often that it just never 
really reaches the unload timeouts..)
