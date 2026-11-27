Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804953;
	b=CHanHCrB50HAGdtMashHrdWBizDpLWI9s+U5tjjxgLgW/r/b+Ct2jezL7hTwynpswa+G
	 EM2FFSRPCYqMab9AvvfAoJ1/7GXeSvDhfPOM2lhoj8LqYugjrO2ravzTJcW4NwoexNAa8
	 Y2OpFVaDezd9MUbOmHf25ipgk9Vi2OyTLrtWMhoba3M8DDMRgMl+Fk/9wxiZ+eOPBSW3b
	 qukdQv7pHMqFwtYUMLoZqnE3Y/GvvrQBIIE2vQTVUpzAhCqiOkltO3b8J+0VyD1jXj24R
	 jdNJpIv7PKdbpoCy6tSGOTJXKrRXkYhUltDdUKpUjnkSwI6FVXC66hAgx6hTAsJlqBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
	b=5rb5s7KXIxcuP1s6oBHQq1zyIRq7tAMLqiadoPJY3tWKqJ/eRi8rUpHMMx9SsrJPt75N
	 /nlgSubxVKjzaeX+fBsCFUQI5YGImAfDJFtaeC3jjzCiAl0+wtBhli0kkFc82KS4c+k1j
	 lVfoTJItdTQ3SGPCY5qUHNLs1x1q8RlQqYGQJkfOam35yIVobu8fmUlQOrwMEL1f1Xn+v
	 RhRLQp1bINVvF2cwk3jkYKeerv81J7+C+XI/W+YktRhWEV4Ba5zm7QlZd+21nMzhCrKyA
	 3zclN7NGzFwuctdqMZ7C80Asjul641s0R2TMWmUTl2OtwlouD8iSc0IqzRhgCQeEwag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEO8TY2b;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBF606A68C
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EBF606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEO8TY2b
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdece95eca4so455296a12.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804953; x=1796409753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
        b=jEO8TY2bTqpsBAcjBmhwCrHkx4o7wM6911cEx73ebLd2/ItQ84EITI2+SA8D33kjWl
         zeGd5/mxqfkq4FPSGa34wxMCJo07CJYG3UufkjISusrz52iBBWckODmjgjAQddatV05o
         d5kaZ8iHydpbaALJuPH5AxF+kJXL755ETa3jlAl+geJ1H/G8uB8sWBWjeqA2U+oum1wQ
         l0OWooCk9jLOK2OmpuH7Zfeq7Dm4rzkhoEwOj3AowByTlvtyNWiefePproX/gbh8nUNX
         GvwVjn9ZDxCHGmW+OayLm7eRKlv348I9gdmxQUnZk0pNeRZCI0EgCsVjvlYEIANxJYL6
         1bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804953; x=1796409753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgvT+dOepkzuZa55RwDoKTHZPik5/QAGfaPisL9xZDE=;
        b=rhesCSZGftahpcrcyZLxsdSMoDRtgTH57EgeFKDJvrKhB2tit+UqX6cf8aGDWUgRCL
         e7l7GFooUlGFwbg1Jo43BcREvHLneCVIygWVD3UhJFhg/AKhE/wvgXW5OPeRv9dPrcht
         w8wRKzSVYGMxMwzmB/N3kuUXpS6VjKKSRZcAT4CZabxbB3Po5n3JqT6snUL/JXorfQbT
         AzDVc6VlPA24oOKJFalnR3nxxir7zwF1b6H+3J+SFr/B6oodppe+HEQ8fmG/pbSusXCq
         VtNowxkIKWX7z1RAjfbI7jXsNv393NK+6V/Tq7Ak3D4/91sVoHqdVOrNrXSmYP0ieEwJ
         FT7g==
X-Forwarded-Encrypted: i=1; AL+hErEWUiJ8qckHAtp0V4q2oyeWqBNyPo0fpZTodV9RrdU4pqm0ufbD6EU44/XcVdzLHBLMrW5RQiriKMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ayXP3+mm2Hr0V/Wg7KfFq929kDodrxHyeJAFKYBB90CtK2Taa
	jlR3Ut2hoo+RaEQYby80FhAC6qtu+zK98H7k7XXPDBsizSGEHZDa7SE7
X-Gm-Gg: AZFdTZeB4cSD+dN8Tjp/6OLgIy/CtI/CPgMdOP/Q0QVInEXxsSyzOPVfBqu0OyE24kH
	3AH0gYWjwNpDYr6L93F7bggt9qCBnk+2teIkcD8EGIRABdDzraJcAt+S7hiKTpH4Lq+m7nJnWGc
	RCvr20GoEbeODw1F8h3tYqh7WJltu/mhv4rhHYAaCBk9vWyxcRxaotCObYM7XaAV14hbsA24FRk
	Nq8Ul+fcdYHQi+S8/gwj+zhz1yN6zvh7m5/FSMhqWM/3ZsoYzEsbNWYSbGTX66niNqbagOSL3Vo
	pwfUq9CEBUYuzKa2IaFQgQss9PPlKoiqGnJUBmOt33n3X8xPfIVEDPeht/IjLlIU542zgqkVI9n
	6X5zj0MKUkD/j6frzaaciuUjZspzhlWl8npD6BdOPOguInEWrcDesE7cnhqDGCoVU6VI8oHQj/s
	BrZrGONrFRABiFtNSwqjMIZFT75OWWV9FwVALhhNHxUZgB0j6Xg/ka88POrPrs1SMLam/EOULCn
	O53VwzpQg9671kZ3qYAZwlLbWg97jSsQKxSRPiHD19wSmsTo1tIi2qASQskk1SMcrDhFogjP6U1
	M+TwugPJ6R9QLRzOJykm6PVKpUKPBmg0pLU8wZFf59DxOwZ1kA==
X-Received: by 2002:a17:90b:35c3:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3b41c7d5bc0mr22005368a91.9.1795804952756;
        Fri, 27 Nov 2026 10:42:32 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm19149071a91.17.2026.11.27.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:42:32 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: artem122novak@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linusw@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vireshk@kernel.org
Subject: [PATCH v5 2/4] ata: pata_pxa: add missing newline to DMA warning
Date: Fri, 27 Nov 2026 12:42:26 -0600
Message-ID: <20261127184228.185827-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127184228.185827-1-artem122novak@gmail.com>
References: <20261127181619.183139-1-artem122novak@gmail.com>
 <20261127184228.185827-1-artem122novak@gmail.com>
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

Terminate the DMA completion timeout warning with a newline to
keep kernel log messages properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 2312c42def22..2e73726410b9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -96,7 +96,7 @@ static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
 	if (status != DMA_ERROR && status != DMA_COMPLETE &&
 	    !wait_for_completion_timeout(&pd->dma_done, HZ))
-		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");
+		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!\n");
 
 	dmaengine_terminate_all(pd->dma_chan);
 }
-- 
2.56.1

