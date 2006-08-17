From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/sd*
Date: Thu, 17 Aug 2006 10:01:50 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:39332 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932271AbWHQIKZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 04:10:25 -0400
In-Reply-To: <44E3DFD6.4010504@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>> getting there.
>>
>> Yep.  /dev/disk is a long term goal :)
>>
>I agree with Adrian, users are going to get confused if their devices
>are named something different once they switch to this new interface. So
>if we're going to confusing them why not just take the big leap and
>switch it over to /dev/disk? It seems to make more sense then to have
>all IDE and SATA users use /dev/sda for awhile only to down the road
>have to to switch to /dev/disk.

In the process, we can rename the then-"generic disk" (scsi ide whatever) 
back to "hd*" since that actually expands to Hard Disk.
(If I would have known a lot earlier about Linux I would have proposed 
"id*" for the IDE disks.)


Jan Engelhardt
-- 
