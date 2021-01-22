Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEECC433E0
	for <linux-ide@archiver.kernel.org>; Fri, 22 Jan 2021 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CD6239D1
	for <linux-ide@archiver.kernel.org>; Fri, 22 Jan 2021 14:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbhAVOim (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728836AbhAVOg5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jan 2021 09:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611326131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQyF+HvI2kyISxweGPzscU/va3PLmqEKg6fBJl2vlZ8=;
        b=B+DkxZPr8h9V7L2qmFgoIed9KSydNYOUG/V9jTGB2+6f7ULmav/YND+ZHl0nbIoHDWNc78
        dIerh3J3GB8gn5xlJF1fT9Fsu7+OKWublr8Nar5z/cqG2VPbSaUKSaOvHIxwKKCBnamwgV
        I5uME/KXdGnVajhKnKrKh97rPlNfmQY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-z2K5WRPQMIuX6_6aFwJC6g-1; Fri, 22 Jan 2021 09:35:29 -0500
X-MC-Unique: z2K5WRPQMIuX6_6aFwJC6g-1
Received: by mail-qv1-f69.google.com with SMTP id x19so3912774qvv.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2021 06:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQyF+HvI2kyISxweGPzscU/va3PLmqEKg6fBJl2vlZ8=;
        b=F3RsXoRIpm2DqAp1b+Y/V/+FEzu74joYFfweALB+nUveQBMcDnhU58JARb/lsT7h/J
         Z5ZjAN2gmwBlmY4Z3oQbN2zWQ9Ic3y/1F12JYFjBpvhCKrFL8ORDihnH1JaRk51chPC/
         qTZqnyOBq+cdLdYqRQcyc19J30e/csj1jQenf7eslkWwKGOo4h0yI+YaCnJfe5JyPsuy
         3Dv2mImyV6B7eH5mfZMH4f/MZHO+/WZShImLrjUPcJD9VpRCLIpCgOGk60TcwUIalqTq
         eCz5T5BkacGcgKV1OUHSazZA+zaVih9IizlRm49hBcxyIdUiIwYu7ZvqJW9TkMqfvnYZ
         M31g==
X-Gm-Message-State: AOAM532cExJ0lX+dEVhXJt/Dqh1jPFovawJmbLO02hwDNAFqGX8fmf/e
        gPXOUO+TMAfu6dPERT/5Glqr9m8kpLyfJkbMkW5b6jLBemEXJvAwwIoHxT/4RscIxxLu92rofyi
        XWozJ6XBpvOhXe6by1fwn
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr4831099qvz.20.1611326129224;
        Fri, 22 Jan 2021 06:35:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcqvMfUvaE2tN1vEdzhCsoxnf8/L4VLzX3cVy9gLxkAEp+fnqTM+NsxqxKqqiCoS9XPqe5Ig==
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr4831076qvz.20.1611326128936;
        Fri, 22 Jan 2021 06:35:28 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v67sm6715255qkd.94.2021.01.22.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:35:28 -0800 (PST)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ata: sata_nv: remove h from printk format specifier
Date:   Fri, 22 Jan 2021 06:35:21 -0800
Message-Id: <20210122143521.1598974-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/ata/sata_nv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 20190f66ced9..81b75e513266 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -603,7 +603,7 @@ static void nv_adma_register_mode(struct ata_port *ap)
 		count++;
 	}
 	if (count == 20)
-		ata_port_warn(ap, "timeout waiting for ADMA IDLE, stat=0x%hx\n",
+		ata_port_warn(ap, "timeout waiting for ADMA IDLE, stat=0x%x\n",
 			      status);
 
 	tmp = readw(mmio + NV_ADMA_CTL);
@@ -618,7 +618,7 @@ static void nv_adma_register_mode(struct ata_port *ap)
 	}
 	if (count == 20)
 		ata_port_warn(ap,
-			      "timeout waiting for ADMA LEGACY, stat=0x%hx\n",
+			      "timeout waiting for ADMA LEGACY, stat=0x%x\n",
 			      status);
 
 	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
@@ -648,7 +648,7 @@ static void nv_adma_mode(struct ata_port *ap)
 	}
 	if (count == 20)
 		ata_port_warn(ap,
-			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%hx\n",
+			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%x\n",
 			status);
 
 	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
@@ -736,7 +736,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 	blk_queue_segment_boundary(sdev->request_queue, segment_boundary);
 	blk_queue_max_segments(sdev->request_queue, sg_tablesize);
 	ata_port_info(ap,
-		      "DMA mask 0x%llX, segment boundary 0x%lX, hw segs %hu\n",
+		      "DMA mask 0x%llX, segment boundary 0x%lX, hw segs %u\n",
 		      (unsigned long long)*ap->host->dev->dma_mask,
 		      segment_boundary, sg_tablesize);
 
-- 
2.27.0

