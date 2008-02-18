From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH-RESEND] next-20080218 build failure at pmac_ide_macio_attach ()
Date: Mon, 18 Feb 2008 22:36:18 +0530
Message-ID: <20080218170618.GA7435@linux.vnet.ibm.com>
References: <20080218140159.GA31310@linux.vnet.ibm.com> <jeodae4acy.fsf@sykes.suse.de>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:51419 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYBRRG0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 12:06:26 -0500
Content-Disposition: inline
In-Reply-To: <jeodae4acy.fsf@sykes.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, apw@shadowen.org

On Mon, Feb 18, 2008 at 03:17:49PM +0100, Andreas Schwab wrote:
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
> 
.
.
<snip>
> Just remove the cast.
> 
> Andreas.

Resending the patch after making the changes Andreas said.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Andreas Schwab <schwab@suse.de>
--
--- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 22:24:49.000000000 +0530
+++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 22:25:10.000000000 +0530
@@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	int irq, rc;
 	hw_regs_t hw;
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
@@ -1229,7 +1229,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		return -ENODEV;
 	}
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
