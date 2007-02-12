From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata_via problems in a Vintage2-AE1
Date: Mon, 12 Feb 2007 01:47:47 -0800
Message-ID: <45D037C3.3070306@gmail.com>
References: <200702090010.06897.lepalom@wol.es> <200702092109.25029.lepalom@wol.es> <45CDDA86.2000607@gmail.com> <200702121011.49818.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:60293 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbXBLJsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 04:48:05 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1767719wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 01:48:05 -0800 (PST)
In-Reply-To: <200702121011.49818.jdelvare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Leopold Palomo Avellaneda <lepalom@wol.es>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

Jean Delvare wrote:
> I've read the whole thread, the source code (quickly) and the patches to 
> ahci.c and sata_via.c, and here are some comments:
> 
> It looks like support for the VT8251 was added to the ahci driver in kernel 
> 2.6.18, and was then updated in 2.6.20. The code is different from the 
> patch Leopold is using with 2.6.16. As I am not an expert in this area, I 
> can't tell whether both versions are equivalent or not, but I'd guess so.

The differences between 2.6.16 and 2.6.20 in ahci are mostly things like 
detection fixes and hotplug handling fixes which shouldn't affect normal 
operations too much and irqpoll definitely won't fix the problem.

> On the other hand, I do not see VT8251 support in the sata_via driver in the 
> kernel, so I'm not surprised that it doesn't work properly for Leopold. But 
> again I am no expert in the area, so maybe the sata_via driver in the kernel 
> is supposed to work for VT8251-based systems. Jeff (cc'd) should know better.

vt8251 is an ahci controller so sata_via is irrelevant.

> I also see that there were many changes to these drivers post-2.6.20, so maybe 
> Leopold could give a try to Linus' latest kernel (2.6.20-git6 as I speak) and 
> see if there are any improvements.
> 
> As for the VIA IRQ quirks, the version we have in 2.6.20 does not handle the 
> VIA chips more recent than the VT8237A. If the VT8251 needs it, then we have 
> to add it. Alan?
> 
> *If* the VT8251 needs the VIA IRQ quirk, then the attached patch may help. 
> Leopold, can you give it a try?

This is where I have no clue.  :-)  Leopold, please test Jean's patch.

Thanks a lot.

-- 
tejun
