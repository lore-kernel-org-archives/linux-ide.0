From: "Eric Vaughan" <Vaughan@iomega.com>
Subject: SiS 964 hang during mount
Date: Tue, 25 Jan 2005 15:32:35 -0700
Message-ID: <C815CE4647F1E64B894D8E0C171943F54883D4@royntex01.iomegacorp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-mx1.iomega.com ([147.178.1.72]:1195 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262207AbVAYWcj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jan 2005 17:32:39 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 5044C19D9
	for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2005 15:32:35 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 401366E1
	for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2005 22:32:35 +0000 (UTC)
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, 
  I have a Serial ATAPI disk drive attached to an SiS 964 SATA
controller.  I have ATA_ENABLE_ATAPI #defined in libata.h.  This is
2.6.10, by the way.  When I mount the device, it hangs.  I turned on
verbose debugging, and just before the hang, I get an assertion failure
in libata-core.c, line 2675, where it is asserting that qc->flags
contain the ATA_QCFLAG_ACTIVE flag.  Here's a little context around the
failure:

ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata_host_intr: ata5: host_stat 0x4
ata_host_intr: ata5: protocol 7 (dev_stat 0x50)
ata_sg_cleanup: unmapping 1 sg elements
ata_qc_complete: EXIT
ata5: command 0xa0 timeout, stat 0x50 host_stat 0x1
Assertion failed! Qc->flags &
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=2675
ata_qc_complete: EXIT
ata_qc_timeou: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT

I'm working on a way to get all the output from the environment I'm
using.  Do you need more?  Or is this enough info?  Is the assertion
failure even relevant?  Let me know if there's anything else I can do to
help you resolve this issue.

Thanks,
J. Eric Vaughan
Iomega Corporation
