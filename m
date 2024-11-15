Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92064157A5C;
	Fri, 15 Nov 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704965; cv=none; b=Fp9xsprANiqIZjMlExZ36BLYS32xNg2RLGR+kUtCNiAidxIpH9uL5DoOzZwhEUAvBbLxtUgdAHQjbdJR7uD+pJVS4Nvx8xXxuzw9vsIwQDc1DSe+rUjW7lZkTxHa57HAZ6fx+Bg1DE1Hd00/RKMOggs7tVDvARaorlsbs7jm0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704965; c=relaxed/simple;
	bh=j5PhO6hZyF/dqerXvNn2rzqNQVErOMrMDzDDt3hFU0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJgDK8ObuUNcEvdeldTl7u7x29ms3s291lwnfpNp96mp3gOmmcGsfipE+IjEkBeJteR4QzI1Ac9QqnbbpX34EcGfQqlPNSTtpsVkoqCK1pNtN+c08MgwNDC2jztW4kn7Id+yegA6+6d613hC4h44AxA4IqUo3rlOGqt75RASVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kVQnDZSq; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kVQnDZSq"
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id C3Z1tjZluyQmhC3Z1tlyCa; Fri, 15 Nov 2024 22:09:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731704951;
	bh=o6eHVQOitY/M/PTAZaPRvbBS8FQjCLk1MeUGKW9AhOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kVQnDZSqQnsDjh5ACnFnnEqCAXkWPZ6E9m2R8jt6wMxDwJ/od1EktiqfIF7pmquED
	 oLzSJc6BlJfxPCsmbNaqWSh1S8S0uUHiDH1lep0Kfw4GBKU4K8rPNfEmLzIWMsGO5L
	 6D+k2y8fL3buhSDP3lqQfSENVP39DZvIjFyo8GoKeYpOYizRd0rrml487tzTrggCuf
	 S+OmmQ/IN5P773vslkauV4KEiI/xo1fA/91vn6+qiXSoC02mi6iM4v/TuQsMfp7LNm
	 pS1+BG7TafsqaDeft8IYgsAomqFVNsuMs1G5cnhpJRmin8Sa+faFKzpAd7xPQOtHFN
	 08Wv6bq2LjFDg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 22:09:11 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: Constify struct pci_device_id
Date: Fri, 15 Nov 2024 22:08:55 +0100
Message-ID: <8bddfee7f6f0f90eeb6da7156e30ab3bd553deb1.1731704917.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct pci_device_id' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4245	   1454	      4	   5703	   1647	drivers/ata/ata_generic.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4725	    974	      4	   5703	   1647	drivers/ata/ata_generic.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
---
 drivers/ata/ata_generic.c  | 2 +-
 drivers/ata/pata_atp867x.c | 2 +-
 drivers/ata/pata_piccolo.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 2f57ec00ab82..e70b6c089cf1 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -209,7 +209,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
 }
 
-static struct pci_device_id ata_generic[] = {
+static const struct pci_device_id ata_generic[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F), },
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index aaef5924f636..308f86f9e2f0 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -525,7 +525,7 @@ static int atp867x_reinit_one(struct pci_dev *pdev)
 }
 #endif
 
-static struct pci_device_id atp867x_pci_tbl[] = {
+static const struct pci_device_id atp867x_pci_tbl[] = {
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867B),	0 },
 	{ },
diff --git a/drivers/ata/pata_piccolo.c b/drivers/ata/pata_piccolo.c
index ced906bf56be..beb53bd990be 100644
--- a/drivers/ata/pata_piccolo.c
+++ b/drivers/ata/pata_piccolo.c
@@ -97,7 +97,7 @@ static int ata_tosh_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	return ata_pci_bmdma_init_one(dev, ppi, &tosh_sht, NULL, 0);
 }
 
-static struct pci_device_id ata_tosh[] = {
+static const struct pci_device_id ata_tosh[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
-- 
2.47.0

