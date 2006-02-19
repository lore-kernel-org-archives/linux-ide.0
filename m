From: Daniel <impulze@impulze.de>
Subject: siimage.c{,.ko} Linux Kernel IDE/PCI driver
Date: Sun, 19 Feb 2006 17:53:41 +0100
Message-ID: <200602191753.41819.impulze@impulze.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.kontent.de ([81.88.34.59]:3201 "EHLO Mail2.KONTENT.De")
	by vger.kernel.org with ESMTP id S932102AbWBSQwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Feb 2006 11:52:51 -0500
Received: from istari.mordor.net (p54A95EE9.dip.t-dialin.net [84.169.94.233])
	by Mail2.KONTENT.De (Postfix) with ESMTP id 31D2938801A
	for <linux-ide@vger.kernel.org>; Sun, 19 Feb 2006 17:52:35 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,
i first wrote this e-mail to alan@red-hat.com who replied that i should mail 
you about this. I never did this before, so i hope i'm catching the right 
person finally. First of all thanks for your work with the siimage module for 
the linux kernel.
I was just wondering if the problem i'm having is known to you or if 
it's new. My current kernel version 2.6.14 and when i compile this module 
into the kernel (not modular) then my kernel is trying to access sectors on 
both hard drives (which are connected to the pci adapter) which don't even 
exist (when mounting the device nodes in /dev).
If i compile it as modular part of the kernel and load the module after boot i 
can safely mount those without any errors. A log of what produces the output 
is somewhat not possible because it won't boot when i directly compile it 
into the kernel. 
It's reproduceable but not log-able. In your module you guys also state that 
i should check the SI support guides when i got a nVidia chipset 
(motherboard) which i do have but i couldn't find anything useful in those 
documentations. My BIOS is also up to date. Any useful information would be 
appreciated. Thanks for your time.
Greets Daniel
