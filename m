From: Xavier Chantry <shiningxc@gmail.com>
Subject: Re: storage fixup laptop model dependent ?
Date: Thu, 18 Feb 2010 00:30:56 +0100
Message-ID: <b67489df1002171530o4bf26d00od51521d60e1473d6@mail.gmail.com>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:43251 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0BQXbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2010 18:31:01 -0500
Received: by fxm20 with SMTP id 20so8275655fxm.21
        for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2010 15:30:59 -0800 (PST)
In-Reply-To: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, Dec 3, 2009 at 2:33 PM, Xavier <shiningxc@gmail.com> wrote:
> Hello,
>
> I have a dell xps m1530 which had a seagate 320 gb (not sure which
> model exactly).
> Anyway that disk was working fine except the last part of the disk
> (~20gb or so) was bad and had many bad sectors.
> I just stopped to use the bad part of the disk, and I had no problems
> for almost one year. I finally decided to get it replaced, and got a
> WDC WD3200BEVT-75ZCT2 instead.
>
> I noticed directly that the disk was much more noisy, and also made a
> lot of annoying click. After a few days, I check load cycle count,
> which is pretty huge :
> =A09 Power_On_Hours =A0 =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 000=
 =A0 =A0Old_age
> Always =A0 =A0 =A0 - =A0 =A0 =A0 36
> 193 Load_Cycle_Count =A0 =A0 =A0 =A00x0032 =A0 200 =A0 200 =A0 000 =A0=
 =A0Old_age
> Always =A0 =A0 =A0 - =A0 =A0 =A0 2481
>
> I noticed this disk, or at least the pattern BEVT appear already 4
> times in storage-fixup though the 4rd occurence seems to be either a
> bug or a typo (BEVT vs BEVE) :
> # Reported drive model: WDC WD1600BEVT-75ZCT0
> ata model =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WDC WD*BEVT*
> # Reported drive model: WDC WD3200BEVT-22ZCT0
> ata model =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WDC WD*BEVT*
> # Reported drive model: WDC WD1600BEVT-22ZCT0
> ata model =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WDC WD*BEVT*
> # Reported drive model: WDC WD3200BEVT-22ZCT0
> ata model =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WDC WD*BEVE*
>
> I am just wondering : does it really matter in which laptop that disk
> is used ? As laptop disk can be changed/replaced easily, this also
> sounds strange to me, but there might be a good reason I am missing :=
)
>

This disk died after two months usage.
I don't know what I am doing wrong, or if Dell just gives my crappy
disks, or if my laptop is doing crazy things with it, or ...

The new one is TOSHIBA MK3263GSX , and I get crazy loading/unloading
with an annoying noise, just like with the WD :
193 Load_Cycle_Count        0x0032   100   100   000    Old_age
Always       -       402
In half a day...

I just noticed the Power on Hours went crazy :
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       603

I must have some magic power for destroying any hard drives that I touc=
h :)
Unless Power_On_Hours actually means Power_On_Minutes , I will monitor
that field too.

And I will just live with hdparm -B254 , no big deal !

cheers
Xavier
