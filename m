Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456410;
	b=qJlnryuclIaZB35d5ptAGB2Bns5M6G2EgSmSHg4YDjcKCZfghR4QmUkWsHYDY2HEwrcC
	 ZW439ygB0X/RU3TIkNIXfGifFcnVSGJedTbF3++6UCsRiR+C8lOVLGqcYx84r1w8YPrJh
	 JbMRmQyDkU2MdxWPJUNM5TLpfRjD6KPysGbgNorgw/7JV6FGkOb7m+O5nWKhmtKCFhquX
	 GtStK/O1iZZ/oaiwXCYx8okFzbr1UBW4y9NDWoNzHeOL2QNWv98arlLQQnCS2d8Cv8eWU
	 euuv7XET9DDJuXIVxOGP2W5EA6JrcezyLvB4QgvGJnAisd/xTqIhznLI9+QcdCCJlvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456410;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=/ssFh2H2CTFMV/9pQMbalW/JfyjMtXBHfBBOjcMIQwU=;
	b=ZeCscFJoYVRYDJQXx9VFnzjE+ga21aq3j1LHYrzxQ4NLRMV/3JDoQQ0hv/ApE4yJBW16
	 rJCSCjsygyAWukt235TxokfWcijnRxUi6SvG8BQsYo7FT3GfSdarMtzR/Kq3MvbkIQRq5
	 0sgzW4PuiD3i3fwBuM/FLuhMNEWQCn1wYXL3CT4j5tZIjMipzLT4sSFoAK2ES2UmKBOgG
	 nA6fSIbgZxLlcbMDTZIui3E5phOJuNx5MHTap/Tqc0+IcYSX3cp1Hp8Hua3VZA34Cosnh
	 zPxzWSJM8F3iyJHR9XlBe0IiS6nEPMF5wa9dsEQTjuEveJLy0ocvLEa4M5e1o/nouOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E075606A32C;
	Sat, 31 Oct 2026 14:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E075606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jH0VG2d7Mz5BNS0;
	Sat, 31 Oct 2026 22:20:06 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 69VEK088048971;
	Sat, 31 Oct 2026 22:20:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 31 Oct 2026 22:20:02 +0800 (CST)
X-Zmail-TransId: 2afa6ae5f912a18-07417
X-Mailer: Zmail v1.0
Message-ID: <20261031222002591vYvH6hQ_JbuZFeV5bccF1@zte.com.cn>
Date: Sat, 31 Oct 2026 22:20:02 +0800 (CST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IHBhdGFfcHhhOiBmaXggdGhlIGludmVydGVkIERNQSBjb21wbGV0aW9uIHRpbWVvdXQgY2hlY2vCoA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69VEK088048971
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 31 Oct 2026 22:20:06 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE5F916.000/4jH0VG2d7Mz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pxa_bmdma_stop() waits for the DMA completion that pxa_ata_dma_irq()
signals and reports a timeout when the wait fails.  The condition is
inverted: wait_for_completion_timeout() returns zero on timeout, but the
driver prints "Timeout waiting for DMA completion!" when the return value
is non-zero, that is when the DMA actually completed.  A real timeout is
silent.

Negate the wait so that the error is reported only when the completion
does not arrive.  The condition has been inverted since the driver was
added, the dmaengine conversion kept it.

Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index a694f6a178e3..f041e6adc9d1 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -95,9 +95,9 @@ static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 	enum dma_status status;

 	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
 	if (status != DMA_ERROR && status != DMA_COMPLETE &&
-	    wait_for_completion_timeout(&pd->dma_done, HZ))
+	    !wait_for_completion_timeout(&pd->dma_done, HZ))
 		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");

 	dmaengine_terminate_all(pd->dma_chan);
 }
