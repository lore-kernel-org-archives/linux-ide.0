Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D4FA373D
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJaBxl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJaBxg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 21:53:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49695AE
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181215; x=1698717215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+YhafSOih06QZfSN+lI+siqPo+e0Kz4p8AfqVOVZpQ=;
  b=XnHKEIN7Tp7QGjPiVD4a8cmeXCtUske5btTAkcMUpASiagdYdEOu76i5
   gOSdcpTqbB4J3C5TSC8d7H4VvCx1/gNajZyuXMwQT1gKpwSHMK2OIftLU
   TSf2UCgQNmVGtZNH1QE8nwy2ffKjYV3fMHg8NV74B2RB5HqSTBceTgqHc
   3e/a/CYz4cs4KMYV6+T2Rv7J7UH+4jA9jCk+SCvImWLcu84dGH+YQLK+7
   JK1FYPX1qgstxPc/mPFTAyX7ySMoPeScfmh34yAjgmkPG0vYaLe678SYd
   pzks3hKHCzKTDVoQ7TPtikt4F6FsJqQFCnY4n8ghKcFmJg9vZS3ij0iVG
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220246018"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:35 +0800
IronPort-SDR: rsrU3wKNMLekUjviudNzhM0iTj+tvEA4e8mevF4QlssiNw++clzccYQS8qX1hSUNxEej71jV15
 z2m8PEltTCk21wLwzQmZPpbPK1mPKeZszv8XmCjYOPLb+vRV6wOtSFzw/4tdqVSOWW0VmA3Nax
 Zs7ds32HEW/dbkr6F1BUm6AuKVbhG8bnEW7p1jtI8kUk/3wpzPyQwK6RTzv1SItGN+GJ2KzM6P
 Tub1QIEkwyXko6avvK7VkLCb+69V5Qu+iyKX5v9vPLImIdVXUrFG1yo1BerJek63CDaYVqGOWq
 YPU0g0VFfimXWuoVlH2ynhaJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:07:08 -0700
IronPort-SDR: 1cXeiELWz9CWLWkXOYgQwzYS2J2SiFRp7SHPguAKoJVZbqCKDZOTxGIBGs7Xv4Gjw6es7+3YHt
 YzI4/UDt5YrSBFG2dTpp5ZMa8SN0AVeG6Ozt/DCStNGerbOt2eYVo61VntFomrL7JuObFj5+c/
 JH+iPjTo7WlC0YHiakiafBE3wuCmHY7MXqlEPr1T18IMbZR0FqGmkn86++xUY/bSDylMj/akZU
 CP7zWItfByZn9bbjqlbXVD1yikAj+T0TrgkWcARgmL8elpaLawYTIVgAkPOTXOK7EUQfb3JCue
 hjM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x5B1GbCz1RwqL
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667181213; x=1669773214; bh=u+YhafSOih06QZfSN+
        lI+siqPo+e0Kz4p8AfqVOVZpQ=; b=XkSzakcfOWvSUX1AbLOvX2Vev048QG01oO
        yXkw9sbUZ1IpWGKNWvakO2Xl/g0sYhUCm5MINJPKO3WXkNwxOeQNqWscbjA3b9AA
        IaD7ptaVMC7tBwM8XSm2cn28rhIrPCCYcZWNvZWJdnZ2fMndb2SIKoGdx3c5rsvg
        y71dJizXbNg3O6MkwoNN/Vm5colGbJwqAyJM/ZtEkUIiw4ZQ0Kv/rP0MxNfYCSoA
        /tgQgnm3H0QLAHz+qIeL57ztcVSBTJcPTtQOT7loP3yBFDRzJDIbuc0It6OdbEyE
        Nwn1XSSYCqDT4m+VaDoT5WT4onmXi5ZiiF/klLr6NGpR4U0W0R5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JpIMZzMbphwS for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:33 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x585984z1RvTp;
        Sun, 30 Oct 2022 18:53:32 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read operations
Date:   Mon, 31 Oct 2022 10:53:23 +0900
Message-Id: <20221031015329.141954-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For block devices that do not support FUA, the blk-flush machinery using
preflush/postflush (synchronize cache) does not enforce media access on
the device side for a REQ_FUA read. Furthermore, not all block devices
support FUA for read operations (e.g. ATA devices with NCQ support
turned off). Finally, while all the blk-flush.c code is clearly intended
at processing FUA writes, there is no explicit checks verifying that the
issued request is a write.

Add a check at the beginning of blk_insert_flush() to ensure that any
REQ_FUA read request is failed, reporting "not supported" to the user.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-flush.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545e..4a2693c7535b 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -397,6 +397,18 @@ void blk_insert_flush(struct request *rq)
 	unsigned int policy =3D blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq =3D blk_get_flush_queue(q, rq->mq_ctx);
=20
+	/*
+	 * REQ_FUA does not apply to read requests because:
+	 * - There is no way to reliably force media access for read operations
+	 *   with a block device that does not support FUA.
+	 * - Not all block devices support FUA for read operations (e.g. ATA
+	 *   devices with NCQ support turned off).
+	 */
+	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
+		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
+		return;
+	}
+
 	/*
 	 * @policy now records what operations need to be done.  Adjust
 	 * REQ_PREFLUSH and FUA for the driver.
--=20
2.38.1

