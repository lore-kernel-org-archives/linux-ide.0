Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A1157A43
	for <linux-ide@vger.kernel.org>; Mon,  5 Aug 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844946; cv=none; b=gDDLJULqMPwdPbgPczvD86v4d+p6e6oWwRM1r7ye8ND7AC2PUUs1WFKeH1961lxRXjz7A+tEKoyZE87cwBH6S18ZbHqs3E3IKgpBeQNHa3+J5vhQ7EKySEceMLFhJjYznIrw7rAY5Iql0lN+Ce8v1nfqi7uNHY6p12NEReTiUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844946; c=relaxed/simple;
	bh=XVnRSeomOV2CcZ6TomefmLqSPd3/SQ4wMxlPfANkowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAeoKDAhQjfY5YhYRAyIw1A8d8VGpMuajCXfVCWmKPaRlbna1bdFvLKUuMz5tcWfCsmK1Oqt+8rYrsQTkVkdbchjM/oMR0GNF8o7w70XKxi2TFlqVRjeu0UDN8ietxeW/rQEBA7EM1gEL4/GIPzUq2kmX9BCzXRKRtYxV4Ts0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1wYWVum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1wYWVum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
	b=S1wYWVum8TFS2UjpVsx9nFRDJmNZEeIewbOv5fDBkODRJ1fJ7xSJv+OZHAnNasa2pKdCyg
	h2FGwztRwWi9Nlcb2d1UfHjLe9ICBAjsl/yJMYmIHUdqQjH5gxUhwm+1VN7pYHFeR4gemr
	txtL4iTGQR1DnaQbsvFvGpN6rquViWU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-oFts_6qfOHyKbWA2jOrO_g-1; Mon, 05 Aug 2024 04:02:20 -0400
X-MC-Unique: oFts_6qfOHyKbWA2jOrO_g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a11cd40426so1597353a12.1
        for <linux-ide@vger.kernel.org>; Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844939; x=1723449739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
        b=rqCBN9TRFis0omsel0EoAd+VvXRXpMRoUc4rAaVklAffSG5xqkvHJLw2Uy6Y5kWj+N
         SxFhTfGp96JxzI00eS8dvfhnzE/Hc8d46+LC6nB0MYW3dCXu1QedC9evhoZa+6mg0D1B
         d60HMU5tjjf044U2HxELD4G2ZBEpy7l+zQEkQgvnvkmkxuSctNel+UX25c0QBIrJWCgS
         dpMn90siwMow65fB/om5chZD1y4uQo0EY3x6egSWpd2OEn2pfLTas9v0U3tcnwNzV+8E
         WR3k+rzMt68luNbo/lDvOQDWWXDgA5aV6Az/s04C1jD7s260a3tHTytblnSrr1nBygE/
         ts1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlgpoQ2xveJS4er2vj5yE24PWpAZuljk8PI3SVal1Fpu2V3XNXjZwLMo62qfqipX3G6b59K46SXMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRSRGKbDIqUjJ3CmDiV/PKsSiztlaqJhzc/nkMcO5YymMTh7g
	4aBQlTEqoQ+iF9bOHZo8iO9KBqKhbMs9FGjuiESY03SDIC508AMKFFK48PSrmg12Cr7bJGtqXy/
	RDB5Sv2u2AVXamzY14DvSmtcUbB4PvUP+zcg00RZGpeYCMjMQP6gvSMznkQ==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513584566b.9.1722844939185;
        Mon, 05 Aug 2024 01:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SJB/SW4G2idNXeZQo9TGP1SQwm7yFqzOP7n5lB+7g8ap58Lk3/dgBFHgiZuUlpVVamp1Nw==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513582166b.9.1722844938741;
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2 08/10] serial: rp2: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:35 +0200
Message-ID: <20240805080150.9739-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..b6b30bb956fa 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.45.2

