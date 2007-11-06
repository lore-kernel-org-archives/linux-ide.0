From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: update timing and fix pata_amd transfer mode selection
Date: Tue,  6 Nov 2007 14:38:58 +0900
Message-ID: <1194327550227-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:7420 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXKFFjN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 00:39:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org


Hello,

This patchset cleans up and improves PATA timing related code and fix
pata_amd transfer mode selection on top of the improvements.  This
patchset contains the following tweleve patches.

 0001-ata_generic-unindent-loop-in-generic_set_mode.patch
 0002-libata-export-xfermode-PATA-timing-related-functi.patch
 0003-libata-clean-up-xfermode-PATA-timing-related-stuf.patch
 0004-libata-kill-ata_id_to_dma_mode.patch
 0005-libata-xfer_mask-is-unsigned-int-not-unsigned-long.patch
 0006-libata-separate-out-ata_acpi_gtm_xfermask-from-pa.patch
 0007-libata-fix-ata_acpi_gtm_xfermask.patch
 0008-libata-implement-ata_timing_cycle2mode-and-use-it.patch
 0009-libata-implement-ata_acpi_init_gtm.patch
 0010-libata-reimplement-ata_acpi_cbl_80wire-using-ata_.patch
 0011-libata-add-ATA_CBL_PATA_IGN.patch
 0012-pata_amd-update-mode-selection-for-NV-PATAs.patch

0001-0005 are clean ups of timing handling code.  0006-0008 unifies
timing handling code in libata-acpi.c and pata_acpi.c with the core
timing code.

0009 implements initial GTM caching.  I thought about moving this to
LLDs but it's too much hassle.  GTM is host wide and doing it from
->error_handler would require cross-port synchronization.  Left
alternative is adding a separate hook.  Simply doing it during ACPI
attach is simpler.

0010 reimplements ata_acpi_cbl_80wire() using ata_acpi_gtm_xfermask().
This new function takes @gtm argument.  Both users (pata_via and
pata_amd) are converted to pass initial GTM.

0011 implements ATA_CBL_PATA_IGN which tells libata to ignore cable
type and supporess all related handling.

0012 updates mode selection for NV PATA controllers.  We just can't
tell what cable is attached on the controller either from host or
drive side.  So, for those controllers, pata_amd just sets cable type
to ATA_CBL_PATA_IGN and use ->mode_filter to limit transfer mode
according to BIOS/ACPI boot configuration.  If that fails (not
likely), pata_amd simply sets the highest allowed speed and let EH
figure out the mess.  With recent updates, EH should be able to figure
it out pretty soon.

This patchset is against

   #upstream-fixes (6bbfd53d47abd1fb20d7c93a9b19a75970b66f49)
 + update-speeddown patchset [1]

 Thanks.

 --
 tejun

 [1] http://thread.gmane.org/gmane.linux.ide/24497
