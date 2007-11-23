From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: update timing and fix pata_amd transfer mode
 selection
Date: Fri, 23 Nov 2007 10:08:09 +0900
Message-ID: <474627F9.3060007@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:31338 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbXKWBIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 20:08:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3332649wah
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 17:08:20 -0800 (PST)
In-Reply-To: <1194327550227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> This patchset cleans up and improves PATA timing related code and fix
> pata_amd transfer mode selection on top of the improvements.  This
> patchset contains the following tweleve patches.
> 
>  0001-ata_generic-unindent-loop-in-generic_set_mode.patch
>  0002-libata-export-xfermode-PATA-timing-related-functi.patch
>  0003-libata-clean-up-xfermode-PATA-timing-related-stuf.patch
>  0004-libata-kill-ata_id_to_dma_mode.patch
>  0005-libata-xfer_mask-is-unsigned-int-not-unsigned-long.patch
>  0006-libata-separate-out-ata_acpi_gtm_xfermask-from-pa.patch
>  0007-libata-fix-ata_acpi_gtm_xfermask.patch
>  0008-libata-implement-ata_timing_cycle2mode-and-use-it.patch
>  0009-libata-implement-ata_acpi_init_gtm.patch
>  0010-libata-reimplement-ata_acpi_cbl_80wire-using-ata_.patch
>  0011-libata-add-ATA_CBL_PATA_IGN.patch
>  0012-pata_amd-update-mode-selection-for-NV-PATAs.patch
> 
> 0001-0005 are clean ups of timing handling code.  0006-0008 unifies
> timing handling code in libata-acpi.c and pata_acpi.c with the core
> timing code.
> 
> 0009 implements initial GTM caching.  I thought about moving this to
> LLDs but it's too much hassle.  GTM is host wide and doing it from
> ->error_handler would require cross-port synchronization.  Left
> alternative is adding a separate hook.  Simply doing it during ACPI
> attach is simpler.
> 
> 0010 reimplements ata_acpi_cbl_80wire() using ata_acpi_gtm_xfermask().
> This new function takes @gtm argument.  Both users (pata_via and
> pata_amd) are converted to pass initial GTM.
> 
> 0011 implements ATA_CBL_PATA_IGN which tells libata to ignore cable
> type and supporess all related handling.
> 
> 0012 updates mode selection for NV PATA controllers.  We just can't
> tell what cable is attached on the controller either from host or
> drive side.  So, for those controllers, pata_amd just sets cable type
> to ATA_CBL_PATA_IGN and use ->mode_filter to limit transfer mode
> according to BIOS/ACPI boot configuration.  If that fails (not
> likely), pata_amd simply sets the highest allowed speed and let EH
> figure out the mess.  With recent updates, EH should be able to figure
> it out pretty soon.
> 
> This patchset is against
> 
>    #upstream-fixes (6bbfd53d47abd1fb20d7c93a9b19a75970b66f49)
>  + update-speeddown patchset [1]
> 
>  Thanks.
> 
>  --
>  tejun

Ping.

-- 
tejun
