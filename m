From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/sd*
Date: Thu, 17 Aug 2006 11:21:18 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:43679 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964771AbWHQJ12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 05:27:28 -0400
In-Reply-To: <44E42900.1030905@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>> In the process, we can rename the then-"generic disk" (scsi ide whatever) 
>> back to "hd*" since that actually expands to Hard Disk.
>> (If I would have known a lot earlier about Linux I would have proposed 
>> "id*" for the IDE disks.)
>>
>Actually that does make more sense then using disk. So I guess we're
>back to square one. Personally I don't think its that big of a deal, all
>you have to do is change fstab and grub or lilo. My main concern is for
>the less advanced Linux users.

Less advanced users should use the upgrade tools their distribution 
provides.


Jan Engelhardt
-- 
