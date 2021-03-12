Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4017C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FDF64F6A
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhCLJAH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhCLJAB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2021 04:00:01 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA8C061574;
        Fri, 12 Mar 2021 01:00:00 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j17so3914193qvo.13;
        Fri, 12 Mar 2021 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeJvLuvyZg25yI6p7wMHbe9MGq2hul0E3YQjgkwAB/g=;
        b=rJkmAh3MXE/SCquN6xlNHA9/xiBwhcoWk3VCz+JAEQTRBpT/sEl4tOW50I5eJtu+W7
         582uK+TTjWyUBjabS9SzdYlTSI8KxuFFNdT7/xog7M7BRcS0LOtjXZbr0/bpN1DMNulT
         smqCgGk4owwuhsr7SLJaECcAOIJj2peACcrjD8hSGQnGjBcXAuA8htvzZ31rG62sfMY6
         OYJEl2InPCCL18t4Mdrzgysm1K3TlKpovoyHsr36fxP5r67+b+tdoxN6PCQfE7u92TSB
         9w/sxyj/cyy2+3MwGYQ65QNyvdaCdFBPzdPWbTvZ9OmnwF20c5ZlBmTxZojv6GMvBZfg
         gmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeJvLuvyZg25yI6p7wMHbe9MGq2hul0E3YQjgkwAB/g=;
        b=rh8iXaEu4BRD2Ct/8m65FESKr2yT1xBIfOoNSe64L1EtCwgn1u4WoAA+BPhsxp6mNI
         g4/r2asoUkdAco6tCUORGnTON+L4m8e7DY2vTbPK4ECVM0jccwcHyt8hwpCYWioghFE8
         2ju3Y83n9WrpFXtpj2hSjCw3T4PdRNDGhn43rTLRQYMORXsJU2pqydutLnCCIs/tGWqz
         YfjxrOIVbEok1kh9XKDR3BvkfikN3JvsJR6EddA3wNqhwpJiFNG0xkLQTUt34VagsIIC
         XPUCRzO3FlGM8hN640P793f/l9iY2j7QQghtdOsw1KuYytkEKLlHMbgpgSfbZ2z8Iju7
         PPEg==
X-Gm-Message-State: AOAM530ng59GIuEasbqiCW6rd7JnSYvnRuSL6Pscqnf1YqJ00RYftvoP
        8ZuyfzBrQ4m+phJdffgxl2M=
X-Google-Smtp-Source: ABdhPJxyPBHTOqXAHSrp64hj2ew/9nN1TXxtlHooUSWZiLaSmH30bWqvPn6QoZO9qyMtTgDNUOjOtg==
X-Received: by 2002:a0c:b617:: with SMTP id f23mr11284258qve.44.1615539600160;
        Fri, 12 Mar 2021 01:00:00 -0800 (PST)
Received: from localhost.localdomain ([138.199.13.196])
        by smtp.gmail.com with ESMTPSA id o1sm3515384qtq.81.2021.03.12.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:59:59 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ata: Trivial spelling fixes in the file pata_ns87415.c
Date:   Fri, 12 Mar 2021 14:27:38 +0530
Message-Id: <20210312085738.9372-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Trivial spelling fixes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/ata/pata_ns87415.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 1532b2e3c672..f4949e704356 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -113,7 +113,7 @@ static void ns87415_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	ns87415_bmdma_setup		-	Set up DMA
  *	@qc: Command block
  *
- *	Set up for bus masterng DMA. We have to do this ourselves
+ *	Set up for bus mastering DMA. We have to do this ourselves
  *	rather than use the helper due to a chip erratum
  */

@@ -174,7 +174,7 @@ static void ns87415_bmdma_stop(struct ata_queued_cmd *qc)
  *	ns87415_irq_clear		-	Clear interrupt
  *	@ap: Channel to clear
  *
- *	Erratum: Due to a chip bug regisers 02 and 0A bit 1 and 2 (the
+ *	Erratum: Due to a chip bug registers 02 and 0A bit 1 and 2 (the
  *	error bits) are reset by writing to register 00 or 08.
  */

--
2.26.2

