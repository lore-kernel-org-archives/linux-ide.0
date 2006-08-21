From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: /dev/sd*
Date: Mon, 21 Aug 2006 02:04:16 -0400
Message-ID: <44E94CE0.8010006@PicturesInMotion.net>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de>
 <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de>
 <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org>
 <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
 <44E42900.1030905@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch>
 <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
 <1155913072.28764.3.camel@localhost.localdomain>
 <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
 <1155920541.30279.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:62911 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932601AbWHUGDv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Aug 2006 02:03:51 -0400
In-reply-to: <1155920541.30279.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 17:51 +0200, ysgrifennodd Jan Engelhardt:
>   
>> Whatever udev does currently seems good:
>>
>> 17:48 shanghai:~ > ls /dev/disk/by-id/*
>> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026
>> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026-part1
>> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287
>> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287-part1
>>     
>
> I wouldn't try that on a typical "non technical user", at least except
> for Halloween 8)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Why not make libata use /dev/disk by default and have a kernel option
for legacy naming(ide disks are hda, sata are sda etc)?
