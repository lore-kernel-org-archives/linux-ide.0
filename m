Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABE379EE4
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252541; cv=none; b=aa0WKLgFfQ2zUrlCtyK0rI+7V6IbBv6539J0ALboMNIHe56UEJ3nFLxCSEDgWpR+XP5pwjWmX6fRCbLsLrdzGX2hSSZP0YvhrLZpGx8wKJCV5/oAbVsl6nf2lXc8D+d0PPsvcakELVXJLhKHMkWit3Y7NViXYG2NFlEhzp+Qa/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252541; c=relaxed/simple;
	bh=JuMrIf9R7hEP+3RHht++4+esDuQxM0Aeuyy4yk9owSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGedEKhCNWNy3W8pGzJ4tvvaZbiimNlKgeYYYPol60RGuAE/OR2/QFey+GCCnFA8ByQO/M89Y9fM3Ny1UCfqVCQ53K04ENvQvb8JlU/UjswAYbetT18GeFBjEOrecFOVnDkrbaCYC9CwivoMhePQCtJw1n48GF1JYI/T3sUFcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PmuCBuR4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PmuCBuR4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef82204c6so370776f8f.3
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781252525; x=1781857325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPIlgBBaZZyxfAuMtK0g8XARo4p0F3DOvEqLU4Hg1Vw=;
        b=PmuCBuR4POUjMbGuq5s/duZr4OelJnJA7qG4q3rZI09rQ4gdsRGZlGV3A29QBVZaun
         jsakpfnjYmqGR1ezVqE9zCO4VvEDLWPC86cR4BhNIYE/MmM3DeQ1/lM5IYHtmwLZAuEe
         WdaoGc9C/GBhqHl9pc7ViZhfpTEA7bX2xTFdF2eO+FXlXlr0OzxaR+xxnCBudsnsQva8
         q2JuN6l4CXZsBBrq9mp9W60EqXHTXx84sZOwmX+DEpsUY8rbVcGqsvjjKahuAoY0v+6v
         6Nj9Oi1ycNXB+lKVQ5rHHEOh9bKSjGt+BMpWznGcpo4RcIB0GeswUmFb3+T5+rJTSVnl
         4brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252525; x=1781857325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPIlgBBaZZyxfAuMtK0g8XARo4p0F3DOvEqLU4Hg1Vw=;
        b=RybZ0sZ2CBN72JMoNRWbMtMCCKRCyAxIzNWWeaV8i54nb0y5oqRvrUCmsuAaZ3fmDK
         7kg+nwjzs95CajmY+UcFb5FkzioyJx1HW4cRl2tnCU8uqBrr9ND0c5wsZQPN5TE6WmD4
         iZJsco3mY3YPSR7lfseSGbU+sXuwNtaVgF/P4RQU8Gcejy5IYERQQFzl9DDGRusSl8X6
         tdpochTouzZO9T224ykUEiVvMXBMPlSPZC4BJCWcnAj26S58Li2egGbXeTe+PIrkyvEQ
         9AvRDGLvv5/4j6lQe5kPzqhIXIgkeCYY85c0DUA6Bg0haEh2mkcHVZFiapk5okwUtiGh
         HWUQ==
X-Gm-Message-State: AOJu0YwFO/juHYy3nF3s3jpmr86DaS9kCRSy5afJ+eXWKYrNvnwwBlZA
	FQke8R8j+mOtgl48VLNMMNGJWm8FhpJVVTzsxAfPQU8o4wtlkO8Z/Ozn9oUU9inJJ2E=
X-Gm-Gg: Acq92OFI59UDSjL1wjlzqEZ04boCu7ig8pKdLx01mtbla+mJszLsy9GHEvt7eLJNfJr
	LuBEKJrKGSh1FCUzhyDNQXN5xhLvnycWaYg9qWFFWwWvUnnq0vTotF0wLWvnYlf5Bc8WjsQjN5q
	NyjwTQ/1Q/RY63W7Hn+g3be+/V0qrEW/QzqcF4iNLKENanUWtzSy0v2JB73eZPTstLnlyTO+njO
	ycOXSv69zTokIUmw5og+v73cgisdRdy/z3Um+Et5GXypuF2SUR6glXZ2r1kNZGEYRt8U+K/KDh3
	BPZ1IUdkeXg3TNep2EsEWg2/fEfMGMNM89xCRtKt+U7AWxSqk1DfT0yxhUgo9I/ao3lUB8O/TNU
	NzQfPzOcAYHXApVo4ZOxkwrLlWPCty4yPzf1XYwF9nMmGai611DUhGvFb1WJhCNM/Cg0UYenTHw
	r+9ZLbKx8FyVEAu89z87K63KWqQ1SbJFf3hAS9tkYTrFd4j0a1rwVoyKJI6DR/elEf+mbQ30j08
	Tr+ggoSVAg6eg==
X-Received: by 2002:a05:6000:4601:b0:45f:f142:d55a with SMTP id ffacd0b85a97d-4606da66b28mr2521193f8f.14.1781252524152;
        Fri, 12 Jun 2026 01:22:04 -0700 (PDT)
Received: from localhost (p200300f65f47db040e4e5c1e98e7f0ff.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e4e:5c1e:98e7:f0ff])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f2c4240sm3913146f8f.27.2026.06.12.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:22:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ata: Use named initializers for pci_device_id arrays
Date: Fri, 12 Jun 2026 10:21:48 +0200
Message-ID:  <616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781252167.git.ukleinek@kernel.org>
References: <cover.1781252167.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=106701; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JuMrIf9R7hEP+3RHht++4+esDuQxM0Aeuyy4yk9owSo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqK8GgBLvZYLJI0Zl2thdBG2wxOAcM71kK8sTqx PcGXeu5gRKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaivBoAAKCRCPgPtYfRL+ TuZ1B/93FrSpkqjh1I02MKLJ3I5gQFgwrAPRCPikXIuQOygGqcAXNa5uc/xnomBu4tsRHTxydY6 ockQwDQzpyd7j8Y83Iz+8pdXncycYqZyyxkKX4Cgm3RHXNK9AWYhBGYHEJwmVbgphX9GOlXSEE9 LSpQsX9a4oHmMzWTWqe+RZxI9sHU3cxU2u4J57qLC3D42Lzj0Ch/ezuxtHLCSjDzIoiFqZBEv7Y NSUxdXMhG5iXZ4GSVKHY77mdSbm72dWRn7fuq3fVYpiKdIxaog/auNLqLOdeIXxeFJftzFb5Yg3 CK40zIvjn5j7SUZxOXmjxz7tjQDGuf+I5rJYxo/jRb2Rfgt+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
pci_device_id that replaces .driver_data by an anonymous union.

Also drop the comma after a few list terminators.

This patch doesn't modify the compiled array, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/ata/acard-ahci.c        |    8 +-
 drivers/ata/ahci.c              | 1626 ++++++++++++++++++++++++-------
 drivers/ata/ata_piix.c          |  532 ++++++----
 drivers/ata/pata_acpi.c         |    5 +-
 drivers/ata/pata_amd.c          |   88 +-
 drivers/ata/pata_artop.c        |   11 +-
 drivers/ata/pata_cmd64x.c       |   11 +-
 drivers/ata/pata_opti.c         |    7 +-
 drivers/ata/pata_pdc2027x.c     |   30 +-
 drivers/ata/pata_pdc202xx_old.c |   13 +-
 drivers/ata/pata_serverworks.c  |   24 +-
 drivers/ata/pata_sis.c          |    1 -
 drivers/ata/pata_via.c          |   19 +-
 drivers/ata/pdc_adma.c          |    3 +-
 drivers/ata/sata_mv.c           |   34 +-
 drivers/ata/sata_nv.c           |   58 +-
 drivers/ata/sata_promise.c      |   34 +-
 drivers/ata/sata_qstor.c        |    3 +-
 drivers/ata/sata_sil.c          |   15 +-
 drivers/ata/sata_sil24.c        |   15 +-
 drivers/ata/sata_sis.c          |   32 +-
 drivers/ata/sata_svw.c          |   15 +-
 drivers/ata/sata_sx4.c          |    3 +-
 drivers/ata/sata_uli.c          |    7 +-
 drivers/ata/sata_via.c          |   38 +-
 25 files changed, 1932 insertions(+), 700 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 3999305b5356..402d3304b94b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -91,9 +91,11 @@ static const struct ata_port_info acard_ahci_port_info[] = {
 };
 
 static const struct pci_device_id acard_ahci_pci_tbl[] = {
-	/* ACard */
-	{ PCI_VDEVICE(ARTOP, 0x000d), board_acard_ahci }, /* ATP8620 */
-
+	{
+		/* ACard ATP8620 */
+		PCI_VDEVICE(ARTOP, 0x000d),
+		.driver_data = board_acard_ahci,
+	},
 	{ }    /* terminate list */
 };
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b4e5d347151a..58f512f8952a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -279,384 +279,1312 @@ static const struct ata_port_info ahci_port_info[] = {
 
 static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
-	{ PCI_VDEVICE(INTEL, 0x06d6), board_ahci_pcs_quirk }, /* Comet Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci_pcs_quirk }, /* ICH6 */
-	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci_pcs_quirk }, /* ICH6M */
-	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci_pcs_quirk }, /* ICH7 */
-	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci_pcs_quirk }, /* ICH7M */
-	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci_pcs_quirk }, /* ICH7R */
-	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
-	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci_pcs_quirk }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci_pcs_quirk }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci_pcs_quirk }, /* ESB2 */
-	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci_pcs_quirk }, /* ICH7-M DH */
-	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pcs_quirk }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_pcs_quirk_no_sntf }, /* ICH8/Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pcs_quirk }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pcs_quirk }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pcs_quirk }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pcs_quirk }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pcs_quirk }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci_pcs_quirk }, /* Tolapai */
-	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci_pcs_quirk }, /* Tolapai */
-	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci_pcs_quirk }, /* ICH10 */
-	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci_pcs_quirk }, /* ICH10 */
-	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci_pcs_quirk }, /* ICH10 */
-	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci_pcs_quirk }, /* PCH AHCI */
-	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci_pcs_quirk }, /* PCH AHCI */
-	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci_pcs_quirk }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci_pcs_quirk }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_pcs_quirk }, /* PCH M AHCI */
-	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci_pcs_quirk }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_pcs_quirk }, /* PCH M RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci_pcs_quirk }, /* PCH AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b2), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b3), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b4), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b5), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b6), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19b7), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19bE), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19bF), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c0), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c1), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c2), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c3), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c4), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c5), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c6), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19c7), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci_pcs_quirk }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_pcs_quirk }, /* CPT M AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci_pcs_quirk }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_pcs_quirk }, /* CPT M RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci_pcs_quirk }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci_pcs_quirk }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci_pcs_quirk }, /* PBG AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci_pcs_quirk }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci_pcs_quirk }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci_pcs_quirk }, /* DH89xxCC AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci_pcs_quirk }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_pcs_quirk }, /* Panther M AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci_pcs_quirk }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci_pcs_quirk }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci_pcs_quirk }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_pcs_quirk }, /* Panther M RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci_pcs_quirk }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci_pcs_quirk }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_pcs_quirk }, /* Lynx M AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci_pcs_quirk }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_pcs_quirk }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci_pcs_quirk }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_pcs_quirk }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci_pcs_quirk }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_pcs_quirk }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_pcs_quirk }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_pcs_quirk }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_pcs_quirk }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_pcs_quirk }, /* Cannon Lake PCH-LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci_pcs_quirk }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci_pcs_quirk }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f25), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f26), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f27), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f2e), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f2f), board_ahci_pcs_quirk }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f32), board_ahci_avn }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f33), board_ahci_avn }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f34), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f35), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f36), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci_pcs_quirk }, /* Wellsburg/Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci_pcs_quirk }, /* *burg SATA0 'RAID' */
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci_pcs_quirk }, /* *burg SATA1 'RAID' */
-	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci_pcs_quirk }, /* *burg SATA2 'RAID' */
-	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x43d7), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci_pcs_quirk }, /* Wellsburg AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8d04), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d06), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d0e), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d62), board_ahci_pcs_quirk }, /* Wellsburg AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8d64), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci_pcs_quirk }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci_pcs_quirk }, /* Coleto Creek AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_pcs_quirk }, /* Wildcat LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci_pcs_quirk }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_pcs_quirk }, /* 9 Series M AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci_pcs_quirk }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_pcs_quirk }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci_pcs_quirk }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_pcs_quirk }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci_pcs_quirk }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_pcs_quirk }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_pcs_quirk }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_pcs_quirk }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_pcs_quirk }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci_pcs_quirk }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_pcs_quirk }, /* Sunrise M AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_pcs_quirk }, /* Sunrise M RAID */
-	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci_pcs_quirk }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa1d6), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci_pcs_quirk }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci_pcs_quirk }, /* Cannon Lake PCH-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci_pcs_quirk }, /* Comet Lake-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci_pcs_quirk }, /* Comet Lake PCH-V RAID */
-	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk_no_devslp }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_pcs_quirk }, /* Cherry Tr. AHCI */
-	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_pcs_quirk }, /* ApolloLake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_pcs_quirk }, /* Ice Lake LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_pcs_quirk }, /* Comet Lake PCH-U AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
+	{
+		/* Comet Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0x06d6),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH6 */
+		PCI_VDEVICE(INTEL, 0x2652),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH6M */
+		PCI_VDEVICE(INTEL, 0x2653),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH7 */
+		PCI_VDEVICE(INTEL, 0x27c1),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH7M */
+		PCI_VDEVICE(INTEL, 0x27c5),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH7R */
+		PCI_VDEVICE(INTEL, 0x27c3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ULi M5288 */
+		PCI_VDEVICE(AL, 0x5288),
+		.driver_data = board_ahci_ign_iferr,
+	}, {
+		/* ESB2 */
+		PCI_VDEVICE(INTEL, 0x2681),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ESB2 */
+		PCI_VDEVICE(INTEL, 0x2682),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ESB2 */
+		PCI_VDEVICE(INTEL, 0x2683),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH7-M DH */
+		PCI_VDEVICE(INTEL, 0x27c6),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH8 */
+		PCI_VDEVICE(INTEL, 0x2821),
+			.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH8/Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0x2822),
+			.driver_data = board_ahci_pcs_quirk_no_sntf,
+	}, {
+		/* ICH8 */
+		PCI_VDEVICE(INTEL, 0x2824),
+			.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH8M */
+		PCI_VDEVICE(INTEL, 0x2829),
+			.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH8M */
+		PCI_VDEVICE(INTEL, 0x282a),
+			.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x2922),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x2923),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x2924),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x2925),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x2927),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x2929),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x292a),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x292b),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x292c),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x292f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9 */
+		PCI_VDEVICE(INTEL, 0x294d),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH9M */
+		PCI_VDEVICE(INTEL, 0x294e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Tolapai */
+		PCI_VDEVICE(INTEL, 0x502a),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Tolapai */
+		PCI_VDEVICE(INTEL, 0x502b),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH10 */
+		PCI_VDEVICE(INTEL, 0x3a05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH10 */
+		PCI_VDEVICE(INTEL, 0x3a22),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ICH10 */
+		PCI_VDEVICE(INTEL, 0x3a25),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH AHCI */
+		PCI_VDEVICE(INTEL, 0x3b22),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH AHCI */
+		PCI_VDEVICE(INTEL, 0x3b23),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH RAID */
+		PCI_VDEVICE(INTEL, 0x3b24),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH RAID */
+		PCI_VDEVICE(INTEL, 0x3b25),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH M AHCI */
+		PCI_VDEVICE(INTEL, 0x3b29),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH RAID */
+		PCI_VDEVICE(INTEL, 0x3b2b),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH M RAID */
+		PCI_VDEVICE(INTEL, 0x3b2c),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PCH AHCI */
+		PCI_VDEVICE(INTEL, 0x3b2f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b0),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b1),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b2),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b3),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b4),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b5),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b6),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19b7),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19bE),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19bF),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c0),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c1),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c2),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c3),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c4),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c5),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c6),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19c7),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19cE),
+		.driver_data = board_ahci,
+	}, {
+		/* DNV AHCI */
+		PCI_VDEVICE(INTEL, 0x19cF),
+		.driver_data = board_ahci,
+	}, {
+		/* CPT AHCI */
+		PCI_VDEVICE(INTEL, 0x1c02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* CPT M AHCI */
+		PCI_VDEVICE(INTEL, 0x1c03),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* CPT RAID */
+		PCI_VDEVICE(INTEL, 0x1c04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* CPT M RAID */
+		PCI_VDEVICE(INTEL, 0x1c05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* CPT RAID */
+		PCI_VDEVICE(INTEL, 0x1c06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* CPT RAID */
+		PCI_VDEVICE(INTEL, 0x1c07),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PBG AHCI */
+		PCI_VDEVICE(INTEL, 0x1d02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PBG RAID */
+		PCI_VDEVICE(INTEL, 0x1d04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* PBG RAID */
+		PCI_VDEVICE(INTEL, 0x1d06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* DH89xxCC AHCI */
+		PCI_VDEVICE(INTEL, 0x2323),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther Point AHCI */
+		PCI_VDEVICE(INTEL, 0x1e02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther M AHCI */
+		PCI_VDEVICE(INTEL, 0x1e03),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther Point RAID */
+		PCI_VDEVICE(INTEL, 0x1e04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther Point RAID */
+		PCI_VDEVICE(INTEL, 0x1e05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther Point RAID */
+		PCI_VDEVICE(INTEL, 0x1e06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther M RAID */
+		PCI_VDEVICE(INTEL, 0x1e07),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Panther Point RAID */
+		PCI_VDEVICE(INTEL, 0x1e0e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx Point AHCI */
+		PCI_VDEVICE(INTEL, 0x8c02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx M AHCI */
+		PCI_VDEVICE(INTEL, 0x8c03),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx Point RAID */
+		PCI_VDEVICE(INTEL, 0x8c04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx M RAID */
+		PCI_VDEVICE(INTEL, 0x8c05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx Point RAID */
+		PCI_VDEVICE(INTEL, 0x8c06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx M RAID */
+		PCI_VDEVICE(INTEL, 0x8c07),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx Point RAID */
+		PCI_VDEVICE(INTEL, 0x8c0e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx M RAID */
+		PCI_VDEVICE(INTEL, 0x8c0f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP AHCI */
+		PCI_VDEVICE(INTEL, 0x9c02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP AHCI */
+		PCI_VDEVICE(INTEL, 0x9c03),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c07),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c0e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lynx LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c0f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Cannon Lake PCH-LP AHCI */
+		PCI_VDEVICE(INTEL, 0x9dd3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton AHCI */
+		PCI_VDEVICE(INTEL, 0x1f22),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton AHCI */
+		PCI_VDEVICE(INTEL, 0x1f23),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f24),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f25),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f26),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f27),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f2e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f2f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Avoton AHCI */
+		PCI_VDEVICE(INTEL, 0x1f32),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton AHCI */
+		PCI_VDEVICE(INTEL, 0x1f33),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f34),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f35),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f36),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f37),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f3e),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Avoton RAID */
+		PCI_VDEVICE(INTEL, 0x1f3f),
+		.driver_data = board_ahci_avn,
+	}, {
+		/* Wellsburg/Lewisburg AHCI*/
+		PCI_VDEVICE(INTEL, 0x2823),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* *burg SATA0 'RAID' */
+		PCI_VDEVICE(INTEL, 0x2826),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* *burg SATA1 'RAID' */
+		PCI_VDEVICE(INTEL, 0x2827),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* *burg SATA2 'RAID' */
+		PCI_VDEVICE(INTEL, 0x282f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Rocket Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0x43d4),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Rocket Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0x43d5),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Rocket Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0x43d6),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Rocket Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0x43d7),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg AHCI */
+		PCI_VDEVICE(INTEL, 0x8d02),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d04),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d06),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d0e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg AHCI */
+		PCI_VDEVICE(INTEL, 0x8d62),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d64),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d66),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wellsburg RAID */
+		PCI_VDEVICE(INTEL, 0x8d6e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Coleto Creek AHCI */
+		PCI_VDEVICE(INTEL, 0x23a3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wildcat LP AHCI */
+		PCI_VDEVICE(INTEL, 0x9c83),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wildcat LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c85),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wildcat LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c87),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Wildcat LP RAID */
+		PCI_VDEVICE(INTEL, 0x9c8f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series AHCI */
+		PCI_VDEVICE(INTEL, 0x8c82),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series M AHCI */
+		PCI_VDEVICE(INTEL, 0x8c83),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series RAID */
+		PCI_VDEVICE(INTEL, 0x8c84),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series M RAID */
+		PCI_VDEVICE(INTEL, 0x8c85),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series RAID */
+		PCI_VDEVICE(INTEL, 0x8c86),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series M RAID */
+		PCI_VDEVICE(INTEL, 0x8c87),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series RAID */
+		PCI_VDEVICE(INTEL, 0x8c8e),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* 9 Series M RAID */
+		PCI_VDEVICE(INTEL, 0x8c8f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise LP AHCI */
+		PCI_VDEVICE(INTEL, 0x9d03),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise LP RAID */
+		PCI_VDEVICE(INTEL, 0x9d05),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise LP RAID */
+		PCI_VDEVICE(INTEL, 0x9d07),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise Point-H AHCI */
+		PCI_VDEVICE(INTEL, 0xa102),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise M AHCI */
+		PCI_VDEVICE(INTEL, 0xa103),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise Point-H RAID */
+		PCI_VDEVICE(INTEL, 0xa105),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise Point-H RAID */
+		PCI_VDEVICE(INTEL, 0xa106),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise M RAID */
+		PCI_VDEVICE(INTEL, 0xa107),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Sunrise Point-H RAID */
+		PCI_VDEVICE(INTEL, 0xa10f),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg AHCI*/
+		PCI_VDEVICE(INTEL, 0xa182),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa186),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa1d2),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa1d6),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg AHCI*/
+		PCI_VDEVICE(INTEL, 0xa202),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa206),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa252),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Lewisburg RAID*/
+		PCI_VDEVICE(INTEL, 0xa256),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Cannon Lake PCH-H RAID */
+		PCI_VDEVICE(INTEL, 0xa356),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Comet Lake-H RAID */
+		PCI_VDEVICE(INTEL, 0x06d7),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Comet Lake PCH-V RAID */
+		PCI_VDEVICE(INTEL, 0xa386),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Bay Trail AHCI */
+		PCI_VDEVICE(INTEL, 0x0f22),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Bay Trail AHCI */
+		PCI_VDEVICE(INTEL, 0x0f23),
+		.driver_data = board_ahci_pcs_quirk_no_devslp,
+	}, {
+		/* Cherry Tr. AHCI */
+		PCI_VDEVICE(INTEL, 0x22a3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* ApolloLake AHCI */
+		PCI_VDEVICE(INTEL, 0x5ae3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Ice Lake LP AHCI */
+		PCI_VDEVICE(INTEL, 0x34d3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Comet Lake PCH-U AHCI */
+		PCI_VDEVICE(INTEL, 0x02d3),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Comet Lake PCH RAID */
+		PCI_VDEVICE(INTEL, 0x02d7),
+		.driver_data = board_ahci_pcs_quirk,
+	},
+
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
-	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
+	{
+		/* Elkhart Lake AHCI */
+		PCI_VDEVICE(INTEL, 0x4b63),
+		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
+		PCI_VDEVICE(JMICRON, 0x0582),
+		.driver_data = board_ahci_jmb585,
 
-	/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
-	{ PCI_VDEVICE(JMICRON, 0x0582), board_ahci_jmb585 },
-	{ PCI_VDEVICE(JMICRON, 0x0585), board_ahci_jmb585 },
+	}, {
+		PCI_VDEVICE(JMICRON, 0x0585),
+		.driver_data = board_ahci_jmb585,
+	}, {
+		/* JMicron 360/1/3/5/6, match class to avoid IDE function */
+		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
+		.class = PCI_CLASS_STORAGE_SATA_AHCI,
+		.class_mask = 0xffffff,
+		.driver_data = board_ahci_ign_iferr,
 
-	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
-	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
+	},
 	/* JMicron 362B and 362C have an AHCI function with IDE class code */
-	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
-	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },
+	{
+		PCI_VDEVICE(JMICRON, 0x2362),
+		.driver_data = board_ahci_ign_iferr,
+
+	}, {
+		PCI_VDEVICE(JMICRON, 0x236f),
+		.driver_data = board_ahci_ign_iferr,
+
+	},
 	/* May need to update quirk_jmicron_async_suspend() for additions */
 
 	/* ATI */
-	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb700 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb700 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb700 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800 */
-	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */
+	{
+		/* ATI SB600 */
+		PCI_VDEVICE(ATI, 0x4380),
+		.driver_data = board_ahci_sb600,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4390),
+		.driver_data = board_ahci_sb700,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4391),
+		.driver_data = board_ahci_sb700,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4392),
+		.driver_data = board_ahci_sb700,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4393),
+		.driver_data = board_ahci_sb700,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4394),
+		.driver_data = board_ahci_sb700,
+	}, {
+		/* ATI SB700/800 */
+		PCI_VDEVICE(ATI, 0x4395),
+		.driver_data = board_ahci_sb700,
+	},
 
 	/* Amazon's Annapurna Labs support */
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031),
-		.class = PCI_CLASS_STORAGE_SATA_AHCI,
-		.class_mask = 0xffffff,
-		board_ahci_al },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031),
+			.class = PCI_CLASS_STORAGE_SATA_AHCI,
+			.class_mask = 0xffffff,
+		.driver_data = board_ahci_al,
+
+	},
 	/* AMD */
-	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
-	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
-	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
+	{
+		/* AMD Hudson-2 */
+		PCI_VDEVICE(AMD, 0x7800),
+		.driver_data = board_ahci,
+	}, {
+		/* AMD Hudson-2 (AHCI mode) */
+		PCI_VDEVICE(AMD, 0x7801),
+		.driver_data = board_ahci_no_debounce_delay,
+	}, {
+		/* AMD CZ */
+		PCI_VDEVICE(AMD, 0x7900),
+		.driver_data = board_ahci,
+	}, {
+		/* AMD Green Sardine */
+		PCI_VDEVICE(AMD, 0x7901),
+		.driver_data = board_ahci,
+	},
 	/* AMD is using RAID class only for ahci controllers */
-	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
+		.class = PCI_CLASS_STORAGE_RAID << 8,
+		.class_mask = 0xffffff,
+		.driver_data = board_ahci,
+	},
 
 	/* Dell S140/S150 */
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci_pcs_quirk },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			       PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID),
+		.class = PCI_CLASS_STORAGE_RAID << 8,
+		.class_mask = 0xffffff,
+		.driver_data = board_ahci_pcs_quirk,
+
+	},
 
 	/* VIA */
-	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
-	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
+	{
+		/* VIA VT8251 */
+		PCI_VDEVICE(VIA, 0x3349),
+		.driver_data = board_ahci_vt8251,
+	}, {
+		/* VIA VT8251 */
+		PCI_VDEVICE(VIA, 0x6287),
+		.driver_data = board_ahci_vt8251,
+	},
 
 	/* NVIDIA */
-	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_mcp67 },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0581), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0582), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0583), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0584), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0585), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0586), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0587), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0588), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0589), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058a), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058b), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058c), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058d), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058e), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058f), board_ahci_mcp_linux },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci_mcp73 },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad3), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad4), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad5), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad6), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad7), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad8), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci_mcp77 },	/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci_mcp79 },	/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d84), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d85), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d86), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d87), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d88), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d89), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8a), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8b), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8c), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8d), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8e), board_ahci_mcp89 },	/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8f), board_ahci_mcp89 },	/* MCP89 */
+	{
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x044c),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x044d),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x044e),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x044f),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x045c),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x045d),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x045e),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP65 */
+		PCI_VDEVICE(NVIDIA, 0x045f),
+		.driver_data = board_ahci_mcp65,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0550),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0551),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0552),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0553),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0554),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0555),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0556),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0557),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0558),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x0559),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x055a),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* MCP67 */
+		PCI_VDEVICE(NVIDIA, 0x055b),
+		.driver_data = board_ahci_mcp67,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0580),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0581),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0582),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0583),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0584),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0585),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0586),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0587),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0588),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x0589),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058a),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058b),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058c),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058d),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058e),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* Linux ID */
+		PCI_VDEVICE(NVIDIA, 0x058f),
+		.driver_data = board_ahci_mcp_linux,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f0),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f1),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f2),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f3),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f4),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f5),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f6),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f7),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f8),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07f9),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07fa),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP73 */
+		PCI_VDEVICE(NVIDIA, 0x07fb),
+		.driver_data = board_ahci_mcp73,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad0),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad1),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad2),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad3),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad4),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad5),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad6),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad7),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad8),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ad9),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0ada),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP77 */
+		PCI_VDEVICE(NVIDIA, 0x0adb),
+		.driver_data = board_ahci_mcp77,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab4),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab5),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab6),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab7),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab8),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0ab9),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0aba),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0abb),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0abc),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0abd),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0abe),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP79 */
+		PCI_VDEVICE(NVIDIA, 0x0abf),
+		.driver_data = board_ahci_mcp79,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d84),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d85),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d86),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d87),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d88),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d89),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8a),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8b),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8c),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8d),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8e),
+		.driver_data = board_ahci_mcp89,
+	}, {
+		/* MCP89 */
+		PCI_VDEVICE(NVIDIA, 0x0d8f),
+		.driver_data = board_ahci_mcp89,
+	},
 
 	/* SiS */
-	{ PCI_VDEVICE(SI, 0x1184), board_ahci },		/* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x1185), board_ahci },		/* SiS 968 */
-	{ PCI_VDEVICE(SI, 0x0186), board_ahci },		/* SiS 968 */
+	{
+		/* SiS 966 */
+		PCI_VDEVICE(SI, 0x1184),
+		.driver_data = board_ahci,
+	}, {
+		/* SiS 968 */
+		PCI_VDEVICE(SI, 0x1185),
+		.driver_data = board_ahci,
+	}, {
+		/* SiS 968 */
+		PCI_VDEVICE(SI, 0x0186),
+		.driver_data = board_ahci,
+	},
 
 	/* ST Microelectronics */
-	{ PCI_VDEVICE(STMICRO, 0xCC06), board_ahci },		/* ST ConneXt */
+	{
+		/* ST ConneXt */
+		PCI_VDEVICE(STMICRO, 0xCC06),
+		.driver_data = board_ahci,
+	},
 
 	/* Marvell */
-	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
-	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9123),
-	  .class = PCI_CLASS_STORAGE_SATA_AHCI,
-	  .class_mask = 0xffffff,
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9125),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9125 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MARVELL_EXT, 0x9178,
-			 PCI_VENDOR_ID_MARVELL_EXT, 0x9170),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9170 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x917a),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9172),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9182 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9182),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9192),
-	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 on some Gigabyte */
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0),
-	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a2), 	/* 88se91a2 */
-	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
-	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
-	  .driver_data = board_ahci_yes_fbs_atapi_dma },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
-	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
-	  .driver_data = board_ahci_no_debounce_delay },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
-	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
-	  .driver_data = board_ahci_yes_fbs },
+	{
+		/* 6145 */
+		PCI_VDEVICE(MARVELL, 0x6145),
+		.driver_data = board_ahci_mv,
+	}, {
+		/* 6121 */
+		PCI_VDEVICE(MARVELL, 0x6121),
+		.driver_data = board_ahci_mv,
+	}, {
+		/* 88se9128 */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9123),
+			.class = PCI_CLASS_STORAGE_SATA_AHCI,
+			.class_mask = 0xffffff,
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9125 */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9125),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9170 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MARVELL_EXT, 0x9178,
+			       PCI_VENDOR_ID_MARVELL_EXT, 0x9170),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9172 */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x917a),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9182 */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9172),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9172 */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9182),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* 88se9172 on some Gigabyte */
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9192),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a2), 	/* 88se91a2 */
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+		.driver_data = board_ahci_yes_fbs_atapi_dma,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
+		.driver_data = board_ahci_no_debounce_delay,
+	},
+
+	/* TTI */
+	{
+		/* highpoint rocketraid 642L */
+		PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+		.driver_data = board_ahci_yes_fbs,
+	}, {
+		/* highpoint rocketraid 644L */
+		PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645),
+		.driver_data = board_ahci_yes_fbs,
+	},
 
 	/* Promise */
-	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
-	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
+	{
+		/* PDC42819 */
+		PCI_VDEVICE(PROMISE, 0x3f20),
+		.driver_data = board_ahci,
+	}, {
+		/* FastTrak TX8660 ahci-mode */
+		PCI_VDEVICE(PROMISE, 0x3781),
+		.driver_data = board_ahci,
+	},
 
 	/* ASMedia */
-	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
-	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
-	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
-	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
-	{ PCI_VDEVICE(ASMEDIA, 0x1165), board_ahci },   /* ASM1165 */
-	{ PCI_VDEVICE(ASMEDIA, 0x1166), board_ahci },   /* ASM1166 */
+	{
+		/* ASM1060 */
+		PCI_VDEVICE(ASMEDIA, 0x0601),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1060 */
+		PCI_VDEVICE(ASMEDIA, 0x0602),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1061 */
+		PCI_VDEVICE(ASMEDIA, 0x0611),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1061/1062 */
+		PCI_VDEVICE(ASMEDIA, 0x0612),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1061R */
+		PCI_VDEVICE(ASMEDIA, 0x0621),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1062R */
+		PCI_VDEVICE(ASMEDIA, 0x0622),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1062+JMB575 */
+		PCI_VDEVICE(ASMEDIA, 0x0624),
+		.driver_data = board_ahci_43bit_dma,
+	}, {
+		/* ASM1062A */
+		PCI_VDEVICE(ASMEDIA, 0x1062),
+		.driver_data = board_ahci,
+	}, {
+		/* ASM1064 */
+		PCI_VDEVICE(ASMEDIA, 0x1064),
+		.driver_data = board_ahci,
+	}, {
+		/* ASM1164 */
+		PCI_VDEVICE(ASMEDIA, 0x1164),
+		.driver_data = board_ahci,
+	}, {
+		/* ASM1165 */
+		PCI_VDEVICE(ASMEDIA, 0x1165),
+		.driver_data = board_ahci,
+	}, {
+		/* ASM1166 */
+		PCI_VDEVICE(ASMEDIA, 0x1166),
+		.driver_data = board_ahci,
+	}, {
+		/*
+		 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
+		 * enabled.  https://bugzilla.kernel.org/show_bug.cgi?id=60731
+		 */
+		PCI_VDEVICE(SAMSUNG, 0x1600),
+		.driver_data = board_ahci_no_msi,
 
-	/*
-	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-	 * enabled.  https://bugzilla.kernel.org/show_bug.cgi?id=60731
-	 */
-	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_no_msi },
-	{ PCI_VDEVICE(SAMSUNG, 0xa800), board_ahci_no_msi },
+	}, {
+		PCI_VDEVICE(SAMSUNG, 0xa800),
+		.driver_data = board_ahci_no_msi,
+	}, {
+		/* Enmotus */
+		PCI_DEVICE(0x1c44, 0x8000),
+		.driver_data = board_ahci,
+	}, {
+		/* Loongson */
+		PCI_VDEVICE(LOONGSON, 0x7a08),
+		.driver_data = board_ahci,
 
-	/* Enmotus */
-	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
-
-	/* Loongson */
-	{ PCI_VDEVICE(LOONGSON, 0x7a08), board_ahci },
-
-	/* Generic, PCI class code for AHCI */
-	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
+	}, {
+		/* Generic, PCI class code for AHCI */
+		PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff),
+		.driver_data = board_ahci,
+	},
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 495fa096dd65..e3aa5c86fb48 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -154,184 +154,364 @@ static unsigned int in_module_init = 1;
 
 static const struct pci_device_id piix_pci_tbl[] = {
 	/* Intel PIIX3 for the 430HX etc */
-	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
-	/* VMware ICH4 */
-	{ 0x8086, 0x7111, 0x15ad, 0x1976, 0, 0, piix_pata_vmw },
-	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
-	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
-	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
-	/* Intel PIIX4 */
-	{ 0x8086, 0x7199, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
-	/* Intel PIIX4 */
-	{ 0x8086, 0x7601, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
-	/* Intel PIIX */
-	{ 0x8086, 0x84CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
-	/* Intel ICH (i810, i815, i840) UDMA 66*/
-	{ 0x8086, 0x2411, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_66 },
-	/* Intel ICH0 : UDMA 33*/
-	{ 0x8086, 0x2421, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_33 },
-	/* Intel ICH2M */
-	{ 0x8086, 0x244A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH2 (i810E2, i845, 850, 860) UDMA 100 */
-	{ 0x8086, 0x244B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/*  Intel ICH3M */
-	{ 0x8086, 0x248A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH3 (E7500/1) UDMA 100 */
-	{ 0x8086, 0x248B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH4-L */
-	{ 0x8086, 0x24C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH4 (i845GV, i845E, i852, i855) UDMA 100 */
-	{ 0x8086, 0x24CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	{ 0x8086, 0x24CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH5 */
-	{ 0x8086, 0x24DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* C-ICH (i810E2) */
-	{ 0x8086, 0x245B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* ESB (855GME/875P + 6300ESB) UDMA 100  */
-	{ 0x8086, 0x25A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* ICH6 (and 6) (i915) UDMA 100 */
-	{ 0x8086, 0x266F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* ICH7/7-R (i945, i975) UDMA 100*/
-	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100_nomwdma1 },
-	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100_nomwdma1 },
-	/* ICH8 Mobile PATA Controller */
-	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	{
+		PCI_DEVICE(0x8086, 0x7010),
+		.driver_data = piix_pata_mwdma,
+	}, {
+		/* VMware ICH4 */
+		PCI_DEVICE_SUB(0x8086, 0x7111, 0x15ad, 0x1976),
+		.driver_data = piix_pata_vmw,
+	}, {
+		/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
+		/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
+		PCI_DEVICE(0x8086, 0x7111),
+		.driver_data = piix_pata_33,
+	}, {
+		/* Intel PIIX4 */
+		PCI_DEVICE(0x8086, 0x7199),
+		.driver_data = piix_pata_33,
+	}, {
+		/* Intel PIIX4 */
+		PCI_DEVICE(0x8086, 0x7601),
+		.driver_data = piix_pata_33,
+	}, {
+		/* Intel PIIX */
+		PCI_DEVICE(0x8086, 0x84CA),
+		.driver_data = piix_pata_33,
+	}, {
+		/* Intel ICH (i810, i815, i840) UDMA 66*/
+		PCI_DEVICE(0x8086, 0x2411),
+		.driver_data = ich_pata_66,
+	}, {
+		/* Intel ICH0 : UDMA 33*/
+		PCI_DEVICE(0x8086, 0x2421),
+		.driver_data = ich_pata_33,
+	}, {
+		/* Intel ICH2M */
+		PCI_DEVICE(0x8086, 0x244A),
+		.driver_data = ich_pata_100,
+	}, {
+		/* Intel ICH2 (i810E2, i845, 850, 860) UDMA 100 */
+		PCI_DEVICE(0x8086, 0x244B),
+		.driver_data = ich_pata_100,
+	}, {
+		/*  Intel ICH3M */
+		PCI_DEVICE(0x8086, 0x248A),
+		.driver_data = ich_pata_100,
+	}, {
+		/* Intel ICH3 (E7500/1) UDMA 100 */
+		PCI_DEVICE(0x8086, 0x248B),
+		.driver_data = ich_pata_100,
+	}, {
+		/* Intel ICH4-L */
+		PCI_DEVICE(0x8086, 0x24C1),
+		.driver_data = ich_pata_100,
+	}, {
+		/* Intel ICH4 (i845GV, i845E, i852, i855) UDMA 100 */
+		PCI_DEVICE(0x8086, 0x24CA),
+		.driver_data = ich_pata_100,
+	}, {
+		PCI_DEVICE(0x8086, 0x24CB),
+		.driver_data = ich_pata_100,
+	}, {
+		/* Intel ICH5 */
+		PCI_DEVICE(0x8086, 0x24DB),
+		.driver_data = ich_pata_100,
+	}, {
+		/* C-ICH (i810E2) */
+		PCI_DEVICE(0x8086, 0x245B),
+		.driver_data = ich_pata_100,
+	}, {
+		/* ESB (855GME/875P + 6300ESB) UDMA 100  */
+		PCI_DEVICE(0x8086, 0x25A2),
+		.driver_data = ich_pata_100,
+	}, {
+		/* ICH6 (and 6) (i915) UDMA 100 */
+		PCI_DEVICE(0x8086, 0x266F),
+		.driver_data = ich_pata_100,
+	}, {
+		/* ICH7/7-R (i945, i975) UDMA 100*/
+		PCI_DEVICE(0x8086, 0x27DF),
+		.driver_data = ich_pata_100_nomwdma1,
+	}, {
+		PCI_DEVICE(0x8086, 0x269E),
+		.driver_data = ich_pata_100_nomwdma1,
+	}, {
+		/* ICH8 Mobile PATA Controller */
+		PCI_DEVICE(0x8086, 0x2850),
+		.driver_data = ich_pata_100,
+	},
 
 	/* SATA ports */
-
-	/* 82801EB (ICH5) */
-	{ 0x8086, 0x24d1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	/* 82801EB (ICH5) */
-	{ 0x8086, 0x24df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	/* 6300ESB (ICH5 variant with broken PCS present bits) */
-	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	/* 6300ESB pretending RAID */
-	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
-	/* 82801FB/FW (ICH6/ICH6W) */
-	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	/* 82801FR/FRW (ICH6R/ICH6RW) */
-	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	/* 82801FBM ICH6M (ICH6R with only port 0 and 2 implemented).
-	 * Attach iff the controller is in IDE mode. */
-	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich6m_sata },
-	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
-	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	/* 82801GBM/GHM (ICH7M, identical to ICH6M)  */
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata },
-	/* Enterprise Southbridge 2 (631xESB/632xESB) */
-	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	/* SATA Controller 1 IDE (ICH8) */
-	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller 2 IDE (ICH8) */
-	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* Mobile SATA Controller IDE (ICH8M), Apple */
-	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
-	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
-	{ 0x8086, 0x2828, 0x106b, 0x00a3, 0, 0, ich8m_apple_sata },
-	/* Mobile SATA Controller IDE (ICH8M) */
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (ICH9) */
-	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (ICH9) */
-	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (ICH9) */
-	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (ICH9M) */
-	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (ICH9M) */
-	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (ICH9M) */
-	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (Tolapai) */
-	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata },
-	/* SATA Controller IDE (ICH10) */
-	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (ICH10) */
-	{ 0x8086, 0x3a06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (ICH10) */
-	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (ICH10) */
-	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b28, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (PCH) */
-	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
-	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (PBG) */
-	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (PBG) */
-	{ 0x8086, 0x1d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Lynx Point) */
-	{ 0x8086, 0x8c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Lynx Point) */
-	{ 0x8086, 0x8c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Lynx Point) */
-	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
-	/* SATA Controller IDE (Lynx Point) */
-	{ 0x8086, 0x8c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Lynx Point-LP) */
-	{ 0x8086, 0x9c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Lynx Point-LP) */
-	{ 0x8086, 0x9c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Lynx Point-LP) */
-	{ 0x8086, 0x9c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Lynx Point-LP) */
-	{ 0x8086, 0x9c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (DH89xxCC) */
-	{ 0x8086, 0x2326, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Avoton) */
-	{ 0x8086, 0x1f20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Avoton) */
-	{ 0x8086, 0x1f21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Avoton) */
-	{ 0x8086, 0x1f30, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Avoton) */
-	{ 0x8086, 0x1f31, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (Wellsburg) */
-	{ 0x8086, 0x8d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Wellsburg) */
-	{ 0x8086, 0x8d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
-	/* SATA Controller IDE (Wellsburg) */
-	{ 0x8086, 0x8d60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (Wellsburg) */
-	{ 0x8086, 0x8d68, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (BayTrail) */
-	{ 0x8086, 0x0F20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_byt },
-	{ 0x8086, 0x0F21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_byt },
-	/* SATA Controller IDE (Coleto Creek) */
-	{ 0x8086, 0x23a6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* SATA Controller IDE (9 Series) */
-	{ 0x8086, 0x8c88, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
-	/* SATA Controller IDE (9 Series) */
-	{ 0x8086, 0x8c89, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
-	/* SATA Controller IDE (9 Series) */
-	{ 0x8086, 0x8c80, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
-	/* SATA Controller IDE (9 Series) */
-	{ 0x8086, 0x8c81, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	{
+		/* 82801EB (ICH5) */
+		PCI_DEVICE(0x8086, 0x24d1),
+		.driver_data = ich5_sata,
+	}, {
+		/* 82801EB (ICH5) */
+		PCI_DEVICE(0x8086, 0x24df),
+		.driver_data = ich5_sata,
+	}, {
+		/* 6300ESB (ICH5 variant with broken PCS present bits) */
+		PCI_DEVICE(0x8086, 0x25a3),
+		.driver_data = ich5_sata,
+	}, {
+		/* 6300ESB pretending RAID */
+		PCI_DEVICE(0x8086, 0x25b0),
+		.driver_data = ich5_sata,
+	}, {
+		/* 82801FB/FW (ICH6/ICH6W) */
+		PCI_DEVICE(0x8086, 0x2651),
+		.driver_data = ich6_sata,
+	}, {
+		/* 82801FR/FRW (ICH6R/ICH6RW) */
+		PCI_DEVICE(0x8086, 0x2652),
+		.driver_data = ich6_sata,
+	}, {
+		/* 82801FBM ICH6M (ICH6R with only port 0 and 2 implemented).
+		 * Attach iff the controller is in IDE mode. */
+		PCI_DEVICE(0x8086, 0x2653),
+		.class = PCI_CLASS_STORAGE_IDE << 8,
+		.class_mask = 0xffff00,
+		.driver_data = ich6m_sata,
+	}, {
+		/* 82801GB/GR/GH (ICH7, identical to ICH6) */
+		PCI_DEVICE(0x8086, 0x27c0),
+		.driver_data = ich6_sata,
+	}, {
+		/* 82801GBM/GHM (ICH7M, identical to ICH6M)  */
+		PCI_DEVICE(0x8086, 0x27c4),
+		.driver_data = ich6m_sata,
+	}, {
+		/* Enterprise Southbridge 2 (631xESB/632xESB) */
+		PCI_DEVICE(0x8086, 0x2680),
+		.driver_data = ich6_sata,
+	}, {
+		/* SATA Controller 1 IDE (ICH8) */
+		PCI_DEVICE(0x8086, 0x2820),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller 2 IDE (ICH8) */
+		PCI_DEVICE(0x8086, 0x2825),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* Mobile SATA Controller IDE (ICH8M), Apple */
+		PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a0),
+		.driver_data = ich8m_apple_sata,
+	}, {
+		PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a1),
+		.driver_data = ich8m_apple_sata,
+	}, {
+		PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a3),
+		.driver_data = ich8m_apple_sata,
+	}, {
+		/* Mobile SATA Controller IDE (ICH8M) */
+		PCI_DEVICE(0x8086, 0x2828),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (ICH9) */
+		PCI_DEVICE(0x8086, 0x2920),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (ICH9) */
+		PCI_DEVICE(0x8086, 0x2921),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (ICH9) */
+		PCI_DEVICE(0x8086, 0x2926),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (ICH9M) */
+		PCI_DEVICE(0x8086, 0x2928),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (ICH9M) */
+		PCI_DEVICE(0x8086, 0x292d),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (ICH9M) */
+		PCI_DEVICE(0x8086, 0x292e),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (Tolapai) */
+		PCI_DEVICE(0x8086, 0x5028),
+		.driver_data = tolapai_sata,
+	}, {
+		/* SATA Controller IDE (ICH10) */
+		PCI_DEVICE(0x8086, 0x3a00),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (ICH10) */
+		PCI_DEVICE(0x8086, 0x3a06),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (ICH10) */
+		PCI_DEVICE(0x8086, 0x3a20),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (ICH10) */
+		PCI_DEVICE(0x8086, 0x3a26),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b20),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b21),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b26),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b28),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b2d),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (PCH) */
+		PCI_DEVICE(0x8086, 0x3b2e),
+		.driver_data = ich8_sata,
+	}, {
+		/* SATA Controller IDE (CPT) */
+		PCI_DEVICE(0x8086, 0x1c00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (CPT) */
+		PCI_DEVICE(0x8086, 0x1c01),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (CPT) */
+		PCI_DEVICE(0x8086, 0x1c08),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (CPT) */
+		PCI_DEVICE(0x8086, 0x1c09),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (PBG) */
+		PCI_DEVICE(0x8086, 0x1d00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (PBG) */
+		PCI_DEVICE(0x8086, 0x1d08),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Panther Point) */
+		PCI_DEVICE(0x8086, 0x1e00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Panther Point) */
+		PCI_DEVICE(0x8086, 0x1e01),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Panther Point) */
+		PCI_DEVICE(0x8086, 0x1e08),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Panther Point) */
+		PCI_DEVICE(0x8086, 0x1e09),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Lynx Point) */
+		PCI_DEVICE(0x8086, 0x8c00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Lynx Point) */
+		PCI_DEVICE(0x8086, 0x8c01),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Lynx Point) */
+		PCI_DEVICE(0x8086, 0x8c08),
+		.driver_data = ich8_2port_sata_snb,
+	}, {
+		/* SATA Controller IDE (Lynx Point) */
+		PCI_DEVICE(0x8086, 0x8c09),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Lynx Point-LP) */
+		PCI_DEVICE(0x8086, 0x9c00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Lynx Point-LP) */
+		PCI_DEVICE(0x8086, 0x9c01),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Lynx Point-LP) */
+		PCI_DEVICE(0x8086, 0x9c08),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Lynx Point-LP) */
+		PCI_DEVICE(0x8086, 0x9c09),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (DH89xxCC) */
+		PCI_DEVICE(0x8086, 0x2326),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Avoton) */
+		PCI_DEVICE(0x8086, 0x1f20),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Avoton) */
+		PCI_DEVICE(0x8086, 0x1f21),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Avoton) */
+		PCI_DEVICE(0x8086, 0x1f30),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Avoton) */
+		PCI_DEVICE(0x8086, 0x1f31),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (Wellsburg) */
+		PCI_DEVICE(0x8086, 0x8d00),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Wellsburg) */
+		PCI_DEVICE(0x8086, 0x8d08),
+		.driver_data = ich8_2port_sata_snb,
+	}, {
+		/* SATA Controller IDE (Wellsburg) */
+		PCI_DEVICE(0x8086, 0x8d60),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (Wellsburg) */
+		PCI_DEVICE(0x8086, 0x8d68),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (BayTrail) */
+		PCI_DEVICE(0x8086, 0x0F20),
+		.driver_data = ich8_2port_sata_byt,
+	}, {
+		PCI_DEVICE(0x8086, 0x0F21),
+		.driver_data = ich8_2port_sata_byt,
+	}, {
+		/* SATA Controller IDE (Coleto Creek) */
+		PCI_DEVICE(0x8086, 0x23a6),
+		.driver_data = ich8_2port_sata,
+	}, {
+		/* SATA Controller IDE (9 Series) */
+		PCI_DEVICE(0x8086, 0x8c88),
+		.driver_data = ich8_2port_sata_snb,
+	}, {
+		/* SATA Controller IDE (9 Series) */
+		PCI_DEVICE(0x8086, 0x8c89),
+		.driver_data = ich8_2port_sata_snb,
+	}, {
+		/* SATA Controller IDE (9 Series) */
+		PCI_DEVICE(0x8086, 0x8c80),
+		.driver_data = ich8_sata_snb,
+	}, {
+		/* SATA Controller IDE (9 Series) */
+		PCI_DEVICE(0x8086, 0x8c81),
+		.driver_data = ich8_sata_snb,
+	},
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 23fff10af2ac..a4f0f81844a1 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -257,7 +257,10 @@ static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id pacpi_pci_tbl[] = {
-	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 1},
+	{
+		PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL),
+		.driver_data = 1, /* is this used at all? */
+	},
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index a2fecadc927d..2732cb37f268 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -597,29 +597,71 @@ static int amd_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id amd[] = {
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		1 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),		3 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),		4 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),		5 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),	7 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
-	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE),	9 },
-
-	{ },
+	{
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),
+		.driver_data = 1,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),
+		.driver_data = 3,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),
+		.driver_data = 4,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),
+		.driver_data = 5,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),
+		.driver_data = 7,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),
+		.driver_data = 8,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),
+		.driver_data = 9,
+	}, {
+		PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE),
+		.driver_data = 9
+	},
+	{ }
 };
 
 static struct pci_driver amd_pci_driver = {
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6160414172a3..9f8d41639a62 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -421,12 +421,11 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
-	{ PCI_VDEVICE(ARTOP, 0x0005), 0 },
-	{ PCI_VDEVICE(ARTOP, 0x0006), 1 },
-	{ PCI_VDEVICE(ARTOP, 0x0007), 1 },
-	{ PCI_VDEVICE(ARTOP, 0x0008), 2 },
-	{ PCI_VDEVICE(ARTOP, 0x0009), 2 },
-
+	{ PCI_VDEVICE(ARTOP, 0x0005), .driver_data = 0 },
+	{ PCI_VDEVICE(ARTOP, 0x0006), .driver_data = 1 },
+	{ PCI_VDEVICE(ARTOP, 0x0007), .driver_data = 1 },
+	{ PCI_VDEVICE(ARTOP, 0x0008), .driver_data = 2 },
+	{ PCI_VDEVICE(ARTOP, 0x0009), .driver_data = 2 },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index fafea2b79145..e6c8783ce00e 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -506,12 +506,11 @@ static int cmd64x_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id cmd64x[] = {
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 5 },
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 6 },
-
-	{ },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), .driver_data = 0 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), .driver_data = 1 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), .driver_data = 5 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), .driver_data = 6 },
+	{ }
 };
 
 static struct pci_driver cmd64x_pci_driver = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 3db1b95d1404..dd67bbdf6ecf 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -174,10 +174,9 @@ static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id opti[] = {
-	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), 0 },
-	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 1 },
-
-	{ },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), .driver_data = 0 },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), .driver_data = 1 },
+	{ }
 };
 
 static struct pci_driver opti_pci_driver = {
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index ae914dcb0c83..d1d1cfb22e27 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -100,14 +100,28 @@ static const struct pdc2027x_udma_timing {
 };
 
 static const struct pci_device_id pdc2027x_pci_tbl[] = {
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20268), PDC_UDMA_100 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20269), PDC_UDMA_133 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20270), PDC_UDMA_100 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20271), PDC_UDMA_133 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20275), PDC_UDMA_133 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20276), PDC_UDMA_133 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20277), PDC_UDMA_133 },
-
+	{
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20268),
+		.driver_data = PDC_UDMA_100,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20269),
+		.driver_data = PDC_UDMA_133,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20270),
+		.driver_data = PDC_UDMA_100,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20271),
+		.driver_data = PDC_UDMA_133,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20275),
+		.driver_data = PDC_UDMA_133,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20276),
+		.driver_data = PDC_UDMA_133,
+	}, {
+		PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20277),
+		.driver_data = PDC_UDMA_133,
+	},
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index a32723e46357..2dad77c828f2 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -362,13 +362,12 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 }
 
 static const struct pci_device_id pdc202xx[] = {
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20263), 1 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20265), 2 },
-	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20267), 2 },
-
-	{ },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), .driver_data = 0 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), .driver_data = 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20263), .driver_data = 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20265), .driver_data = 2 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20267), .driver_data = 2 },
+	{ }
 };
 
 static struct pci_driver pdc202xx_pci_driver = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 4edddf6bcc15..dc595688d3ba 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -467,13 +467,23 @@ static int serverworks_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id serverworks[] = {
-	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
-	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 2},
-	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE), 2},
-	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2), 2},
-	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 2},
-
-	{ },
+	{
+		PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE),
+		.driver_data = 2,
+	}, {
+		PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE),
+		.driver_data = 2,
+	}, {
+		PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2),
+		.driver_data = 2,
+	}, {
+		PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE),
+		.driver_data = 2
+	},
+	{ }
 };
 
 static struct pci_driver serverworks_pci_driver = {
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 2b751e393771..8262f4f8e6e7 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -891,7 +891,6 @@ static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
 	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
 	{ PCI_VDEVICE(SI, 0x1180), },	/* SiS 1180 */
-
 	{ }
 };
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index a8c9cf685b4b..cb53fe698c6e 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -675,16 +675,15 @@ static int via_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id via[] = {
-	{ PCI_VDEVICE(VIA, 0x0415), },
-	{ PCI_VDEVICE(VIA, 0x0571), },
-	{ PCI_VDEVICE(VIA, 0x0581), },
-	{ PCI_VDEVICE(VIA, 0x1571), },
-	{ PCI_VDEVICE(VIA, 0x3164), },
-	{ PCI_VDEVICE(VIA, 0x5324), },
-	{ PCI_VDEVICE(VIA, 0xC409), VIA_IDFLAG_SINGLE },
-	{ PCI_VDEVICE(VIA, 0x9001), VIA_IDFLAG_SINGLE },
-
-	{ },
+	{ PCI_VDEVICE(VIA, 0x0415), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0x0571), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0x0581), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0x1571), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0x3164), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0x5324), .driver_data = 0 },
+	{ PCI_VDEVICE(VIA, 0xC409), .driver_data = VIA_IDFLAG_SINGLE },
+	{ PCI_VDEVICE(VIA, 0x9001), .driver_data = VIA_IDFLAG_SINGLE },
+	{ }
 };
 
 static struct pci_driver via_pci_driver = {
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 17a5a59861c3..30aaf5c5337b 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -157,8 +157,7 @@ static struct ata_port_info adma_port_info[] = {
 };
 
 static const struct pci_device_id adma_ata_pci_tbl[] = {
-	{ PCI_VDEVICE(PDC, 0x1841), board_1841_idx },
-
+	{ PCI_VDEVICE(PDC, 0x1841), .driver_data = board_1841_idx },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f6942fd80bae..41647a56a9f4 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4274,32 +4274,32 @@ static int mv_pci_device_resume(struct pci_dev *pdev);
 #endif
 
 static const struct pci_device_id mv_pci_tbl[] = {
-	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
-	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+	{ PCI_VDEVICE(MARVELL, 0x5040), .driver_data = chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5041), .driver_data = chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5080), .driver_data = chip_5080 },
+	{ PCI_VDEVICE(MARVELL, 0x5081), .driver_data = chip_508x },
 	/* RocketRAID 1720/174x have different identifiers */
-	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1720), .driver_data = chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1740), .driver_data = chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1742), .driver_data = chip_6042 },
 
-	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
-	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
-	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6040), .driver_data = chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6041), .driver_data = chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6042), .driver_data = chip_6042 },
+	{ PCI_VDEVICE(MARVELL, 0x6080), .driver_data = chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6081), .driver_data = chip_608x },
 
-	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
+	{ PCI_VDEVICE(ADAPTEC2, 0x0241), .driver_data = chip_604x },
 
 	/* Adaptec 1430SA */
-	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), .driver_data = chip_7042 },
 
 	/* Marvell 7042 support */
-	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+	{ PCI_VDEVICE(MARVELL, 0x7042), .driver_data = chip_7042 },
 
 	/* Highpoint RocketRAID PCIe series */
-	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
-	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2300), .driver_data = chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2310), .driver_data = chip_7042 },
 
 	{ }			/* terminate list */
 };
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 19b927065868..8624cd4e88cc 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -344,21 +344,49 @@ enum nv_host_type
 };
 
 static const struct pci_device_id nv_pci_tbl[] = {
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA), NFORCE2 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA), NFORCE3 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2), NFORCE3 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA), CK804 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2), CK804 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA), CK804 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2), CK804 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA), MCP5x },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2), MCP5x },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA), MCP5x },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2), MCP5x },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
-
+	{
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA),
+		.driver_data = NFORCE2,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA),
+		.driver_data = NFORCE3,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2),
+		.driver_data = NFORCE3,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA),
+		.driver_data = CK804,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2),
+		.driver_data = CK804,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA),
+		.driver_data = CK804,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2),
+		.driver_data = CK804,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA),
+		.driver_data = MCP5x,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2),
+		.driver_data = MCP5x,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA),
+		.driver_data = MCP5x,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2),
+		.driver_data = MCP5x,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
+		.driver_data = GENERIC,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
+		.driver_data = GENERIC,
+	}, {
+		PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
+		.driver_data = GENERIC,
+	},
 	{ } /* terminate list */
 };
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c5fad448bafc..6da1dea00b84 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -281,25 +281,25 @@ static const struct ata_port_info pdc_port_info[] = {
 };
 
 static const struct pci_device_id pdc_ata_pci_tbl[] = {
-	{ PCI_VDEVICE(PROMISE, 0x3371), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3373), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3375), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3376), board_2037x },
-	{ PCI_VDEVICE(PROMISE, 0x3570), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3571), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3577), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2057x },
-	{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3371), .driver_data = board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3373), .driver_data = board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3375), .driver_data = board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3376), .driver_data = board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3570), .driver_data = board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3571), .driver_data = board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3574), .driver_data = board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3577), .driver_data = board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3d73), .driver_data = board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3d75), .driver_data = board_2057x },
 
-	{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3515), board_40518 },
-	{ PCI_VDEVICE(PROMISE, 0x3519), board_40518 },
-	{ PCI_VDEVICE(PROMISE, 0x3d17), board_40518 },
-	{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3318), .driver_data = board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3319), .driver_data = board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3515), .driver_data = board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3519), .driver_data = board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3d17), .driver_data = board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3d18), .driver_data = board_40518 },
 
-	{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },
+	{ PCI_VDEVICE(PROMISE, 0x6629), .driver_data = board_20619 },
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 1add7a7d5ff6..4e7f5b2ff3f6 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -146,8 +146,7 @@ static const struct ata_port_info qs_port_info[] = {
 };
 
 static const struct pci_device_id qs_ata_pci_tbl[] = {
-	{ PCI_VDEVICE(PDC, 0x2068), board_2068_idx },
-
+	{ PCI_VDEVICE(PDC, 0x2068), .driver_data = board_2068_idx },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 1b6dc950a42a..8837e7c37d4c 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -112,14 +112,13 @@ static void sil_thaw(struct ata_port *ap);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
-	{ PCI_VDEVICE(CMD, 0x3112), sil_3112 },
-	{ PCI_VDEVICE(CMD, 0x0240), sil_3112 },
-	{ PCI_VDEVICE(CMD, 0x3512), sil_3512 },
-	{ PCI_VDEVICE(CMD, 0x3114), sil_3114 },
-	{ PCI_VDEVICE(ATI, 0x436e), sil_3112 },
-	{ PCI_VDEVICE(ATI, 0x4379), sil_3112_no_sata_irq },
-	{ PCI_VDEVICE(ATI, 0x437a), sil_3112_no_sata_irq },
-
+	{ PCI_VDEVICE(CMD, 0x3112), .driver_data = sil_3112 },
+	{ PCI_VDEVICE(CMD, 0x0240), .driver_data = sil_3112 },
+	{ PCI_VDEVICE(CMD, 0x3512), .driver_data = sil_3512 },
+	{ PCI_VDEVICE(CMD, 0x3114), .driver_data = sil_3114 },
+	{ PCI_VDEVICE(ATI, 0x436e), .driver_data = sil_3112 },
+	{ PCI_VDEVICE(ATI, 0x4379), .driver_data = sil_3112_no_sata_irq },
+	{ PCI_VDEVICE(ATI, 0x437a), .driver_data = sil_3112_no_sata_irq },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4549ba968a4..38291ae772c9 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -351,14 +351,13 @@ static int sil24_port_resume(struct ata_port *ap);
 #endif
 
 static const struct pci_device_id sil24_pci_tbl[] = {
-	{ PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
-	{ PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
-	{ PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
-	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
-	{ PCI_VDEVICE(CMD, 0x0244), BID_SIL3132 },
-	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
-	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
-
+	{ PCI_VDEVICE(CMD, 0x3124), .driver_data = BID_SIL3124 },
+	{ PCI_VDEVICE(INTEL, 0x3124), .driver_data = BID_SIL3124 },
+	{ PCI_VDEVICE(CMD, 0x3132), .driver_data = BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x0242), .driver_data = BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x0244), .driver_data = BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x3131), .driver_data = BID_SIL3131 },
+	{ PCI_VDEVICE(CMD, 0x3531), .driver_data = BID_SIL3131 },
 	{ } /* terminate list */
 };
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index b8b6d9eff3b8..9deb8060101a 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -51,13 +51,31 @@ static int sis_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int sis_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VDEVICE(SI, 0x0180), sis_180 },	/* SiS 964/180 */
-	{ PCI_VDEVICE(SI, 0x0181), sis_180 },	/* SiS 964/180 */
-	{ PCI_VDEVICE(SI, 0x0182), sis_180 },	/* SiS 965/965L */
-	{ PCI_VDEVICE(SI, 0x0183), sis_180 },	/* SiS 965/965L */
-	{ PCI_VDEVICE(SI, 0x1182), sis_180 },	/* SiS 966/680 */
-	{ PCI_VDEVICE(SI, 0x1183), sis_180 },	/* SiS 966/966L/968/680 */
-
+	{
+		/* SiS 964/180 */
+		PCI_VDEVICE(SI, 0x0180),
+		.driver_data = sis_180,
+	}, {
+		/* SiS 964/180 */
+		PCI_VDEVICE(SI, 0x0181),
+		.driver_data = sis_180,
+	}, {
+		/* SiS 965/965L */
+		PCI_VDEVICE(SI, 0x0182),
+		.driver_data = sis_180,
+	}, {
+		/* SiS 965/965L */
+		PCI_VDEVICE(SI, 0x0183),
+		.driver_data = sis_180,
+	}, {
+		/* SiS 966/680 */
+		PCI_VDEVICE(SI, 0x1182),
+		.driver_data = sis_180,
+	}, {
+		/* SiS 966/966L/968/680 */
+		PCI_VDEVICE(SI, 0x1183),
+		.driver_data = sis_180,
+	},
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index c5d6aa36c9c3..1f5ce36701c7 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -500,14 +500,13 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
  * controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0410), chip_svw42 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0411), chip_svw43 },
-
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), .driver_data = chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), .driver_data = chip_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), .driver_data = chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), .driver_data = chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), .driver_data = chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0410), .driver_data = chip_svw42 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0411), .driver_data = chip_svw43 },
 	{ }
 };
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 227dc1d4e85b..cab40c10ad6b 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -267,8 +267,7 @@ static const struct ata_port_info pdc_port_info[] = {
 };
 
 static const struct pci_device_id pdc_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(PROMISE, 0x6622), board_20621 },
-
+	{ PCI_VDEVICE(PROMISE, 0x6622), .driver_data = board_20621 },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 44985796cc47..122133199ea7 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -45,10 +45,9 @@ static int uli_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int uli_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id uli_pci_tbl[] = {
-	{ PCI_VDEVICE(AL, 0x5289), uli_5289 },
-	{ PCI_VDEVICE(AL, 0x5287), uli_5287 },
-	{ PCI_VDEVICE(AL, 0x5281), uli_5281 },
-
+	{ PCI_VDEVICE(AL, 0x5289), .driver_data = uli_5289 },
+	{ PCI_VDEVICE(AL, 0x5287), .driver_data = uli_5287 },
+	{ PCI_VDEVICE(AL, 0x5281), .driver_data = uli_5281 },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index b672a1e05867..cfd8ff1f529c 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -85,15 +85,35 @@ static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
-	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
-	{ PCI_VDEVICE(VIA, 0x0591), vt6420 }, /* 2 sata chnls (Master) */
-	{ PCI_VDEVICE(VIA, 0x3149), vt6420 }, /* 2 sata chnls (Master) */
-	{ PCI_VDEVICE(VIA, 0x3249), vt6421 }, /* 2 sata chnls, 1 pata chnl */
-	{ PCI_VDEVICE(VIA, 0x5372), vt6420 },
-	{ PCI_VDEVICE(VIA, 0x7372), vt6420 },
-	{ PCI_VDEVICE(VIA, 0x5287), vt8251 }, /* 2 sata chnls (Master/Slave) */
-	{ PCI_VDEVICE(VIA, 0x9000), vt8251 },
-
+	{
+		PCI_VDEVICE(VIA, 0x5337),
+		.driver_data = vt6420,
+	}, {
+		/* 2 sata chnls (Master) */
+		PCI_VDEVICE(VIA, 0x0591),
+		.driver_data = vt6420,
+	}, {
+		/* 2 sata chnls (Master) */
+		PCI_VDEVICE(VIA, 0x3149),
+		.driver_data = vt6420,
+	}, {
+		/* 2 sata chnls, 1 pata chnl */
+		PCI_VDEVICE(VIA, 0x3249),
+		.driver_data = vt6421,
+	}, {
+		PCI_VDEVICE(VIA, 0x5372),
+		.driver_data = vt6420,
+	}, {
+		PCI_VDEVICE(VIA, 0x7372),
+		.driver_data = vt6420,
+	}, {
+		/* 2 sata chnls (Master/Slave) */
+		PCI_VDEVICE(VIA, 0x5287),
+		.driver_data = vt8251,
+	}, {
+		PCI_VDEVICE(VIA, 0x9000),
+		.driver_data = vt8251,
+	},
 	{ }	/* terminate list */
 };
 
-- 
2.47.3

