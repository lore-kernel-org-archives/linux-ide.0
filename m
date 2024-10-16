Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB620E028
	for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082521; cv=none; b=s6tANevCwyGpR8RZDlVu/WHVE92JYRCRG2owd3mfP+RK0Z/7HS79I5WOoQ66p78E4us5uAc8nRmurcyukK4X2xhpw5G8L0PsKKNNFLqfxu7GwqClQ2vuj7MXd0gbosUdEVmSMkmL5MGvYA7+ke8hqZxN1kzrO3ikqWe3stss3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082521; c=relaxed/simple;
	bh=KRhL2deOZRHNfuo7/CizyodCPj2p+YqlhuhaNJFSYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2dW+fpOyMYUonVT/cgboguGnVU0MVdZCjdSnTZMB1vvisfHEulxq57hd4qlS6nZQiC2sY+GcqrlKk4992aBd7guc1uTjYsNVJORW2tDsEDqtx9KVd898Cd9ywYmfkqUX0XWsXDjk0emEoIUeLy7PBIXYdoYN82cB2d+Rfc9ZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7Etg1eq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7Etg1eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
	b=i7Etg1eqIc+8Np8yZoUafxLznTv3B7svDH5y41lDw/wi/FRLlO7aDb7UgLAnytFFDuO11n
	VS6cJgHCjpud0j0VgLcZ6ENUPni9d9o37F8vaIF7h69MOt77DmYY6vY8nEJr/k4o7wFuGg
	O79jMyWEZovYXJN1TLxxgDzwtXaKOOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665--S-hZqAuPougFSvN8xvw8Q-1; Wed, 16 Oct 2024 08:41:57 -0400
X-MC-Unique: -S-hZqAuPougFSvN8xvw8Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso2698441f8f.3
        for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 05:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082516; x=1729687316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
        b=tYUwALPtCUNAtnDd8oymoXmDll3NOyIkgXNy5amo5ZkMyb5km4U/kpMEnY7dGBpNq0
         Ms5sjLNtSH3tdainwR5/JbsHOwBcfovtUdPoXIVUlzyFqpzqz2wFswAuCV03wliLXtH4
         bewC7lKHX2OwbkFGNHd2rShgZ5OzF/X0vt3gjI7GE/3Besq1p8QcdpGSyQuK3bt6v5RT
         1rUHYcbJYKi1kXRSIOOOImhmjUcnsCLl1ihbvgLFyo/jIzPbwljHxrhW6oVAzKBYncId
         W4e0XCl0HiMjWuvtTjQTcXJ9XF/6ZvIUY+D/gOnDtF9GMAeogGpAwValv+5AXK2jpY5/
         iOUw==
X-Forwarded-Encrypted: i=1; AJvYcCWPUCFMJDiv1a81OhQIyGiEquTBe35P6yUT3lMtzXaJEj1lpo35g7/HzEMdr6MGmFzHN/g4f7t+Rvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/i8qr96BBrZG9OfDtW7ww+i3l8W5+X1TyjfKfideRG2ctG8P
	eizF9B7ZcprYZc27M1dlcOuPgyR7Jr9A0bEIHCwbnWsztOTNn6LaL1THSidJoIZ5Mc+PBQh8Y/M
	nUjioKesjqT3HTIt2UoUWwUljcij1KiRnP7Z2VQ58tiiDotY9JuDbT8r/dA==
X-Received: by 2002:a05:6000:e51:b0:37d:452b:478f with SMTP id ffacd0b85a97d-37d86bb6b99mr2654888f8f.4.1729082515868;
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK2H8/hCpU0cwTi4SjNpk9gLTo3Rp+q9K7qNZEaDsuWbxh1ss7QKO67/oTjHSIwVlBMGEQyg==
X-Received: by 2002:a05:6000:e51:b0:37d:452b:478f with SMTP id ffacd0b85a97d-37d86bb6b99mr2654843f8f.4.1729082515414;
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH v4 07/10] ntb: idt: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:29 +0200
Message-ID: <20241016124136.41540-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016124136.41540-1-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
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
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fc9dfe82474..544d8a4d2af5 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2671,15 +2671,20 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	 */
 	pci_set_master(pdev);
 
-	/* Request all BARs resources and map BAR0 only */
-	ret = pcim_iomap_regions_request_all(pdev, 1, NTB_NAME);
+	/* Request all BARs resources */
+	ret = pcim_request_all_regions(pdev, NTB_NAME);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request resources\n");
 		goto err_clear_master;
 	}
 
-	/* Retrieve virtual address of BAR0 - PCI configuration space */
-	ndev->cfgspc = pcim_iomap_table(pdev)[0];
+	/* ioremap BAR0 - PCI configuration space */
+	ndev->cfgspc = pcim_iomap(pdev, 0, 0);
+	if (!ndev->cfgspc) {
+		dev_err(&pdev->dev, "Failed to ioremap BAR 0\n");
+		ret = -ENOMEM;
+		goto err_clear_master;
+	}
 
 	/* Put the IDT driver data pointer to the PCI-device private pointer */
 	pci_set_drvdata(pdev, ndev);
-- 
2.47.0

