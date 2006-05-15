From: Tejun Heo <htejun@gmail.com>
Subject: [git-patches] EH, irq-pio merge and NCQ patches
Date: Mon, 15 May 2006 21:08:08 +0900
Message-ID: <20060515120808.GA23124@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:7362 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWEOMIP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 08:08:15 -0400
Received: by wx-out-0102.google.com with SMTP id i29so105698wxd
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 05:08:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello, Jeff.

This is the updated git-patches of previously posted five
patchsets[1].  Changes are

* SCSI-implement-host_eh_scheduled patch updated as discussed.

* A new patch, which renames ata_down_sata_spd_limit() and friends to
  sata_*(), is added to prep patchset.

* ata_scr_*() renamed to sata_scr_*()

* ehc->flags has been moved to ehi->flags so that it can also be used
  to pass flags from IRQ handler to EH.

* Spurious ata_dev_init() prototype killed from ering patch.

* ata_ering is changed to include #ATA_ERING_SIZE predefined ering
  entries.  As this makes add-dev-ering patch trivial, the patch is
  collapsed into implement-ering.

* sata_sil EH now directly calls ata_bmdma_irq_clear() instead of
  calling ops->irq_clear().

I didn't add DMA engine stopping to ata_bmdma_freeze() in this series.
When BMDMA engine is turned off, all status bits go too.  However, the
status is used by BMDMA EH to report and to recognize host bus error
reprsented as timeout.

To make all of them work, the BMDMA status needs to be stored in
ata_bmdma_freeze() and used in EH, which is currently a bit difficult
to implement for generic BMDMA.  I think we can resolve this later.

The series can be browsed at the following URL.

	http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff

If you're satisfied with the updates, please pull from.

	git://htj.dyndns.org/libata-tj for-jeff

The tree is tagged with the following.

	fj-prep
	fj-eh-fw
	fj-eh
	fj-merge-irq-pio
	fj-ncq

Thanks.

[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011

-- 
tejun
