Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCED208D73
	for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082509; cv=none; b=YDYYq9XkqAIzLY0v0Yrcdf5JuFqXf+4QrXfV6J36o8d3fb+YE8hw/C2L7kynciD7fosfbDcdWuPNoK/reYFQBpChYu34L5z57L58SevANU1Se5rGnZCuGMtmxB5K+j3KPIyYOX/uf5IBecUaR/yDOMcvXV8G+C7dErNe3reDo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082509; c=relaxed/simple;
	bh=pzHm+p7iOQ3ZHeJddCbAsTb72gDaFZfayku/dAdnQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I52ro3vxzdGvnazcyyok7KPgKwS45PTLr1jsrf5k8RGdlpkw7GKgYw8RsbOtguGuZaPDBPYmQK6fawVr/G3m7z6PueSbrympv9AX4+zgxToFRcY2deSlZcVAZldrganCDnZLQDVSL9dePH2GfF2owwyhF06tNXprJaTjaFyET7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP9k24RO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP9k24RO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
	b=dP9k24ROouWtoi0wgUP2ERMPrz1gPIoIj1Tljav8cuabAI6RIcvvhl66LBdkzWAXdwRPck
	iULxpx38BzaRat+Xc514hijBUnjznUGEZZlQgC+eDw6GZUvIpkQ4cgfBx9ia2xEY78lpYj
	uIvmgE/tOogNcGu28g8bkmaENtm6os4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-W1xJQHzkMu2RlsyAwBNrXg-1; Wed, 16 Oct 2024 08:41:46 -0400
X-MC-Unique: W1xJQHzkMu2RlsyAwBNrXg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43058dce286so37974755e9.2
        for <linux-ide@vger.kernel.org>; Wed, 16 Oct 2024 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082505; x=1729687305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
        b=lp+HrHPB4koL3juCW/NtWvojlC6xzorcxu/XzcXIqhVq/HfT52uMmNi8NtKnZN2/AA
         8EVnta0vw97wLT59/yiJxt0LPLOn3NBCq5hl87A4e04XwdWgcHCJn/2ydzUTRhzSI2vT
         FtsUK2s8Fzs3pVP/otpS9lupnx+6immGbXgBb2metSKhcr13Jq6vKIFtUqyY70E6RDf0
         zXXyjuqSWT8l6Fner2eWam7DjRD70Lo7ieUOhzrMQG98YO+5FDOUFJx65VFEnZ1Uqn+M
         pRJX3oKmVcXdgqvUoxgKxHVp4DSDqj0JtjyH2FHOaBug77Q1HmJMU++SCQhkmgbqIglr
         ePsw==
X-Forwarded-Encrypted: i=1; AJvYcCWEtFzqTgvrnfIuvNwHrXYIGe9+oroaJp6qR0cu5GbVYb1tv95TXkkxaRncZ84v/nmj9PHYqZEVxlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaiMVOsndJlG4Bq7QWTK4SQIQ9K7+nZPF0smXq4ELHgdKPgiYP
	RJ9UEUx4+nfKrWP7En6wrupBqGOQ/0js2c98UVu+SvDW9ykmor+hLnUijZbj0EYKwAwp/u/F+sr
	wcEZcvF1vlztNvl/CyaUGnsA0IeccuE12Bg3KlEjy9/Twu2EVt6jNVKfytQ==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128784885e9.7.1729082504830;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxF9+2xYoc2iAcnZEJLUiZOKpsxfW9lx+KNsJOv5CduYI06lG5Znx9zhblHV4xRBC8nAdSQ==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128784405e9.7.1729082504314;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:43 -0700 (PDT)
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
Subject: [PATCH v4 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 16 Oct 2024 14:41:23 +0200
Message-ID: <20241016124136.41540-2-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..2a64da5c91fb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..3b151c8331e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0

