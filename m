From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Errors when copying between drives on a SiI3114 controller
	under kernel 2.6.18
Date: Mon, 23 Oct 2006 15:09:55 +0100
Message-ID: <1161612595.19388.33.camel@localhost.localdomain>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com>
	 <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com>
	 <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima>
	 <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com>
	 <op.thtxiw0axci36i@akima> <453C2748.9030008@gmail.com>
	 <1161598438.19388.7.camel@localhost.localdomain>  <op.thvmp9mrxci36i@akima>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13027 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964867AbWJWOGw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 10:06:52 -0400
In-Reply-To: <op.thvmp9mrxci36i@akima>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Ar Llu, 2006-10-23 am 14:35 +0100, ysgrifennodd Jonathan Bell:
> BIOS for the A7N8X is the latest 1008 version which overcomes a boot  
> limitation - the board would not boot with more than 1 SATA controller  
> installed.
> 
> This RAID corruption bug was supposedly fixed in 1005.

But this is a BIOS so was it unfixed again in 1006 ?

Also for that matter, does anyone in Nvidia know and want to explain
what was wrong in those BIOSes and what we can do in Linux to
handle/correct the situation ?

