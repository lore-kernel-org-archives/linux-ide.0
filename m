Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC33DB337;
	Tue, 25 Aug 2026 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646763; cv=none; b=KT7QEkjgDVAOwAiAkDfrWm6b8hQyrOqIUHE6Kb9uydSbSH6moHEpB3s0A2vhbG2p175TaxgAiP7epJMPyC/YtJ8JtxAeY6EH/CdHrhm4zWCj6N1aRlPvHaCspDf+OWtNke5CJsst076ZTwgakfFtLrRcSjB3rhgcNdlyK5uETkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646763; c=relaxed/simple;
	bh=gRKbq1My6HLT18UPIqy7Z1jSyt+7Sh07+9HEVpDqrYQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DwhQMnX7/F/0gNIbgj8N0eem/I7xrs/LTdbljGGoJ6j3NAPx3g+QNlsiw97hAgAG2fT9m0DdVp5+R/RNZcF3li7YK97ikzjmZEqK9tDGbCQdBLXF1c2KqbvkqFrvVXMw9yVLiUeGHVDEKkVWV9vaVrIu5BBC+t3XoUHlYcdtG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w8XZ27RD; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w8XZ27RD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787646749; bh=gRKbq1My6HLT18UPIqy7Z1jSyt+7Sh07+9HEVpDqrYQ=;
	h=Date:To:Cc:From:Subject;
	b=w8XZ27RDqxpESvlSfwa8WFQKfVe8RDzupGjlD8GcccfJC5vUC3gFPMBG9DjctuIDF
	 4d1a0l3EsQQMGn+Ae9oXf4M2z9xSCHF6TzusvnFImAV2myhQwjez+OjKrkpTsGJxwL
	 hxRItGFkmBci9CC8Cbv9//cRxP/gs03oSKcbM1Hs=
Received: from [192.168.255.10] ([111.206.96.146])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 81B3964A; Tue, 25 Aug 2026 16:32:27 +0800
X-QQ-mid: xmsmtpt1787646747t8e3lmu63
Message-ID: <tencent_FA2F5F31DC5009EFE7B38D19D754AA6C4507@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLp8AKhiaAgWN5xwlEmWc5PoAXbvVqOPn5LopgCwP7OVH9NAsTZm
	 1XCEK1820Uzt4fFZ0vSR8QNJLG1TDoN1apCcpzPEhA8rYgqi0lpmicpoNJobl613JUXpbAcu5ERc
	 nAJWVthqfLuRgwdZYx7cZoN6MTDXCmOfqL3zC3wDSlmawEaT45fO+us3IRlwBKowGx9S74FZScfX
	 Nb1q94KQpckvlbhRaisSAxdXUxUpoT7Dd5T2Wwd0xktDpiZ40gR/yH0PjHpn2raaWHQa9e/FSOjK
	 U+o2rGprMVagSr/RnDf/9P5Pbp0j0rRPEPl7WGcBuoeyVI255NOrpnzaKvpFraB9xXDUqJUAFxlL
	 xb8pRHouEfuMMZUmZh79G4av0E3nUVgLTORXGvdQwJwFhP4UN4J73HbxGqecV8xnGGcyOJKp1lbV
	 onKZzRBfRAFDoUgzatnitTOU+d4ahOfccoKCn66jIImepXHT5Z9uz4Brr/BOwTWEsuO6mwiWi5lu
	 /SVOi8mZ8uNP/O9Fvv9tVvU3Hb9rLder55t6euq7oA//CvUHEpDqLQRROHmQ25V5y5iWl8Fd3oLd
	 Y3vSWF93ITTmSfv65izWDlLW0J7TOkZgWp+uX65DQFz+O+ik8HtntPMCUHx+smoSWVv61fnAYNio
	 84Zw/KI5dL+CAMRM7vL9aDDVXYE97a+RU+4aF66qEW2PT/tbb/D3tKgTmkBZs50SSyMBmzfHTHjQ
	 /LyFy6jIu/XaA9SXvbkLllVG95kZ1xlYut71tEGEJDNCi9twAFp+VkhW6VUd4GDkEgDHqzpLdG2M
	 dsWTJuwtHGDfu9RWdhh1+jYqyOrlRZflcX2RW627NVElPS7JLU+1MCmhTIiqqnef+b+bXLVpdYY4
	 qfeGSCdDBz6UX/AAtlnEZp3qbZ/ZE20AZ/jWtQWPdx2KByEC+roTI8D/8iI6a+gbM/jyrGqNK70A
	 v9A8zHLNUrC3qDl1EQqRLgCwjq7RK7RAY69VxXGnJNCpPMpXNt/RkunrhyCRMzjjCq54JaZJ5wtw
	 hSlqkDnf86UxeKdhvPL2TDgTAx0wMygz06tsMFZA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <e44e9587-b4db-4014-8add-5654faacee6b@qq.com>
Date: Tue, 25 Aug 2026 16:32:26 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] ata: pata_pdc2027x: fix division by zero in pdc_adjust_pll
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pdc_adjust_pll() divides pout_required by pll_clock_khz before checking
that pll_clock_khz is within the valid range. If the PLL input clock is
less than 1000 Hz, pll_clock_khz is 0 and the division triggers a
divide-by-zero error.

Move the sanity check ahead of the division so the invalid input is
rejected before the ratio is computed.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d1d1cfb22e27..c4cff4eafbe8 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -517,7 +517,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
     u16 pll_ctl;
     long pll_clock_khz = pll_clock / 1000;
     long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
-    long ratio = pout_required / pll_clock_khz;
+    long ratio;
     int F, R;
 
     /* Sanity check */
@@ -527,6 +527,8 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
         return;
     }
 
+    ratio = pout_required / pll_clock_khz;
+
     dev_dbg(host->dev, "pout_required is %ld\n", pout_required);
 
     /* Show the current clock value of PLL control register

