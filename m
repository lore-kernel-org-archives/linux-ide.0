From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 51841] New: sata_sil falls off some time after boot
Date: Wed, 19 Dec 2012 18:55:53 +0000 (UTC)
Message-ID: <bug-51841-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47326 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab2LSS4A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Dec 2012 13:56:00 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5388A202D3
	for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2012 18:55:56 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 092CF202BD
	for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2012 18:55:54 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=51841

           Summary: sata_sil falls off some time after boot
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.5.4-r1 Hardened
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: vprisivko@gmail.com
        Regression: No


I use Sil3512 SATA PCI Host Controller
(http://www.siliconimage.com/products/product.aspx?pid=29).

One HDD of 400GB capacity is attached to it and is represented as /dev/sdd by
udev after boot. However, soon after boot it disappears with the following
messages in dmesg:

[ 1599.097939] ata6: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe
frozen
[ 1599.097946] ata6: SError: { PHYRdyChg CommWake }
[ 1599.097960] ata6: hard resetting link[ 1599.820040] ata6: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
[ 1604.823155] ata6.00: qc timeout (cmd 0xa1)
[ 1604.823163] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 1604.823167] ata6.00: revalidation failed (errno=-5)
[ 1604.823177] ata6: hard resetting link
[ 1605.128037] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1615.131032] ata6.00: qc timeout (cmd 0xa1)
[ 1615.131040] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 1615.131044] ata6.00: revalidation failed (errno=-5)
[ 1615.131056] ata6: hard resetting link
[ 1615.436038] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1615.458298] ata6.00: failed to read native max address (err_mask=0x1)
[ 1615.458302] ata6.00: HPA support seems broken, skipping HPA handling
[ 1615.458310] ata6.00: configured for UDMA/100
[ 1615.458318] ata6: EH complete
[ 1788.761189] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2450000 action 0xe
frozen
[ 1788.761196] ata6: SError: { PHYRdyChg CommWake Handshk UnrecFIS }
[ 1788.761211] ata6: hard resetting link
[ 1789.484037] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1789.506062] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 1789.506067] ata6.00: revalidation failed (errno=-2)
[ 1794.484030] ata6: hard resetting link
[ 1794.789034] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1794.814065] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 1794.814070] ata6.00: revalidation failed (errno=-2)
[ 1799.789025] ata6: hard resetting link
[ 1800.094035] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1805.132154] ata6.00: qc timeout (cmd 0xa1)
[ 1805.132162] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 1805.132165] ata6.00: revalidation failed (errno=-5)
[ 1805.132169] ata6.00: disabled
[ 1805.132182] ata6: hard resetting link
[ 1805.437036] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1805.478060] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 1805.478074] ata6: EH complete
[ 1805.478087] ata6.00: detaching (SCSI 5:0:0:0)
[ 1805.479370] sd 5:0:0:0: [sdd] Synchronizing SCSI cache
[ 1805.479450] sd 5:0:0:0: [sdd]  
[ 1805.479455] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1805.479459] sd 5:0:0:0: [sdd] Stopping disk
[ 1805.479481] sd 5:0:0:0: [sdd] START_STOP FAILED
[ 1805.479495] sd 5:0:0:0: [sdd]  
[ 1805.479497] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1961.892254] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2450000 action 0xe
frozen
[ 1961.892262] ata6: SError: { PHYRdyChg CommWake Handshk UnrecFIS }
[ 1961.892278] ata6: hard resetting link
[ 1962.615039] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1962.637057] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 1962.637068] ata6: EH complete
[ 1994.433102] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2410000 action 0xe
frozen
[ 1994.433109] ata6: SError: { PHYRdyChg Handshk UnrecFIS }
[ 1994.433125] ata6: hard resetting link
[ 1995.156037] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2000.156159] ata6.00: qc timeout (cmd 0xec)
[ 2000.156167] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 2000.156177] ata6: hard resetting link
[ 2000.461036] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2000.502056] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 2000.502066] ata6: EH complete
[ 2070.269483] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2410000 action 0xe
frozen
[ 2070.269490] ata6: SError: { PHYRdyChg Handshk UnrecFIS }
[ 2070.269506] ata6: hard resetting link
[ 2070.992037] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2071.144055] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 2071.144066] ata6: EH complete
[ 2088.720463] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2410000 action 0xe
frozen
[ 2088.720470] ata6: SError: { PHYRdyChg Handshk UnrecFIS }
[ 2088.720486] ata6: hard resetting link
[ 2089.443037] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2094.481156] ata6.00: qc timeout (cmd 0xa1)
[ 2094.481163] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 2094.481174] ata6: hard resetting link
[ 2094.786035] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2104.805030] ata6.00: qc timeout (cmd 0xa1)
[ 2104.805038] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 2104.805050] ata6: hard resetting link
[ 2105.365044] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2105.517059] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 2105.517069] ata6: EH complete
[ 2180.001804] ata6: exception Emask 0x10 SAct 0x0 SErr 0x2450000 action 0xe
frozen
[ 2180.001811] ata6: SError: { PHYRdyChg CommWake Handshk UnrecFIS }
[ 2180.001828] ata6: hard resetting link
[ 2180.724039] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2185.743158] ata6.00: qc timeout (cmd 0xa1)
[ 2185.743165] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[ 2185.743176] ata6: hard resetting link
[ 2186.303043] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2186.455057] ata6.00: both IDENTIFYs aborted, assuming NODEV
[ 2186.455068] ata6: EH complete

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
