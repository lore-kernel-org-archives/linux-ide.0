From: Tejun Heo <tj@kernel.org>
Subject: Re: storage fixup laptop model dependent ?
Date: Mon, 21 Dec 2009 13:34:49 +0900
Message-ID: <4B2EFAE9.3080406@kernel.org>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>	 <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>	 <4B2712FE.10905@kernel.org> <91752840912180522h32077795yba6180d6b839af64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34854 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbZLUEcI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Dec 2009 23:32:08 -0500
In-Reply-To: <91752840912180522h32077795yba6180d6b839af64@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xavier <shiningxc@gmail.com>
Cc: linux-ide@vger.kernel.org, Kel Modderman <kel@otaku42.de>, mzxreary@0pointer.de, Kay Sievers <kay.sievers@vrfy.org>

(cc'ing Kay and Lennart.  Hello.)

This thread was discussing about drives which unload heads too
frequently.  These problems happen mostly on laptops.  Either mobile
HDDs default to too aggressive power saving or laptop firmware
configures them that way.  Anyways, some drives end up unoading and
reloading the head more quite a few times per minute.

Mobile drives tend to have higher load cycle limits than desktop ones
and this information can be found from drive specs published on vendor
websites.  Most modern mobile ones seem to be rated for 600,000
cycles.  Unfortunately, with 5 unloads per minute, the drive will
reach its rated limit only after 83 days of uptime.  IOW, if you use
the machine 8hrs per day, it will expire before one year has passed.

Very short unload timeout is inherently dangerous as idle IO patterns
can differ depending on a lot of things and these rapid load/unload
cycles can happen under various different configurations (it happens
under windows too).  When this problem first appeared, I thought
vendors would realize the danger and it would go away sooner or later.

Expecting it to be a temporary problem, I wrote up a simple script
named storage-fixup which matches the system and harddrive model and
issues safe powersave configuration.  This is a crude and sub-optimal
solution which doesn't scale too well.  Many of those configurations
wouldn't require such APM adjustments and a lot of configurations
where APM re-configuration is required are out there killing their
drives.

A proper solution would be....

* Build database of load cycle limits and useable APM values on drive
  models.  The former shouldn't be difficult.  Each vendor carries
  only a few product lines at any given time and publish datasheets on
  the webpage.  Plus, all the mobile drives I've seen are rated for
  600,000 cycles.  The latter may be a bit more tricky.  Depending on
  drive model, certain APM values simply don't work (e.g. 255 means
  max power by spec but some firmwares wrap the value and recognize it
  as min power), some values overheats the device and so on.  In most
  cases the value 254 seems safe tho.  storage-fixup.conf should be
  useable as the source for useable values, I think.

* Monitor load cycle count by smart commands and if it continues to
  increase at an excessive rate (e.g. such that it reduces uptime to
  under a year), warn the user and configure higher APM value.

As this problem mostly happens on laptops, I think it's probably best
to handle this from the new desktop disk management thing so that the
user can be warned.  Do you think it's feasible to handle this from
devkit?

On 12/18/2009 10:22 PM, Xavier wrote:
> On Tue, Dec 15, 2009 at 5:39 AM, Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> On 12/14/2009 09:29 PM, Xavier wrote:
>>>> I am just wondering : does it really matter in which laptop that disk
>>>> is used ? As laptop disk can be changed/replaced easily, this also
>>>> sounds strange to me, but there might be a good reason I am missing :)
>>
>> OEMs sometimes load specialized firmwares to drives and BIOS may
>> configure APM differently according to drive model, so it kind of
>> matters.
> 
> Ah ok, good to know.

And the above was my rationale for matching the drive model.  Another
thing was that I really wanted to avoiding forcing APM setting to a
very conserative value where not necessary.

>>> Was it the right place for this information ?
>>> I added the two people who committed to storage-fixup git, just in case.
>>
>> storage-fixup is at best a stop-gap measure until something better and
>> more intelligent comes along.  It might be able to serve as
>> documentation later on too.  I don't think it would be wise to
>> configure APM to certain value after matching only the drive model.
>> That's too wide.  A good solution would be...
>>
>> * Build database of load cycle limits and useable APM values on drive
>>  models.
>>
>> * Monitor load cycle count by smart commands and if it continues to
>>  increase at an excessive rate, warn the user and configure higher
>>  APM value.
>>
> 
> Yes, that sounds quite good and reasonable to me.
> 
>> If you replaced the drive yourself, putting hdparm command in one of
>> boot scripts should do it for now.  :-(
>>
> 
> Well for now, I just edited storage-fixup.conf [1] but I could indeed
> just run hdparm directly.
> 
> Since this is not the original disk, you think it does not deserve
> being in upstream storage-fixup.conf as an additional rule [2] ?

Unfortunately, yeah, for now.

Let's see if we can find a scaleable solution.

Thanks.

-- 
tejun
