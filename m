From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] New: pata_hpt370x driver doesn't want to operate with
 Adaptec 1200A at UDMA/100
Date: Wed, 12 Aug 2015 17:11:49 +0000
Message-ID: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38774 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbbHLRLv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2015 13:11:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 63C7F206A0
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 17:11:50 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 775962066E
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 17:11:49 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

            Bug ID: 102741
           Summary: pata_hpt370x driver doesn't want to operate with
                    Adaptec 1200A at UDMA/100
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.18.0-9
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: andi3@gmx.net
        Regression: No

This is an older machine. But hey, it is Linux, so we can expect a good support
instead of the common words from big players "replace your system with a more
modern one, as it's unsupported"

It's a bog-standard 1200 A "RAID" card by Adaptec. Even though I am not using
RAID at the moment, it may also operate as an add-in card for hard drives.
To minimize the mess, I have only ONE drive connected to the card right now.

The card is properly initialized using the pata_hpt370x kernel driver. However,
it will always show as UDMA/66 which simply cannot be. Of course, I've even
tried brand-new cables with it, but I think it has nothing to so with that.

The drive connected to it is a Samsung SpinPoint T133 (HD 400 LD), which
*definitly* can do UDMA/100.
The hardware is capable of doing so, too: 

# lspci -knn |grep HPT
01:09.0 Mass storage controller [0180]: HighPoint Technologies, Inc. 
HPT366/368/370/370A/372/372N [1103:0004] (rev 03)
 Subsystem: HighPoint Technologies, Inc. HPT370 UDMA100 [1103:0005]

# modinfo pata_hpt37x
filename:       /lib/modules/3.18.0-9-generic/kernel/drivers/ata/pata_hpt37x.ko
version:        0.6.23
license:        GPL
description:    low-level driver for the Highpoint HPT37x/30x
author:         Alan Cox
srcversion:     9767DBC95C3C8CD9B426A96
alias:          pci:v00001103d00000006sv*sd*bc*sc*i*
alias:          pci:v00001103d00000008sv*sd*bc*sc*i*
alias:          pci:v00001103d00000005sv*sd*bc*sc*i*
alias:          pci:v00001103d00000007sv*sd*bc*sc*i*
alias:          pci:v00001103d00000004sv*sd*bc*sc*i*
depends:        
intree:         Y
vermagic:       3.18.0-9-generic SMP mod_unload modversions 686 
signer:         Magrathea: Glacier signing key
sig_key:        64:24:93:B2:42:A8:8A:D6:3A:5D:EE:4A:7A:65:66:84:4C:ED:13:23
sig_hashalgo:   sha512

Now let's take a look at the dmesg from kernel:

[    1.992359] pata_hpt37x: HPT370 using 33MHz bus clock
[    2.015478] scsi host10: pata_hpt37x
[    2.023431] scsi host11: pata_hpt37x

[    2.023610] ata11: PATA max UDMA/66 cmd 0x8c00 ctl 0x9000 bmdma 0x9c00 irq
19
[    2.023614] ata12: PATA max UDMA/66 cmd 0x9400 ctl 0x9800 bmdma 0x9c08 irq
19

('ata12' is the Samsung drive; 'ata11' is currently empty.)

This can't be correct.
Why only at such low speed, i. e. UDMA/66?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
