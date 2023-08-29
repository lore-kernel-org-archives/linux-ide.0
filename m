Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D734AC83F17
	for <linux-ide@archiver.kernel.org>; Tue, 29 Aug 2023 11:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjH2LeX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Aug 2023 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjH2LeD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2023 07:34:03 -0400
Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2DC11B
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2023 04:34:00 -0700 (PDT)
Received: from [10.1.199.83] (unknown [91.223.201.11])
        by srv.wefi.net (Postfix) with ESMTPSA id 79C915A3586
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2023 13:33:59 +0200 (CEST)
Message-ID: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
Subject: [PATCH v2] ata: ahci: Add Elkhart Lake AHCI controller
From:   Werner Fischer <devlists@wefi.net>
To:     linux-ide@vger.kernel.org
Date:   Tue, 29 Aug 2023 13:33:58 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Elkhart Lake is the successor of Apollo Lake and Gemini Lake. These
CPUs and their PCHs are used in mobile and embedded environments.

With this patch I suggest that Elkhart Lake SATA controllers [1] should
use the default LPM policy for mobile chipsets.
The disadvantage of missing hot-plug support with this setting should
not be an issue, as those CPUs are used in embedded environments and
not in servers with hot-plug backplanes.

We discovered that the Elkhart Lake SATA controllers have been missing
in ahci.c after a customer reported the throttling of his SATA SSD
after a short period of higher I/O. We determined the high temperature
of the SSD controller in idle mode as the root cause for that.

Depending on the used SSD, we have seen up to 1.8 Watt lower system
idle power usage and up to 30°C lower SSD controller temperatures in
our tests, when we set med_power_with_dipm manually. I have provided a
table showing seven different SATA SSDs from ATP, Intel/Solidigm and
Samsung [2].

Intel lists a total of 3 SATA controller IDs (4B60, 4B62, 4B63) in [1]
for those mobile PCHs.
This commit just adds 0x4b63 as I do not have test systems with 0x4b60
and 0x4b62 SATA controllers.
I have tested this patch with a system which uses 0x4b63 as SATA
controller.

[1] https://sata-io.org/product/8803
[2] https://www.thomas-krenn.com/en/wiki/SATA_Link_Power_Management#Example_LES_v4

Signed-off-by: Werner Fischer <devlists@wefi.net>
Cc: stable@vger.kernel.org
---
V1 -> V2: Added comment mentioning the additional IDs 4b60 and 4b62
          added "ahci:" in summary phrase

--- a/drivers/ata/ahci.c	2023-08-29 09:14:09.537450842 +0200
+++ b/drivers/ata/ahci.c	2023-08-29 11:22:50.779830526 +0200
@@ -421,6 +421,8 @@
 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
+	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
