From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] libata: modularize SFF support, take #1
Date: Tue, 25 Mar 2008 22:16:38 +0900
Message-ID: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:16439 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbYCYNRW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:22 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257948wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com

Hello, all.

This humongous patchset modularizes SFF support and cleans up whole
lot of other stuff in the course.  At the end, core layer is leaner
and simpler, SFF support is well modularized and made optional and
LLDs don't have to worry about how it's gonna meet the pseudo SFFism
libata used to require.

This patchset is comprised of the following 27 patches.

  0001-libata-drop-ata_dev_select-from-ata_dev_read_id.patch
  0002-libata-reorder-functions-in-libata-sff.c.patch
  0003-libata-reorganize-SFF-related-stuff.patch
  0004-libata-move-ata_pci_default_filter-out-of-CONFIG_.patch
  0005-libata-kill-ata_chk_status-call-from-ata_dev_conf.patch
  0006-libata-kill-ata_chk_status.patch

  0007-libata-rename-SFF-functions.patch
  0008-libata-rename-SFF-port-ops.patch

  0009-libata-clean-up-port_ops-sff_irq_clear.patch
  0010-libata-separate-out-ata_std_prereset-from-ata_sff.patch
  0011-libata-separate-out-ata_std_postreset-from-ata_sf.patch

  0012-libata-restructure-SFF-post-reset-readiness-waits.patch
  0013-libata-separate-out-ata_wait_ready-and-implement.patch
  0014-ahci-use-ata_wait_after_reset-instead-of-ata_sff_.patch
  0015-libata-move-generic-hardreset-code-from-sata_sff_ha.patch
  0016-libata-implement-and-use-sata_std_hardreset.patch
  0017-libata-clear-SError-after-link-resume.patch
  0018-libata-move-PMP-SCR-access-failure-during-reset-to.patch
  0019-libata-unify-mechanism-to-request-follow-up-SRST.patch

  0020-libata-add-qc_fill_rtf-port-operation.patch
  0021-libata-drop-finish_qc-from-ata_qc_complete_multipl.patch
  0022-libata-replace-tf_read-with-qc_fill_rtf-for-non-SFF.patch
  0023-libata-remove-check_status-from-non-SFF-drivers.patch

  0024-libata-kill-ata_noop_dev_select.patch
  0025-libata-clean-up-dummy-port_ops.patch
  0026-libata-don-t-use-ap-ioaddr-in-non-SFF-drivers.patch

  0027-libata-make-SFF-support-optional.patch

0001-0006 prepare for the soon-to-follow changes by dropping
unncessary stuff and reorganizing code.

0007-0008 mass renames SFF related stuff.  Over the time, the naming
has become quite chaotic.  Core and SFF stuff are mixed and various
prefixes are in use pseudo-randomly.  These two patches make the names
consistent.  By doing so make it clear which belongs where - ie. it
sets the requirements for the soon-to-follow modularization.  Stuff
named with SFF and BMDMA prefixes should only live in libata-sff.c and
can't be directly referenced from core layer.

  0009-0011 separate out SFF specific parts regarding ->sff_irq_clear,
  prereset and postreset.

  0012-0019 refactor post-reset wait code, separate out SFF specific
  parts regarding resets and clean up resulting code.

  0020-0023 separate out TF access code out of core layer.

  0024-0026 separate out what's left of SFF from core layer.

  0027 makes SFF support optional.

The patchset has been tested on the following LLDs.

  ahci, ata_piix, sata_sil, sata_sil24, pdc_adma, pata_hpt366,
  sata_promise, pata_jmicron

sata_fsl, ipr and libsas received good amount of modification but I
couldn't test them.  Especially, I couldn't even compile test
sata_fsl.  If you have access to the above drivers, please verify they
are okay.

On x86_64 w/o any debugging turned on, on-disk size of libata.ko is
reduced from 226k to 193k if SFF is turned off.  The loaded size is
changed from 157k to 133k.

This patchset is on top of

  upstream-fixes (4cde32fc4b32e96a99063af3183acdfd54c563f0)
+ prefer-hardreset (990d6db0af21830681157317ab58c10f80277cb8)
+ cleanup-sht-ops (ed75ba53c883bc7a63fa1b60c63f33fcf395e751)
+ [1] cleanup-pdc_adma

This patchset is available as git tree.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=modularize-SFF
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git modularize-SFF

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/29978
