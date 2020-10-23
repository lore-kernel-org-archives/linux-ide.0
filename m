Return-Path: <SRS0=RTe6=D6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4CC388F9
	for <linux-ide@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104F6208C3
	for <linux-ide@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603471097;
	bh=6T96WIbhEdoUn7swuSEk+0sEbN+E2NxuoZFz3O2v1AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Esvd0AAcEEiztMJoSCiTEMWaegxTnd0M4kYvnqy5QlP0XwWQTdBEEMchiIdzIvAw5
	 /OQRYqujiR+XqWTSdWSrILyOLsKSdxfYJfRQBglKM/AHmM8o5F065RlNRY+pZi4x2D
	 UCvJj794/gpd3oom/YegtSvVGlfFv27N3UNs06uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbgJWQiQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbgJWQdt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1825A2465B;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=6T96WIbhEdoUn7swuSEk+0sEbN+E2NxuoZFz3O2v1AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlpEBZhm4413VDb28h87ZUEs9QiiHwQo0nsys9AmJX0ew2+PvwD78rEK1IHxVTL7Q
         8J4rhG3T1Dz7oQ1jH0aTK4rKjItSdNx0r0j980ZKQQX3+D7ofyW5wP0VbhH1UA1EDp
         Xl+LSIzC9Kd0g6KmvXcgKzrSDRXlPHbpV9K23gjM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002Avd-Th; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/56] ata: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:55 +0200
Message-Id: <a7e159be08bcb0c42aa219cf99c2adfd4db0a9d9.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some functions have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata-eh.c   | 2 +-
 drivers/ata/libata-scsi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f546a5761c4f..61c762961ca8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5616,7 +5616,7 @@ int ata_host_start(struct ata_host *host)
 EXPORT_SYMBOL_GPL(ata_host_start);
 
 /**
- *	ata_sas_host_init - Initialize a host struct for sas (ipr, libsas)
+ *	ata_host_init - Initialize a host struct for sas (ipr, libsas)
  *	@host:	host to initialize
  *	@dev:	device host is attached to
  *	@ops:	port_ops
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d912eaa65c94..b6f92050e60c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1115,7 +1115,7 @@ void ata_eh_freeze_port(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 
 /**
- *	ata_port_thaw_port - EH helper to thaw port
+ *	ata_eh_thaw_port - EH helper to thaw port
  *	@ap: ATA port to thaw
  *
  *	Thaw frozen port @ap.
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 70431912dc63..48b8934970f3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1003,7 +1003,7 @@ void ata_scsi_sdev_config(struct scsi_device *sdev)
 }
 
 /**
- *	atapi_drain_needed - Check whether data transfer may overflow
+ *	ata_scsi_dma_need_drain - Check whether data transfer may overflow
  *	@rq: request to be checked
  *
  *	ATAPI commands which transfer variable length data to host
-- 
2.26.2

