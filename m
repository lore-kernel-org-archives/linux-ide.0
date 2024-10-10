Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533051CFB9
	for <linux-ide@vger.kernel.org>; Thu, 10 Oct 2024 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525679; cv=none; b=eL16NURXd5Gmc+UdpZoeSc59YHv8WeysdK0hQE284e/YYUtZRK98B0Be/xL5hFc8XGRXHkxc98JsbpnoH1o/Qo+FjZqiZ0evo6qw23eCPZzVcaua9f+83itjOtWfNJ/CtiUxAkkJKfurhfEXeRWYJzYMdG/RhzenfIM3lBf6ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525679; c=relaxed/simple;
	bh=2T29WMhj7SyD/+T8wmY5oO8PbPwtokFiHHAI3L+l1+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DgfHkQ5S0hRNGT+P7cicUe7HFEL/a0+YoD1/i6z/36GtgHwMPb1+HCBA6TSJPSI9TvJ5WI/g7b52rcjppLCgIfJotDr+iWfZDhpA/FkXxRxVkT7g24O9uMqh8V+OALJqVwWG8A4i83+ebdNxmy0L74okZML8cTh/sFv2vIrkOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvh1saeh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvh1saeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791E2C4CECD;
	Thu, 10 Oct 2024 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728525679;
	bh=2T29WMhj7SyD/+T8wmY5oO8PbPwtokFiHHAI3L+l1+E=;
	h=From:To:Subject:Date:From;
	b=Hvh1saehkIWr1ag4bD/UFYydKrCvjdand0AxiqgIWKvNNK/MykWfDVUQO07ob9OLE
	 QH9BkEfrh0ZEa4D/vIUa0m96sbaOcpqTeG2LqFSFjEKAGFRduKr2PYfVZ+jhHB4Z08
	 mkp0c5TPDwNDkz+EtG7V4wTtsp7gVqEzw7qIW9oXJie35un/SoXF07f2eaB3vQZZsu
	 YSUt3flg8JPKYbR3E39HFBMLsNyFTgr7PnsIYCpCnUwAb6Isx+wpWBvhlIzOdrKWTq
	 hnuJC0KUI4Yq01GrcdFjxIGZSfjmWTVlgNYUaRVyNZ9vaPrtZhk5KEK7hc2jgDopum
	 2nmv5C6UWoYOw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] ata: libata: Update MAINTAINERS file
Date: Thu, 10 Oct 2024 11:01:17 +0900
Message-ID: <20241010020117.416333-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the entry for the ahci_platform driver (LIBATA SATA
AHCI PLATFORM devices support) in the MAINTAINERS file to remove Jens
as maintainer. Also remove all references to Jens block tree from the
various LIBATA driver entries as the tree reference for these is defined
by the LIBATA SUBSYSTEM entry.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Remove invalid tree references from the various LIBATA driver entries
 - Changed commit title
 
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..4b5fdca2de63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12940,7 +12940,6 @@ LIBATA PATA ARASAN COMPACT FLASH CONTROLLER
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/pata_arasan_cf.c
 F:	include/linux/pata_arasan_cf_data.h
 
@@ -12954,17 +12953,14 @@ LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/pata_ftide010.c
 F:	drivers/ata/sata_gemini.c
 F:	drivers/ata/sata_gemini.h
 
 LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
-M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/ahci_platform.c
 F:	drivers/ata/libahci_platform.c
 F:	include/linux/ahci_platform.h
@@ -12973,7 +12969,6 @@ LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
 M:	Serge Semin <fancer.lancer@gmail.com>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
 F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
 F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
 F:	drivers/ata/ahci_dwc.c
@@ -12982,7 +12977,6 @@ LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
 M:	Mikael Pettersson <mikpelinux@gmail.com>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/sata_promise.*
 
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
-- 
2.46.2

