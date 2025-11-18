Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183F320CA7
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484414; cv=none; b=I8+fIzUeqDR+KA6iUWyLVM58V0TBh1gN8qUf4CVLelXdRQcgW1owOtd3pft15BO+dkld/CWc5dNq1xuycS/T8YW+9fdDzsxDMySORlNOGF0TOsbk0Mx0pplDYdLt4M5SrMDBan+IOnXlRgLtqWeLbk3ZMYsfqYDt5WjAFNdUV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484414; c=relaxed/simple;
	bh=gx1Rkb1B+N0Kv/ajBx43fQzqE+YptOVtHyruaRbUcmg=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=Febnd6RGW6/foUaD/9ggOmLX99HkAcX2wYihKAW0gMEO2EZbUFQ4DA96/9XaaMR2MiNNpBv4JujF9N3Atts6idOCooGKEw6Bj6PEIS0s162MF+HXeqeU2ORliJQWLNHgnEYBNnVmSbMP5K4RkYzqEglgDPNE6RYBTA9k1KK514A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Uv5ikd9U; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Uv5ikd9U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=61X/UmN4oPbc2RmdkAzahA2/vx1eYS8UfPGinYZ4+Xw=; b=U
	v5ikd9UMyS5n6ocHQfViom6xMzZuDekREby5vnZUzgtv1EutGrJ8xm0fp3xr89lpIl52VMdGPtAN3
	TWmLH9+3u/W+wZMZ+3iXh7cT4ZYyOuaJ2pLkqPHTkevTjNTzDKZgLqzbjR0SFdBgkg7/+tMJ9tG/z
	WQYEf7ueuAp3z3DH40BQrzSLXiOKsM9UAc9TNmNlRcY87jxYzeqbbg2xF53/xUgvQh5tebnwoT17j
	6wlRr6SmC9lZmytF1v09Qkg3sRT7PxiiEpEKx5RAA2emxDhf8OtLFKVfBDEUdbYQDE+lFnzNBYgQ9
	bdyzkdhA+3eHH8sGpwXHJiyMXVIUUCJ0g==;
Date: Tue, 18 Nov 2025 17:46:54 +0100 (CET)
Message-Id: <20251118.174654.1384716262322584447.rene@exactco.de>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Add Iomega Clik! "PCMCIA ATA/ATAPI Adapter" ID to pata_pcmcia.

Signed-off-by: René Rebe <rene@exactco.de>
---
v2: style and sorted
---
 drivers/ata/pata_pcmcia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index cf3810933a27..caefcd8c4b3c 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -344,6 +344,7 @@ static const struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, 0x0c694728),
+	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),
 	PCMCIA_DEVICE_PROD_ID12("SHUTTLE TECHNOLOGY LTD.", "PCCARD-IDE/ATAPI Adapter", 0x4a3f0ba0, 0x322560e1),
 	PCMCIA_DEVICE_PROD_ID12("SEAGATE", "ST1", 0x87c1b330, 0xe1f30883),
 	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "04/05/06", 0x43d74cb4, 0x6a22777d),
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
