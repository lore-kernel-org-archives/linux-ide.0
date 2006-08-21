From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/sd*
Date: Mon, 21 Aug 2006 08:17:26 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608210816400.11370@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch>
 <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
 <1155913072.28764.3.camel@localhost.localdomain>
 <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
 <1155920541.30279.11.camel@localhost.localdomain> <44E94CE0.8010006@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030199AbWHUGZX@vger.kernel.org>
In-Reply-To: <44E94CE0.8010006@PicturesInMotion.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>>> Whatever udev does currently seems good:
>>>
>>> 17:48 shanghai:~ > ls /dev/disk/by-id/*
>>> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026
>>> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026-part1
>>> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287
>>> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287-part1
>>
>> I wouldn't try that on a typical "non technical user", at least except
>> for Halloween 8)
>>
>Why not make libata use /dev/disk by default and have a kernel option
>for legacy naming(ide disks are hda, sata are sda etc)?

The kernel does not really know about device names.
It is all udev that manages it. Or the user, in case he can manage to get fixed
device numbers.


Jan Engelhardt
-- 
