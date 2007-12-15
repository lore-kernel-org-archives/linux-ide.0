From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstram-fixes] libata-acpi: improve ACPI corner case handling, take #2
Date: Sat, 15 Dec 2007 15:04:56 +0900
Message-ID: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:53382 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbXLOGFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193509rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:14 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Hello,

This is the second take of improve-ACPI-corner-case-handling patchset
and contains the following ten patches.

  0001-libata-acpi-adjust-constness-in-ata_acpi_gtm-stm.patch
  0002-libata-update-ata_-_printk-macros-such-that-level.patch
  0003-libata-add-more-opcodes-to-ata.h.patch
  0004-libata-ata_dev_disable-should-be-called-from-EH-c.patch
  0005-libata-acpi-add-new-hooks-ata_acpi_dissociate-and.patch
  0006-libata-acpi-implement-and-use-ata_acpi_init_gtm.patch
  0007-libata-acpi-implement-dev-gtf_cache-and-evaluate-_.patch
  0008-libata-acpi-improve-ACPI-disabling.patch
  0009-libata-acpi-improve-_GTF-execution-error-handling-a.patch
  0010-libata-acpi-implement-_GTF-command-filtering.patch

Changes from the last take [L] are...

* @stm parameter is constified in 0001.

* 0005 is added.  This patch adds two ATA ACPI hooks for host
  dissociation and device disable.  The former is used to restore
  initial _GTM setting on driver detach.  The latter is used to
  implement _GTF caching in 0007.

* 0006 updated such that init_gtm completely replaces all internal
  _GTM data usage and init_gtm is restored using _STM on driver
  detach.  This change makes ignore-_GTM-failure-during-suspend patch
  unnecesary.

* 0007 is added.  This makes IDE _GTF evaluated right after _STM
  during resume.

* 0008 is updated such that ACPI evaulation failure doesn't trigger
  ACPI disabling unless it causes other failures.

* 0010 now also filters SET FEATURES - SET XFERMODE.  SETXFER from
  _GTF only disrupts device configuration by putting the device in
  possibly inconsistent mode from the controller.

The biggest change is that _GTM is now only performed on driver
attach.  The cached init_gtm value is used during resume.  This,
combined with moving _GTF evaluation right after _STM, solves all
currently known _GTM, _STM and _GTF evaluation failures.  By feeding
the initial values configured by the BIOS, it can avoid problems of
missing table entries or what not.

This makes ACPI mode configuration for both controller and device
meaningless but libata doesn't use them anyway.  In fact, all they do
is disrupting device configuration by feeding inconsistent mode to
devices via _GTF taskfiles, which are filtered by 0010 now.

Note that in many cases, _GTM/_STM implementations are very brittle
and can't be used as generic dynamic configuration method.

This patch fixes all known ATA ACPI related regressions including OSDL
bugs 9320 and 9530.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/26334
