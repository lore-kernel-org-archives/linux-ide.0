From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata update 20040515-1
Date: 16 May 2004 07:31:26 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084714286.3259.5.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:21125 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263607AbUEPNbs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 09:31:48 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> The attached patch ... sent to Linus
> earlier day, and should appear upstream
> vaguely soon.
>
> Patches should be
> based off of 2.6.6-bk + this patch.

I believe this patch was applied to create 2.6.6-bk3, because its -R
reverse applies clean there.

I will therefore begin again from -bk3.  -bk1 and -bk2 are not easy
options for me, because this patch does not apply clean there. 
Hopefully the -bk2 *NULL of ata_qc_issue_prot I saw is gone, else I'll
have to solve that before I can progress in -bk3.

Pat LaVarre

$ cd linux-2.6.6-bk3/
$ patch --dry-run -R -p1 <~/20040515-1.patch
patching file drivers/scsi/ata_piix.c
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
patching file drivers/scsi/libata.h
patching file drivers/scsi/sata_promise.c
patching file drivers/scsi/sata_sil.c
patching file drivers/scsi/sata_sis.c
patching file drivers/scsi/sata_svw.c
patching file drivers/scsi/sata_sx4.c
patching file drivers/scsi/sata_via.c
patching file drivers/scsi/sata_vsc.c
patching file include/linux/libata.h
$


