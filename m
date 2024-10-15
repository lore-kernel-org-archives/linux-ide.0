Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503F2296CC
	for <linux-ide@vger.kernel.org>; Tue, 15 Oct 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018347; cv=none; b=fQL2fokqFqlbzBEBN3UCIOjFVtx0mgMVDbEfi+3PuQNBQAUGSotgP0nHXkXZMehLGFLu+kpco/ox8oQgwtBMuEyzwP0tPvtSWu2oOAZPgUhXr03RAFC8GOhGXVz+cBTB6s6VGQgkH4K7Ki6/GpRnvPbdiBz8X7nzIzqyRNPh6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018347; c=relaxed/simple;
	bh=ZGl79UfjjHp/dbanoMIKpsfiBb1RGuN8b5mG9T34Oqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8hWaNW4NS9Pu/vyc4b+KAtyXd5k7p8u02qsk1Qnsf/+4CuGXhX9jUD+CjNpvAV5c0dj6KAGj24UIS71rMhLEmjfNwYj+yhpAfABCSHFmvexyzrQzo/WXQz5zA2uU6FFRMY00rPvFe4P0Wvnkj74DF7IJIvRd/DhfwalosDAgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpEQlPAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpEQlPAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXTMrjROGaTcKBpC5zD8IzpbS8kTElR36tpy9F32tfY=;
	b=ZpEQlPAsYeOvXntrSbW0ABh7+2tSnwXa7WDwEHLDoPzkzPlltrF8A4RHQEjn0jScLBUlis
	wmd0W+PAX8Yx9bEeoXRDah/Ys1P/curCYyNwbglXIlutUGsLFDcqyRME90m3ZSCtEYFUp5
	H9moGF9JCYMYdcT+qjaQvzQDOz9LTZQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-RTk3YwXfOLqLViAbHFCjEA-1; Tue, 15 Oct 2024 14:52:22 -0400
X-MC-Unique: RTk3YwXfOLqLViAbHFCjEA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c935cc6a96so4298110a12.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Oct 2024 11:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018341; x=1729623141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXTMrjROGaTcKBpC5zD8IzpbS8kTElR36tpy9F32tfY=;
        b=M2IzP+K8YQ2M0jjxv3fo+LossyCDT4GJtxYBzKz+PDOVkNT0VWP2gJmvctF6Im0w4n
         4doB9C9SUHqh3IC6BXZ1tlPcl4yIvK5ivxAq0MUT3WkYUP7dW+1xWY67twBgz4hnwLiV
         JN4J2ngjdbHWbZyXB3WN4zD/PBcqAl4rhL/fyukZUrOLKqL6M1rXqpcEZMKyczIyPJaC
         Sjc3Q+//IrOfyhTxW3b1ttnWnW/669DSC/Be1XET1iwa/veQk0gHUQpYwE6PMf3Y2JzB
         YjAQ4+QwO/aww47QFNPtNrDVe+URBrTiAUjYiLTCMhD5qsASfLgrvnJF1IQqsD+/zGTO
         h3kQ==
X-Gm-Message-State: AOJu0Yyb8+l35yov8ojF12qJ8uPwQ8Tl6VYCOnnmX1ma8sDNmRnQW/ME
	HQpOlYD0Ty8+7lGmZXtc3zzgG3S0k2x8Vq+MRa9+jFRe78QzA/g+net6VJAdP+ZynZ86YmLdjDK
	AAmBrUPM6z6Il8bT4w4OT8XyEMPHThqmy6loszt3Zowyueq6cm2L4bByomw==
X-Received: by 2002:a05:6402:520f:b0:5c5:ba82:c3b1 with SMTP id 4fb4d7f45d1cf-5c95ac4e471mr9746964a12.29.1729018341537;
        Tue, 15 Oct 2024 11:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4IRS8nhPSbHHMGAr1esFr/1sORzxV4dHhLUSla/ENaT5Qe2x1SJKm+qMzu8Ky2rtxd6imbQ==
X-Received: by 2002:a05:6402:520f:b0:5c5:ba82:c3b1 with SMTP id 4fb4d7f45d1cf-5c95ac4e471mr9746938a12.29.1729018341069;
        Tue, 15 Oct 2024 11:52:21 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:52:20 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 13/13] PCI: Deprecate pci_intx(), pcim_intx()
Date: Tue, 15 Oct 2024 20:51:23 +0200
Message-ID: <20241015185124.64726-14-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() and its managed counterpart pcim_intx() only exist for older
drivers which have not been ported yet for various reasons. Future
drivers should preferably use pci_alloc_irq_vectors().

Mark pci_intx() and pcim_intx() as deprecated and encourage usage of
pci_alloc_irq_vectors() in its place.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 5 ++++-
 drivers/pci/pci.c    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 6f8f712fe34e..4c76fc063104 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -435,7 +435,7 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 }
 
 /**
- * pcim_intx - managed pci_intx()
+ * pcim_intx - managed pci_intx() (DEPRECATED)
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
@@ -443,6 +443,9 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
  *
  * Enable/disable PCI INTx for device @pdev.
  * Restore the original state on driver detach.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pci_alloc_irq_vectors() instead (there is no managed version, currently).
  */
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7ce1d0e3a1d5..dc69e23b8982 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4477,11 +4477,14 @@ void pci_disable_parity(struct pci_dev *dev)
 }
 
 /**
- * pci_intx - enables/disables PCI INTx for device dev
+ * pci_intx - enables/disables PCI INTx for device dev (DEPRECATED)
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pci_alloc_irq_vectors() instead.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.47.0

