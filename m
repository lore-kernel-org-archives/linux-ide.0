From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstram-fixes] libata-acpi: improve ACPI corner case handling
Date: Fri, 14 Dec 2007 15:15:32 +0900
Message-ID: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbXLNGPr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Hello,

This patchset contains the following patches to improve ACPI corner
case handling.

  0001-libata-drop-const-from-struct-ata_port-param-on-ata.patch
  0002-libata-update-ata_-_printk-macros-such-that-level.patch
  0003-libata-add-more-opcodes-to-ata.h.patch
  0004-libata-implement-ata_acpi_init_gtm.patch
  0005-libata-use-init_gtm-in-ata_acpi_cbl_80wire.patch
  0006-libata-acpi-improve-ACPI-disabling.patch
  0007-libata-acpi-improve-_GTF-execution-error-handling-a.patch
  0008-libata-acpi-ignore-_GTM-failure-during-suspend.patch
  0009-libata-acpi-implement-_GTF-command-filtering-and-fi.patch

The first three patches are misc prep patches.

0004-0005 backport init_gtm from #upstream to fix ACPI evaluation
failure on some boards and fix ACPI cable detection.

0006-0008 improve ATA ACPI corner case / error handling.  With these
changes, most ACPI errors don't cause slow down or other side effects
for probing and suspend/resuming.

0009 implements command filtering such that certain _GTF commands are
filtered.  Filtering can be controlled with kernel parameter.
Currently only lock / freeze lock commands are filtered out.

This fixes all reported ATA ACPI related regressions.  There can be
cases where _GTM evaluation explodes but it doesn't affect operation
at all and the correct solution seems to be suppress those messages.

Thanks.

--
tejun
