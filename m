From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Sat, 4 Aug 2007 01:01:34 +0200
Message-ID: <200708040101.34574.bzolnier@gmail.com>
References: <200707270222.28230.bzolnier@gmail.com> <200707272119.19438.bzolnier@gmail.com> <46AB91A2.6060303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:6096 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762595AbXHCXER (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 19:04:17 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1186455mue
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 16:04:15 -0700 (PDT)
In-Reply-To: <46AB91A2.6060303@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org


Hi,

On Saturday 28 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>On Fri, 27 Jul 2007 02:22:27 +0200
> >>Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> >>>* Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.
> 
> >>>* Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
> >>>  host for the transfer mode after programming the device.  Set it in
> >>>  au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.
> 
> >>The CS5530 at least shouldn't care what order changes are done. I don't
> 
>     And neither CS5535. And Au1200 static bus controller shouldn't care about 
> the order too, so au1xxx-ide hardly needs that.
> 
> Here's the datasheet, BTW:
> 
> http://www.razamicroelectronics.com/documents/32798e_Au1200_db.pdf
> 
> >>think the SC1200 does either but I don't have the docs to hand.
> 
>     It seems pretty much alike CS553x except it's accessed via PCI config. 
> space, not MSRs... Here's the datasheet:
> 
> http://www.amd.com/files/connectivitysolutions/geode/32579B_sc1200_ds.pdf

Thanks for links to specs.

>     I have a feeling that only pdc202xx_new and jmicron drivers actually need 
> this flag (and the latter one actually doesn't care as its methods are empty 
> anyway).  Well, AMD/VIA chips enable UltraDMA mode by snooping Set Features 
> command (as the drivers tell them to do so), so the order seems important 
> unless that is changed.

Since changing of order affects the way in which hardware is accessed
I prefer to keep such changes out of this patch (which is just a cleanup).

Could you please handle them in pre or post patch(es)?

Bart
