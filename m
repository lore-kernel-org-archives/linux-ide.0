From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: siimage and two nics
Date: Fri, 26 Dec 2003 03:48:53 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FEBAFA5.8020604@clanhk.org>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:51104 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265235AbTLZVxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2003 16:53:44 -0500
In-Reply-To: <20031226195705.B4045@nettis.grimsta>
List-Id: linux-ide@vger.kernel.org
To: Daniel Brahneborg <daniel.com@wtnord.net>
Cc: linux-ide@vger.kernel.org


>If I boot with the siimage module builtin, the kernel doesn't
>find the root device (set to /dev/hda2).
>  
>

You can't use the Via sata for the root device?  It's off the slow PCI 
bus, it'll be much faster anyway.

>As a workaround, I now skip the siimage module entirely, and only
>load the sata_via and sata_sil modules.  This makes all 4 SATA
>drives come alive as sda, sdb etc, leaving hda untouched.  I get
>50 MB/s with hdparm -tT, so it seems to work fine.
>  
>
Be careful, sata_sil is broken.  It is not stable, and has failed every 
stress test I've tried on it.  The siimage ide driver is actually stable 
around v1.09.

>New Problem:
>
>I still have a rather serious problem, also SATA related.  I want
>to have two network cards in that machine, one of them being a
>common 8139 card.  As the other one I want to use the via-rhine
>card on the motherboard.  The first network card comes alive
>without problem, but when I try to do "ifconfig eth1 up", the
>entire machine comes to a complete stop.  Not even Caps Lock work,
>and I have to power cycle it.  Two 8139 cards have the same effect.
>Removing the Silicon Image card makes it work fine.  How do I do
>to get some debug information on what happens?
>
>Here is the output from lspci -v.
>  
>
dmesg?  '/proc/version'?  newest bios?  move the sata card to a new pci 
slot?

-ryan

