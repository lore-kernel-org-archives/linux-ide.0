From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Remove obsoleted "idex=noprobe" kernel parameter
Date: Wed, 12 Mar 2008 14:35:30 +0100
Message-ID: <200803121435.30213.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:43901 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYCLNVZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 09:21:25 -0400
Received: by mu-out-0910.google.com with SMTP id i10so8280964mue.5
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 06:21:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@soyuzkt.od.ua>
Cc: linux-ide@vger.kernel.org


Hi,

On Wednesday 12 March 2008, Rus V. Brushkoff wrote:
> 
>  	Hi,
> 
>   Why this option is obsoleted ? It can be used on many systems when Linux 
> still tries to detect disabled in the BIOS IDE controller - you may 
> significantly reduce boot time, without bunch of the "ide reset succeed" 
> messages.
>   So embedded people use IDE as hardware interface to different 
> controlling systems - how they can tell Linux, now without "idex=noprobe" 
> option, not to probe _this_ IDE controller ?

"hdx=noprobe" skips probing given IDE device, if given for all devices
on the contoller, the controller will be not probed at all

[ "hdx=noprobe" will be converted soon to "ide_core.noprobe=" parameter
  as we _need_ to re-do parameters handling because the old interface
  ("hdx=" / "idex=") is not compatible with the IDE warm-plug support ]

>   So can be said about "obsoleted "idex=base[,ctl[,irq]]" kernel 
> parameters" - now nobody, who make simple custom hardware, can tell legacy 
> IDE driver about different hardware resources, which is normal for other 
> Linux subsystems - see for example LPT or most network cards kernel boot 
> parameters.

It still can be done - just they way of doing it will change:

/*
 * For special cases new interfaces may be added using sysfs, i.e.
 *
 *      echo -n "0x168:0x36e:10" > /sys/class/ide_generic/add
 *
 * will add an interface using I/O ports 0x168-0x16f/0x36e and IRQ 10.
 */

[ however the preferred solution is to add resources for your custom IDE as
  a platform resources so ide_platform host driver can use it automatically ]

Thanks,
Bart
