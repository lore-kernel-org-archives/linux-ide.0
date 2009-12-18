From: Xavier <shiningxc@gmail.com>
Subject: Re: storage fixup laptop model dependent ?
Date: Fri, 18 Dec 2009 14:22:58 +0100
Message-ID: <91752840912180522h32077795yba6180d6b839af64@mail.gmail.com>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>
	 <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>
	 <4B2712FE.10905@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:39159 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZLRNXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 08:23:00 -0500
Received: by fxm21 with SMTP id 21so2789774fxm.21
        for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 05:22:58 -0800 (PST)
In-Reply-To: <4B2712FE.10905@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Kel Modderman <kel@otaku42.de>

On Tue, Dec 15, 2009 at 5:39 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 12/14/2009 09:29 PM, Xavier wrote:
>>> I am just wondering : does it really matter in which laptop that di=
sk
>>> is used ? As laptop disk can be changed/replaced easily, this also
>>> sounds strange to me, but there might be a good reason I am missing=
 :)
>
> OEMs sometimes load specialized firmwares to drives and BIOS may
> configure APM differently according to drive model, so it kind of
> matters.
>

Ah ok, good to know.

>> Was it the right place for this information ?
>> I added the two people who committed to storage-fixup git, just in c=
ase.
>
> storage-fixup is at best a stop-gap measure until something better an=
d
> more intelligent comes along. =A0It might be able to serve as
> documentation later on too. =A0I don't think it would be wise to
> configure APM to certain value after matching only the drive model.
> That's too wide. =A0A good solution would be...
>
> * Build database of load cycle limits and useable APM values on drive
> =A0models.
>
> * Monitor load cycle count by smart commands and if it continues to
> =A0increase at an excessive rate, warn the user and configure higher
> =A0APM value.
>

Yes, that sounds quite good and reasonable to me.

> If you replaced the drive yourself, putting hdparm command in one of
> boot scripts should do it for now. =A0:-(
>

Well for now, I just edited storage-fixup.conf [1] but I could indeed
just run hdparm directly.

Since this is not the original disk, you think it does not deserve
being in upstream storage-fixup.conf as an additional rule [2] ?
Note that the original disk was under warranty and that the new wd
drive was shipped by dell.

[1]
rule dell-xps-m1530
dmi system-manufacturer		Dell Inc.
dmi system-product-name		XPS M1530
#ata model			SAMSUNG HM*I
ata model			WDC WD*BEVT*
act hdparm -B 254 $DEV

[2]
rule dell-xps-m1530-2
dmi system-manufacturer		Dell Inc.
dmi system-product-name		XPS M1530
ata model			WDC WD*BEVT*
act hdparm -B 254 $DEV
