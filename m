Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694C1BDAB7
	for <linux-ide@vger.kernel.org>; Thu,  1 Aug 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534407; cv=none; b=Pelfqgv3mn+CV1eliUJsxV62AnwLWKjD3BKYNorUf914n9eyd7IHs86dTlxyfPbdrtQ2RhYJoIkab7jbQkYeWGiiMQ1hGiMXwfJxJR31Xvmpz3exLAfK1y6NuxhH9hAVw5MtYNOI0KVTx6vc3JrrYuEBNhpZcZ8fQBuT7pek1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534407; c=relaxed/simple;
	bh=4GexEWYmB++TVKtf95ojSGSSevwi4ufn2RVpQzXAHG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSQ3irITDLvVjUBfaRNG9SKNHClU1SXk3inx6zbFTIGCvD6uOGom9VdpJoT1Nx4PRHCZHQVt2cqvTQb77BSgusaToZisSztIkWXbEOcTXWKJMtDFLGk3T0uzDjoBQjau7Pnz6RFWap2hoUZBEfnaCOCOGb6N+CxRvTn7RlvbW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfs87WY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfs87WY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
	b=Kfs87WY9Vb6wvOCN6m1yhyQjWjrgggKllyUikSRNJPMALVeBpqR8kfc7OEVDmDx1FQk4mW
	VHbsXmtvxqMIDOJkEwSHOEv5EJLPiyetXSVZt95+HfxQaHGosO/hDPo+F/6W1PS4QlHtcb
	3ivXHTHypCLI3I/6A8vmdonKbZqVThw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-5DjJeG-UMsiQZFFtqsoWLQ-1; Thu, 01 Aug 2024 13:46:43 -0400
X-MC-Unique: 5DjJeG-UMsiQZFFtqsoWLQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a0d7d02a8aso1129984a12.2
        for <linux-ide@vger.kernel.org>; Thu, 01 Aug 2024 10:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534402; x=1723139202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
        b=uuSAH1xHGMl4Wgbwi1T4HeGIHHY+mW1X26BDcscrAUPQXYEnrFWi4JYglTtTcI1sUa
         Y4nr+PxlLzz1uistDsYFfstJunIrCWCTs5qCwCQd6uooXzrrSCuDSpHufP3NUn/oG9YI
         uOsnZZrcfinVazcYmhTIjB+hY/yG9pDG6gzfT01E+ROI+W3r8J79ExRAyjY7u4eAPQKp
         UvRWojdXeJxTb5v0ugP5XZmn+xTQQd+LavkvuYoANbfekfYsD/wLdGEv7B0lsGluASQ/
         PsvF17IjgGSpgkXv1E6bcdfzH8jvkGp0nSUnsXrI82fo8uLli4kDOCFkuiAq7y8by3Kb
         0xnw==
X-Forwarded-Encrypted: i=1; AJvYcCWVtkuPPmX1/fnvMgiftD7FsQJoLaJ9+raSBtl/vInLjpQej2ZfLl2264kI6bgRPrD/2wkxdlh7GV6K81QHOFpBT9tlwL+wPQXY
X-Gm-Message-State: AOJu0Yylz8XIEPaX0PfaugbJtHfbUotq76KKWX7mXLn0hCX2EdxTCDwd
	UZZwY7Nh4fh9VsF8vTdT1RSY/CCNc0GElFCl2GciSDJxXcrmiSbnO7ekjKa6h7SId4HdHggQcID
	ugvQgKhl2r2dXAiNsThH5F/7PkjsoGJc5g7Va/hxUSs/J25k3dRktglssyA==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40293666b.1.1722534402510;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAz8VECBqGLuxnHbBqNGh97d2AXukf5BmEUdwoQf65+BgJnzGGIwfvlOLLLnXxYF4IguemOQ==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40289566b.1.1722534402107;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:41 -0700 (PDT)
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
Subject: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:06 +0200
Message-ID: <20240801174608.50592-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
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

