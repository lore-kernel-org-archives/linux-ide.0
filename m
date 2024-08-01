Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A51B9B58
	for <linux-ide@vger.kernel.org>; Thu,  1 Aug 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534393; cv=none; b=OUwTWYFIXlJfaSiLvpG9/9qN4UMBmMokfARwV3+MMhF7md8l7o0ZANtRkBq59mxMMMb2LhnRaAwoCRN0k8l/NJ0G18SKEcKQRwgaxVo1yfYC1PM+twElqcCBdT3mIo5HYZfBOPfNVMBQhKFjmqdAeRp9gym55MBq+jzAvssdsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534393; c=relaxed/simple;
	bh=4GsXkzyF1zXnnVccFMmH9MHA6OoXOba9lWFScuAVpNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dawtcf2Ut3+gLCKjzBm7/+h8Apv2YUNhuZVFE0W4zGoTqguVkF97qPNaaRdV0jcWK/Pg6DPIKqk9WAQZW/wkvS8kWagSFsmC99wMB3Id58NUe1kdj//CAfA+rhE3QMhT5wT9YT72RwAvC3Iley60gZ8VQm7h30bNucarbRDdr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC36PAk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC36PAk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
	b=XC36PAk6ssGn/KmlCgMVjkRVeDt4cIPH+ykGid7mR4qIq582Rn5NPbbqkP8NlkhdqVKIHA
	hXY2W0Jwxr5LJUQ50tydZHljph+s5tMIiYwf+lP5KE/6Qm+J1nghew26vgKhKaUETgq31C
	aEwf4r+xZRlFVqkKLmibUc9gWzN+JxE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-K-4oEh1rO8-oG9GPUtBddw-1; Thu, 01 Aug 2024 13:46:29 -0400
X-MC-Unique: K-4oEh1rO8-oG9GPUtBddw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a121cd4d27so965073a12.1
        for <linux-ide@vger.kernel.org>; Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534388; x=1723139188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
        b=aNo13fH2ksiur+zzHyR7gKqWHuGi72AZY+zz8fGQOU5PW3th84JOMCVWApnBFkjWRS
         fQjEHfksF7rrr3dclgMbMIHmYGEbgtDyFDEp9LTRgb4HGOuTbNBjf7/SXOhe6ZBz5YJy
         deGlYldWDkvK/YapmI82c0YDnCKt94reCY9NpB7z6HrKk5VGz/5pLjExuQ1dbRnfYiF3
         ye8/l23t8pVIsGRwqtjvE0vC1r+tClnfj0bB8O5ApK9rH3VRPBU633VQIt4W1XA1PBxI
         K9tuwFwXaYvboqsIMhH1/h6d0FZRLaCBCARkNt9zJT8WEyHdqHnfF5S0w/TqgbI4ZpaL
         JqRA==
X-Forwarded-Encrypted: i=1; AJvYcCU4vUkUjfY1i7PFDtHNYcfvEk9xRfWbkF9ND63vAhfSEt84kIN5C69VpG4M9i/QVtrE0ndC8ZEHuvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKFmf+NimLt729MOH59wzNrhfaimLDhzsNoMfVwfEwWbqq1yQ
	FWXg2x2MrevqV6Y7lgjWvLJmaiE6M0+OyJAx+KzAuDRx7qt7grcbo8ni+Oy/ICVxmWx5D9e/ebr
	L1ZwKkjsJpqSzjy1QYptWjSmON4n0J2pAEpovyVRg+vlrnDCtRp/SF/1acQ==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr42334566b.9.1722534388105;
        Thu, 01 Aug 2024 10:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7+oRR5+V5FiruUSNAOtMqMogU0xoX7L8F4UgpPxKzFEKWFNaoyQ3GOxAIhzZxR/CPVQ6xQ==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr42329966b.9.1722534387535;
        Thu, 01 Aug 2024 10:46:27 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:27 -0700 (PDT)
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
Subject: [PATCH 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Thu,  1 Aug 2024 19:45:59 +0200
Message-ID: <20240801174608.50592-2-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0ec2b23e6cac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..5b5856ba63e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.45.2

