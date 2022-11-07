Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB3C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 17:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKGRFh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGRFg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 12:05:36 -0500
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 09:05:35 PST
Received: from resqmta-c1p-024063.sys.comcast.net (resqmta-c1p-024063.sys.comcast.net [IPv6:2001:558:fd00:56::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0D60CD
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 09:05:35 -0800 (PST)
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
        by resqmta-c1p-024063.sys.comcast.net with ESMTP
        id s2eMojifTQSFGs5Waoht1D; Mon, 07 Nov 2022 17:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1667840584;
        bh=QRS2MnYzNGUrWr6u3D4X/ADdM0Z1NfWk5u9OUGP4ouw=;
        h=Received:Received:Message-ID:Subject:From:To:Date:Content-Type:
         MIME-Version:Xfinity-Spam-Result;
        b=G/GbDBg+b4VEGySau2ThFIg7pVyT4hSO+5RyCyJgxPTwkZNUbH6GKqTrNfjgOFQgW
         SHwykhm9U8Z1ufH5ntYaRkN1TIaVBokmk1r0Zbt1csE4SCLPZepJMhitWHynZ7mePN
         U7A8u2lqJILe5N2zgq0s9j3er9WPh1qBonx8jk2Gqbp1vjlO1zVmT4aYrpivkUQ+Ef
         B3UDdsbAWYuh3esDakbU9spxJgfH/ifeCYESj2n0RFJTlvXkJT/2K5pTjEhPnGjmz+
         QXRSkf0/wPdTlWHQGGK6wN9Q5eZwkVlg06GRQRigd4xjtuMoh7K+KfB6MiyXWeyssi
         /Cf04G4sAsRRg==
Received: from [IPv6:2001:558:6040:22:3412:4338:4dd2:4c2f]
 ([IPv6:2001:558:6040:22:3412:4338:4dd2:4c2f])
        by resomta-c1p-023269.sys.comcast.net with ESMTPSA
        id s5WEob3u2WyhAs5WZohjpK; Mon, 07 Nov 2022 17:03:03 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Message-ID: <388793c9ce6a3e9b7298e00afe37860e3dff8812.camel@nurealm.net>
Subject: Loading pata_marvell module will crash the kernel when there is an
 error reading an attached SATA drive
From:   James Feeney <james@nurealm.net>
To:     Tejun Heo <tj@kernel.org>, Alan Cox <alan@redhat.com>
Cc:     linux-ide@vger.kernel.org
Date:   Mon, 07 Nov 2022 10:02:36 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Arch Linux
linux 6.0.7.arch1-1
ASUSTeK P6T DELUXE V2

00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express
Root Port 5
        Subsystem: ASUSTeK Computer Inc. P6T Deluxe Motherboard
        Kernel driver in use: pcieport

05:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6111/6121 SATA
II / PATA Controller (rev b2)
        Subsystem: ASUSTeK Computer Inc. Device 8212
        Kernel modules: pata_marvell, pata_acpi, ata_generic

ahci driver built into kernel, but with *no* kernel command line "ahci.marv=
ell_enable=3D1"


Attaching an external SATA drive, manually loading the pata_marvell module,=
 and then failing to read the drive, the kernel will lock-up, requiring a s=
ystem reboot.  The read error appears to be triggered by a too long eSATA c=
able, since a shorter eSATA cable resolves the problem.

Alternatively, using the ahci driver instead, under the same error conditio=
n, the ahci driver simply gives-up and does not crash the kernel.

This is an obscure condition in very old hardware, but maybe somebody could=
 take a look at pata_marvell.c.  The pata_marvell driver and the ahci drive=
r respond to the error very differently - crashing the kernel or not crashi=
ng the kernel.

Loading pata_marvell, ending with a kernel lock-up, the log has:

 scsi host6: pata_marvell
 scsi host7: pata_marvell
 ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 16
 ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 16
 ata8.00: qc timeout (cmd 0xec)
 ata8.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
 ata8: link is slow to respond, please be patient (ready=3D0)
 ata8: device not ready (errno=3D-16), forcing hardreset
 ata8.00: ATA-9: WDC WD10JUCT-63CYNY0, 01.01A01, max UDMA/133
 ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
 ata8.00: qc timeout (cmd 0xec)
 ata8.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
 ata8.00: revalidation failed (errno=3D-5)
 ata8.00: limiting speed to UDMA/133:PIO3
 ata8: link is slow to respond, please be patient (ready=3D0)
 ata8: device not ready (errno=3D-16), forcing hardreset
 scsi 7:0:0:0: Direct-Access     ATA      WDC WD10JUCT-63C 1A01 PQ: 0 ANSI:=
 5
 sd 7:0:0:0: Attached scsi generic sg4 type 0
 sd 7:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
 [kernel lock-up here]


Instead, manually loading pata_marvell, with the shorter eSATA cable, and *=
no* kernel lock-up, the log has:

 scsi host6: pata_marvell
 scsi host7: pata_marvell
 ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 16
 ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 16
 ata8.00: ATA-9: WDC WD10JUCT-63CYNY0, 01.01A01, max UDMA/133
 ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
 scsi 7:0:0:0: Direct-Access     ATA      WDC WD10JUCT-63C 1A01 PQ: 0 ANSI:=
 5
 sd 7:0:0:0: Attached scsi generic sg4 type 0
 sd 7:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
 sd 7:0:0:0: [sdd] 4096-byte physical blocks
 sd 7:0:0:0: [sdd] Write Protect is off
 sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
 sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
 sd 7:0:0:0: [sdd] Preferred minimum I/O size 4096 bytes


In comparison, using the ahci driver with "ahci.marvell_enable=3D1", and wi=
th the same drive read error, the log has:

 ahci 0000:05:00.0: Disabling your PATA port. Use the boot option 'ahci.mar=
vell_enable=3D0' to avoid this.
 ahci 0000:05:00.0: controller can't do NCQ, turning off CAP_NCQ
 ahci 0000:05:00.0: controller can't do PMP, turning off CAP_PMP
 ahci 0000:05:00.0: masking port_map 0x7 -> 0x3
 ahci 0000:05:00.0: SSS flag set, parallel bus scan disabled
 ahci 0000:05:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mod=
e
 ahci 0000:05:00.0: flags: 64bit stag led slum part
 scsi host6: ahci
 scsi host7: ahci
 scsi host8: ahci
 ata7: SATA max UDMA/133 abar m1024@0xfbcffc00 port 0xfbcffd00 irq 16
 ata8: SATA max UDMA/133 abar m1024@0xfbcffc00 port 0xfbcffd80 irq 16
 ata9: DUMMY
 ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 ata7.00: qc timeout (cmd 0xec)
 ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
 ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 ata7.00: qc timeout (cmd 0xec)
 ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
 ata7: limiting SATA link speed to 1.5 Gbps
 ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata7.00: qc timeout (cmd 0xec)
 ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
 ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata8: SATA link down (SStatus 0 SControl 300)
 ata7: SATA link down (SStatus 0 SControl 300)


The ahci driver simply gives-up, and there is no kernel lock-up.  But also,=
 here, the ahci driver never actually is able to identify the hard drive, a=
nd so, never has to subsequently interact with the drive using a bad connec=
tion.

Does the pata_marvell module simply "block" forever, after partly identifyi=
ng the hard drive, and lock-up the kernel in the process?

James






