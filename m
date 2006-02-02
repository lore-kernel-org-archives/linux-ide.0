From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 08:46:31 +0000
Message-ID: <43E1C6E7.6090506@projecthugo.co.uk>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.ifl.net ([213.18.248.106]:55455 "EHLO mx3.ifl.net")
	by vger.kernel.org with ESMTP id S1423058AbWBBIqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 03:46:39 -0500
Received: from [194.238.49.3] (beng-03.stn.ab2.ifl.net [194.238.49.3])
	by mx3.ifl.net (8.12.10/8.12.10) with ESMTP id k128kV92025868
	for <linux-ide@vger.kernel.org>; Thu, 2 Feb 2006 08:46:34 GMT
In-Reply-To: <43E145B8.6090404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


>
> Your BMDMA controller is reporting raised interrupt (0x4) and your 
> drive is saying that it's ready for the next command, yet interrupt 
> handler of sata_via hasn't run and thus the timeout.  It looks like 
> some kind of IRQ routing problem to me although I have no idea how the 
> problem doesn't affect the boot process.
>
> Can you try to boot with boot parameter pci=noacpi?


I have got 2.6.13 - 2.6.14 and 2.6.15 working on the a8v board in both 
32 and 64bit mode.

Matt

