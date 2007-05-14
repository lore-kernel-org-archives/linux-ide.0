From: "Rune Torgersen" <runet@innovsys.com>
Subject: Libata state machine error in 2.6.18.1
Date: Mon, 14 May 2007 10:59:50 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B02E898EB@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:57619 "EHLO
	mail.innovsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757490AbXENQOB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 12:14:01 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi
We're running 2.6.18 on an inhouse devloped embeded board.
CPU is a Freescale 8280, and we have a SIL3124 controller talking to a
Hitachi 320GB (Hitachi HDT725032VLA360) disk.

Once in a while we get the following error while formatiing the drive:

ata2: illegal qc_active transition (00000002->00000008)
ata2.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action 0x2 frozen
ata2.00: tag 1 cmd 0x61 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/100
ata2: EH complete


Is this hardware (cabling, supply voltage) or software related?

