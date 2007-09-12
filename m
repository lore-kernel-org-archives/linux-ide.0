From: "Maurizio Monge" <maurizio.monge@gmail.com>
Subject: [PATCH] Blacklist NCQ for WDC1600BEVS-22RST0
Date: Wed, 12 Sep 2007 03:38:07 +0200
Message-ID: <e4c519350709111838n1fdc6f01tdfa5722cbee605a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:6018 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbXILBiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 21:38:09 -0400
Received: by fk-out-0910.google.com with SMTP id z23so43239fkz
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 18:38:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch fixes the "spurious completions during NCQ" kernel error i
used to get.
Unluckily this drive SHOULD work with NCQ, but on my system it does not.
If you think that instead it should work i will provide you additional
information amout my system (i have already posted some on this list
and on lkml).
Best regards
Maurizio Monge

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3796,6 +3796,8 @@ static const struct ata_blacklist_entry
ata_device_blacklist [] = {
        { "ST9160821AS",        "3.CLF",        ATA_HORKAGE_NONCQ, },
        { "SAMSUNG HD401LJ",    "ZZ100-15",     ATA_HORKAGE_NONCQ, },
+       { "WDC WD1600BEVS-22RST0",      "04.01G04",     ATA_HORKAGE_NONCQ, },

        /* devices which puke on READ_NATIVE_MAX */
        { "HDS724040KLSA80",    "KFAOA20N",     ATA_HORKAGE_BROKEN_HPA, },
        { "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
