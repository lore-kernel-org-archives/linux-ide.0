Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908974;
	b=MOcJu6oWOkbUzssq2Yvj2EgZU1/C9+6xUQ/zXmgz/Dc3dKf0UhYOs212qI79l39ZmF5D
	 4bEsdGOqOmEVHySpHJMovp7oq46HPM2W27pf52JzYD+5ylSXmQ8ZudnXpqjvgoJhw566q
	 xGDp9/Ev9eboM1W7ZXQQHxk17voq6s/5qF6snnpFcl1HyHJgQDChyKUW9qUVzGLWuuU30
	 JL4SlLiyAbPffOrWk213BXHYravXWANvpVQNaBDUY4JVAAh3k9SpxLwpqN95ijcKaTesk
	 GsqL40opWf1sDgvko22a/uY5wLaNPVhKko3OSjW68tm73dkGSi4s3nfwPCLwpkRFFdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908974;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=u+EcvsfDwmDRDEZLSD0nmw/xfCSnqEAUsfQ3ibZbp+c=;
	b=n+xbKlGhc2ovAVqEeQ0XHPWLpgumkSJhdZDy7Lh5KMgpCgkSDmka6Mc0RQN7R9SaxJT3
	 v73wPwS8yFIMZNCTlo3Mb5RGwliBIYef1ixcVzf5KuKGTMxRij/V87bvJ8q/iBd87xqf9
	 awAYHRzynALpt0KaqvMcvGR0bN2WdYhokNyy96kcyuDhSAQMIr9vwvsojVf6goNW/gLrW
	 uveWHftAfNnR52pkoInrnUtfLjkT70sphqsaWGh1VkYpqvNNrV/v55mncELG5d4H8ZEVW
	 kIfb8RAsuicsrhv8m1AHuvYBTWxYBQvPUAT4TzxbZJ+ZZKFmACBAHg3g+CB/hPPYQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QpvRguFm;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C1606A882;
	Tue, 17 Nov 2026 09:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 432C1606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QpvRguFm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=u+
	EcvsfDwmDRDEZLSD0nmw/xfCSnqEAUsfQ3ibZbp+c=; b=QpvRguFmrKj8yp3xrc
	vtJXa840nsmKpIEnwLuV1+wxdlba47RLSTdaCDkY8RHz5gHAIRd6PfkcpLbLcFPv
	WXVaqU0JHLZCfbIYq5KOLsiDP+d5X41PsfPOlZyjMhz3IZoexZW58abUw6m2zj00
	IYevfJUi10alrnmp3xtacJvCw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v9UPI_xqjVtVIw--.61237S2;
	Tue, 17 Nov 2026 17:49:05 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	mans@mansr.com,
	tj@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] ata: sata_dwc_460ex: Fix DMA channel leak in sata_dwc_port_start()
Date: Tue, 17 Nov 2026 17:49:03 +0800
Message-Id: <20261117094903.1282096-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9UPI_xqjVtVIw--.61237S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWrXF13Kw15uw1xJr4Dtwb_yoWkCFb_KF
	429rn7X34vyw1UAw12kws3WrWxKrW8XrZ3ZanFyr93Xw15Xw45Xr9F93s8Z34DWa1rKFna
	y3yDC3s8KryfGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRG4E_UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RGmFWr8IxG34gAA3+

If phy_power_on() fails in sata_dwc_port_start(), the error path
frees hsdevp without releasing the DMA channel acquired earlier.
Add a cleanup label to release the DMA channel before freeing
hsdevp on this failure path.

Fixes: 0f48debdb906 ("ata: sata_dwc_460ex: add phy support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 486ea94a0184..c1025ab3e474 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -853,7 +853,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 
 	err = phy_power_on(hsdev->phy);
 	if (err)
-		goto CLEANUP_ALLOC;
+		goto CLEANUP_DMA;
 
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
@@ -880,6 +880,8 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
 
+CLEANUP_DMA:
+	dma_release_channel(hsdevp->chan);
 CLEANUP_ALLOC:
 	kfree(hsdevp);
 CLEANUP:
-- 
2.25.1

