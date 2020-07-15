Return-Path: <SRS0=C1w+=A2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B83C433E3
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 11:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29B520658
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 11:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="ClPUNCrp";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="ZZCOflpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgGOLXP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:23:15 -0400
Received: from chalk.uuid.uk ([51.68.227.198]:52662 "EHLO chalk.uuid.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGOLXP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 15 Jul 2020 07:23:15 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 07:23:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BNbPwFNjGOZuIyTmfC1KF3tsumtB45tKs1PO9XQlp80=; b=ClPUNCrpsVyHg5X8jnMvD9oZKH
        FhrWrjk+VLs06Grjai4jAkyxcq/If8dMqmfJRN7ks8gx5zlkY2ItfJrAjvEv/y7dBeBC8rty2LXwa
        R3xlla8YBYjLvcsgJ+8aMZgZ/sAlvYnCaOvAS3Zmns/mcYpNX+rOzgXVbV0wH5B7uCPpQAGgLGT/H
        +fGog4RZuW5TSV+CsqnYwonNGr3pW75peYxPAFkMEsAU6XyY4d9pWnI/6SaksOUlvrFUa++MlZHDG
        xkEujtSfgerxVbi9n0iGZZvgNGc6+jmZ50/Tj7CYVERPCo9HEdTIghvczN99pbsMo/SVfffHAndKM
        KzIQFNjw==;
Received: by chalk.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <simon@octiron.net>)
        id 1jvfLr-0001yH-N0; Wed, 15 Jul 2020 12:13:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To;
        bh=BNbPwFNjGOZuIyTmfC1KF3tsumtB45tKs1PO9XQlp80=; b=ZZCOflpNYv1VZQPRBAzdREp386
        1JrKmZnbPQB4nFbETmFCFcurWi0O+qkMWhH//GXeb4DD0OpTHtN713EIVh/dOuF2YXOHhsj0DH0Ah
        hlu1MulypgZe22eO3n+Fm2hRuJaWxmnD6ohsehVRi0uVUAibV4/mA3nZ6lP/rj2vxDAoVIcKvHm/x
        YrRmzS3SGuFGWjx6FZUtF9kkftTgn24IRrCRt3OKo93sBA4mA0gUbWLP0v3UFm2gDwOXlnLc+gMn6
        8odnar77qLhC8/Mzfui8PrfR0RMuC/Ov2jP01gNhUnL6Yb2d2S5tluEqS0peC963JzATEKV0BGzwv
        eS8+lx5w==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvfLp-0006wK-Cc; Wed, 15 Jul 2020 12:13:25 +0100
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Park Ju Hyung <qkrwngud825@gmail.com>,
        Tejun Heo <tj@kernel.org>
From:   Simon Arlott <simon@octiron.net>
Subject: [PATCH] ata: Disable queued TRIM for Samsung 860 SSDs
Message-ID: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
Date:   Wed, 15 Jul 2020 12:13:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Despite the unsubstantiated claim from Samsung that "the improved
queued trim enhances Linux compatibility" this does not appear to be
true, even on Intel SATA controllers:

Bug 203475 - Samsung 860 EVO queued TRIM issues
https://bugzilla.kernel.org/show_bug.cgi?id=203475

Disable queued TRIM for all Samsung 860 SSDs. Only the EVO has been
reported as having this problem, but the original justification for
enabling appears to be based on marketing material with no explanation
of what has been changed to make the 860 work properly when the earlier
840 and 850 both have the same issue.

Signed-off-by: Simon Arlott <simon@octiron.net>
Cc: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: stable@vger.kernel.org
Fixes: ca6bfcb2f6d9 ("libata: Enable queued TRIM for Samsung SSD 860")
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b1cd4d97bc2a..02e861aac5ec 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3951,6 +3951,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
-- 
2.17.1

-- 
Simon Arlott
