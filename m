Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6FAC71153
	for <linux-ide@archiver.kernel.org>; Mon, 28 Aug 2023 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjH1MEC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Aug 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjH1MDa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2023 08:03:30 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 05:03:17 PDT
Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BC6E123
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2023 05:03:17 -0700 (PDT)
Received: from [172.16.0.112] (unknown [91.223.201.37])
        by srv.wefi.net (Postfix) with ESMTPSA id 7D1255A3586
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2023 13:55:52 +0200 (CEST)
Message-ID: <7728fa4b6027269d468f6a0665017c187471a9cd.camel@wefi.net>
Subject: [PATCH] ata: Add Elkhart Lake AHCI controller
From:   Werner Fischer <devlists@wefi.net>
To:     linux-ide@vger.kernel.org
Date:   Mon, 28 Aug 2023 13:55:51 +0200
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

--- a/drivers/ata/ahci.c        2023-07-27 11:45:21.141511943 +0200
+++ b/drivers/ata/ahci.c        2023-07-27 11:44:57.054711402 +0200
@@ -421,6 +421,7 @@
        { PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
        { PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
        { PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+       { PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
 
        /* JMicron 360/1/3/5/6, match class to avoid IDE function */
        { PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

