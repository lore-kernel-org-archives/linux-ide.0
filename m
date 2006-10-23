From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Errors when copying between drives on a SiI3114 controller
	under kernel 2.6.18
Date: Mon, 23 Oct 2006 11:13:57 +0100
Message-ID: <1161598438.19388.7.camel@localhost.localdomain>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com>
	 <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com>
	 <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima>
	 <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com>
	 <op.thtxiw0axci36i@akima>  <453C2748.9030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7818 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751847AbWJWKKx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 06:10:53 -0400
In-Reply-To: <453C2748.9030008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jonathan Bell <doggs.lay.eggs@googlemail.com>, linux-ide@vger.kernel.org

Ar Llu, 2006-10-23 am 11:22 +0900, ysgrifennodd Tejun Heo:
> I guess it could be a PCI bus problem.  Maybe the controller and the PCI 
> bus on the board don't like each other and thing get corrupt when 
> transactions occur at high speed.  I've seen data corruption over PCI 
> bus on some pilot embedded system board.  Not sure whether such things 
> are applicable to consumer products.

>From the IDE driver...

 *      If you have strange problems with nVidia chipset systems please
 *      see the SI support documentation and update your system BIOS
 *      if neccessary


Alan

