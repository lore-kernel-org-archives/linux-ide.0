Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E01AE84F
	for <linux-ide@vger.kernel.org>; Wed, 31 Jul 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429329; cv=none; b=SLseO1AKFSpqu3lefukhuB4BMsFOxsEOXdL4i57/xMEzG1h1g6D1VXnLepq3SjMKFlxhr1dPJ31VyWa202/eWiU6VUfJPnz73XY8FKz+24NmMi7+Czi4fjFnhnNXVWQclv/hb5LMrtQJLtsETHxLh/n0tOYM5A/h/zF36FwNTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429329; c=relaxed/simple;
	bh=4GsXkzyF1zXnnVccFMmH9MHA6OoXOba9lWFScuAVpNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cI7kEmSiTfsUFUzzM1o7W9C0JQlQ0WPdZaO0YrLQUtVimCxW6ChXxsQ169+E20TWvTieUWZc19GMWcQCAjDsxYL7uTpy3hwozC9PzXHFDAAzf4+VDTUHuIcf0jTO4z5XIKViIMsfvz+CLLhzX+qV2LStZir7SXm6nfHWBVhV1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bljPUN0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bljPUN0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722429326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
	b=bljPUN0+7A3a8sUv/LsiUhumGN+voMGsoL7aHlHhCpMXG1zYE5kRdkb1gylVqebXxxrFhj
	g72ckXILXxtmEHqTZOrO3AVng5mE9yeHpNIP33ztwQxN+ictKcKo4UGDD7bZd5NfwQWdAq
	OG7Xwzg1JMF2DgX2z+z0CQKI9Fd1oG0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460--_AMwmCxOta0SOw95mcqQg-1; Wed, 31 Jul 2024 08:35:25 -0400
X-MC-Unique: -_AMwmCxOta0SOw95mcqQg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso4289345e9.3
        for <linux-ide@vger.kernel.org>; Wed, 31 Jul 2024 05:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429324; x=1723034124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0H3lAj8yc7c4WzJFe947fa0IqEnSWxptGsCiAxUCV8=;
        b=db9gOO3Iwgot+NfIeXoj01UXtpL2chMyEb1tdZe3XaHZ2fg1U5rIQvcnbzArZBzF5m
         vfbilUWPpmx8/cRQBA4qLsG1rJqW43CYGOXpCu8VKQ53AB3ORlj6cluopDdzDMYngGNi
         B/kimt5/gGfJKPddSOM8TuKDXiC8sd2fBFgnT6EmcqoUYw/GpiWjdaiFaMJ+PcDM8SES
         cd1qEySLqNQKDy7Z/dtXX9LhUmh2Zy1uV3k6hnwx3GhqXC8zVsdbKFBF7Y4ZHGaZmndz
         7f8LnA7/A/o9eyy6jMqS5uWiBE67qpDlqOG/64ntAGbPkdl8WXHJ1fQDWmv0lENp1/ks
         D8MA==
X-Gm-Message-State: AOJu0YxNePRs8nPcgwmf1PuzaNgbgLKqM9JOpkokLXuUeLEKQZqu7Br5
	AyKwO071eq5Qqf1cVEQUchJUsOKMmktVhGY3OpJD/hsfXfa51RdBes7HRVjaeS2/7D2NdfIc4ix
	6NcIgLaUZbAMpdCmtKpiBGNn9H64B69ptQ78euhDmc2j3TTjYU2JpGaawU0RAp37SRw==
X-Received: by 2002:a05:600c:1c12:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428056ff97fmr91893015e9.2.1722429323706;
        Wed, 31 Jul 2024 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfOvupbs8UN9EJ8k6ZFAunCkUlCgJVCS0HdMLmdtgm1szKAcCpadESixN42bMPQ5/HJrVDGQ==
X-Received: by 2002:a05:600c:1c12:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428056ff97fmr91892875e9.2.1722429323157;
        Wed, 31 Jul 2024 05:35:23 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0829sm16925976f8f.17.2024.07.31.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:35:22 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 31 Jul 2024 14:34:54 +0200
Message-ID: <20240731123454.22780-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
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

