Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C251F03DB
	for <linux-ide@vger.kernel.org>; Wed,  4 Dec 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332247; cv=none; b=LFE0gd72Ku0Nh4QGaxE9whAaRyIbPS/MtQaKouG/kAJRAaMIRmc9/Hq6hf/Dg1bqaJb4h3bq8s4s5Kpe0dCvPu6t8ynMym+hjI5dNjhJKi+GIluQCe8dXt/VpzY6fjB63Nu9SZ/lpAfasdBbZy7IVfq+sUMLRm44ZmkxmFCcvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332247; c=relaxed/simple;
	bh=252WJHRqmYyVE9xuwzM+nBJzmQeW1IVIrGa3VR42U/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAlgR1ZBBa44MJ+37eTB8dbA5lwnv523ltVDE0sH+9K7yu7l2CWRAfoMmIRZBnbuU6cOyg+8cqY9dKCzESujyrlO9rLO33YIuTvqFuDDlrVxGlVChuIcgHnoV8kRZiJE08AppJcRgTjJAplV410PJDtHsRKneCrW3/+/MEqcCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/OZePwO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/OZePwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qhsSuK/y6haVGH5HmM3lnvDB6cMNHNIazjRPI+Nr94=;
	b=M/OZePwOULcenXTD1VJysySj6xoxhirw/FqjvilcA55SPKhEKLad12+1VL15F5nIMe2N7Y
	0VK8t7A+ADsYl+WzcU4umiEAo+opXTf4nsThA80z171R227AlwaQYiij1yuGWxFF2JqmBS
	hkpnFK6pSCybmjs6Py1YAcBvbsY22N0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-IvA1dud_PSCCeFg9FBOqYQ-1; Wed, 04 Dec 2024 12:10:43 -0500
X-MC-Unique: IvA1dud_PSCCeFg9FBOqYQ-1
X-Mimecast-MFC-AGG-ID: IvA1dud_PSCCeFg9FBOqYQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e5e3bf60so19282f8f.1
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2024 09:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332243; x=1733937043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qhsSuK/y6haVGH5HmM3lnvDB6cMNHNIazjRPI+Nr94=;
        b=vziQvvLFxV5NaczhiJwy4ANzEW1WaslRPZxa+gW4BJvyMHGn56yl8mJnBa0MHf9L5V
         NGAZyHbFaoz+b1KShauRJVBXzf4uWZQzCsf7JJqkyiZi5fi2KajUG+CEthbNrwoH75XX
         e8HuGF3z/aa6WtgOC4yOZLo3yGX0TnMNE6FaQBWISi+Q+Oue6Bh2UCSkMNWH2N20es1c
         a3xO56Ol3vezafc7l0Z3SXHG25hnkcucbMdaTFsE2C4dzZsiIBmEhRfyRzFQpUoznC5B
         AXUcQStHL2jF2a7PBkKCLNRKRUh/QhrhmQkhm1iCgq9WlTcGR5ysSXzhAYMzXlpukMTP
         gOHg==
X-Gm-Message-State: AOJu0YzAVDl4Xo8mpX1LJBs0rRIw/nGFzsZnrGVsZFl2Dcc2L5XUnJV5
	U6xLkM9zvGLfLkGTkFn9Wl/qjrDrULNMsSyous9YAcODStzzAS3Aw2RgA0Gz2Fonb1hwU+DnGuM
	Bur7giLTJLZ+A8rwCuoWkfWp2Y9k1JbUQ+8xst0mbnezUAgyavNAMMVG3RQ==
X-Gm-Gg: ASbGnctFX1wRGaKvg4a+3Dc7157rJLoOEn4AvhrgrAaTzuHDGAt25sz9Bb9C65Nls+b
	vSTOFoTbYXKa18qH8IkB92onCZPaXXUzFfe139FapcU0d5yVDDzTN+SsBkAngL0KPNLQOrU3iOr
	1PlpL10narNTNm5eRSlFhKo1E8OagcThoncgDAAnd9jcPR9j9vZiyT94wTHeXyvaJMotWIutQv9
	Gfo9o4/oChVD+a5xWzPC2qk1kEz9gNW8PEHb329mMY9C4VcOgKuWBeXgUojCaMFRZ29Io7whpdF
	g9NQhvjT
X-Received: by 2002:a05:6000:1a8d:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-385fd3c687amr6454470f8f.12.1733332242769;
        Wed, 04 Dec 2024 09:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/GF6sPiBa9HI2oPIKp0PMZ57apURu7dhWa3Yf8IMYFPURi79LO0lLA26zp+/eQVZs+3r20A==
X-Received: by 2002:a05:6000:1a8d:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-385fd3c687amr6454447f8f.12.1733332242416;
        Wed, 04 Dec 2024 09:10:42 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 1/3] ata: Allocate PCI iomap table statically
Date: Wed,  4 Dec 2024 18:10:32 +0100
Message-ID: <20241204171033.86804-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204171033.86804-2-pstanner@redhat.com>
References: <20241204171033.86804-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ata_host.iomap has been created and administrated so far by
pcim_iomap_table(), a problematic function that has been deprecated in
commit e354bb84a4c1c ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()")

Ideally, drivers should not need a global table at all and should store
ioremaped BARs in their respective structs separately. For ATA, however,
it's far easier to deprecate pcim_iomap_table() by allocating struct
ata_host.iomap statically as an array of iomem pointers. Since
PCI_STD_NUM_BARS is currently defined to be 6, the memory overhead is
irrelevant.

Make struct ata_host.iomap a static iomem pointer table.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/libata.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1a85d46eba6..d12a9627c96e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -23,6 +23,9 @@
 #include <linux/cdrom.h>
 #include <linux/sched.h>
 #include <linux/async.h>
+#ifdef CONFIG_PCI
+#include <linux/pci_regs.h> /* for PCI_STD_NUM_BARS */
+#endif /* CONFIG_PCI */
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -615,7 +618,9 @@ struct ata_ioports {
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
-	void __iomem * const	*iomap;
+#ifdef CONFIG_PCI
+	void __iomem		*iomap[PCI_STD_NUM_BARS];
+#endif /* CONFIG_PCI */
 	unsigned int		n_ports;
 	unsigned int		n_tags;			/* nr of NCQ tags */
 	void			*private_data;
-- 
2.47.0

