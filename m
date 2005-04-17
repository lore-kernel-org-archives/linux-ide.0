From: sean <seandarcy2@gmail.com>
Subject: 2.6.12-rc2 ahci and piix modules fail on ich6r
Date: Sun, 17 Apr 2005 16:12:00 -0400
Message-ID: <d3ufn6$da1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35753 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261524AbVDQUZI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2005 16:25:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DNGG2-0007t1-KL
	for linux-ide@vger.kernel.org; Sun, 17 Apr 2005 22:20:42 +0200
Received: from ool-4356fcdd.dyn.optonline.net ([67.86.252.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 17 Apr 2005 22:20:42 +0200
Received: from seandarcy2 by ool-4356fcdd.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 17 Apr 2005 22:20:42 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a gigabyte GA-8i915g Pro mobo, with a 82801FR (ICH6) 
hub  (checked with lspci).  One SATA Maxtor 6B300S0. I've 
used the ata-piix compiled in the past ( not as a module). 
That worked.

So, messing around I rebuilt with support for the ahci 
module in 2.6.12-rc2 and left in the ata-piix module.

This is the boot drive, and it fails. If I rebuild again 
without the ahci module ( same config otherwise - ata -piix 
as a module ) it still fails!

BTW, the RedHat fedora fc4 kernels fail. It's the same 
problem since they're module based.  But, the fc3 kernels 
work. Odd

So I rebuilt again with ahci built in - no ata-piix.  That 
failed.  Then I tried BOTH. That worked.  dmesg shows:

libata version 1.10 loaded.
ata_piix version 1.03

To sum up, the only way I've been able to boot is using 
ata-piix built in - not as a module.

And ahci won't load with ich6.

sean

