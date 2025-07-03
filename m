Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9772D5412
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539115; cv=none; b=jRBmKvojg6N1Kx1DCSryu+2fIjwTCH+ifpxJ5EVJlVP0/lBLjkl5WIuC+9660ojJf4mi1P6Mm8Rzme5IdORgoijW4EsrFkjrtxu5nK1gn9Kkgs/IJVTcCSSnk65eHcDQWb2GdHlq8v2ZE7b5bATY4maoureEwQQGYXPYYWXOmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539115; c=relaxed/simple;
	bh=0qPTryyHzqXiFKlXbMk+ARq3aX6r/o2ktVTl+va8zmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLsGE+0EhsCulqHa3JB4poNWrRMgON3qG5GnbgRVAsdxIijEBIO2jkJtQxSS337ownI+wyW4xJYhK96DZARJ3QdcMQlslzyMLRVWzA0RHfgji/KmlmJSK48zwpAm/C0DuMI1RGgmoTH14Kxti96sBqhIqRuMmzg2zesUJaLmhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYmk9j57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYmk9j57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76821C4CEEB;
	Thu,  3 Jul 2025 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539114;
	bh=0qPTryyHzqXiFKlXbMk+ARq3aX6r/o2ktVTl+va8zmM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GYmk9j57VBHFOOXmqsCrw1M1SmWBYoKv9YgrhaACClb1ZsYYos7XiB/5tsgViRRIj
	 yva/MgCpQIsNtlg4iaB30ziWsi6QMeG3Etet/miYupPlK7tXEpPukSACGuGB3eGGge
	 VKC/bOYLP3LIphR2mYb6E9ymKLXzJo6wDGRNzL5GwnM0v4ovIj0ddppOZMHh+qhpeO
	 Ho5Zn8k/p/8XvOkgC6YYOF/R5zU/hQLjgjklxevPsOqji0yxK7Rv6PYbllPZgqofoW
	 4ekSOi5ihzGp0Jp2xvVsKkItynJl/IMpfvMLru7+ubF5Nt3SxslgJm/c9D/z/ktQ1f
	 D9z9DbOJz4XQw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/4] ata: libata-eh: Rename and make ata_set_mode() static
Date: Thu,  3 Jul 2025 19:36:21 +0900
Message-ID: <20250703103622.291272-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703103622.291272-1-dlemoal@kernel.org>
References: <20250703103622.291272-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ata_set_mode() is defined and used only in libata-eh.c.
Make this function static and rename it ata_eh_set_mode() to make it
clear where its definition is.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 9 +++++----
 drivers/ata/libata.h    | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0f9c30f9bc1e..8b2a0a56ffe1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3408,12 +3408,12 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 }
 
 /**
- *	ata_set_mode - Program timings and issue SET FEATURES - XFER
+ *	ata_eh_set_mode - Program timings and issue SET FEATURES - XFER
  *	@link: link on which timings will be programmed
  *	@r_failed_dev: out parameter for failed device
  *
  *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
- *	ata_set_mode() fails, pointer to the failing device is
+ *	ata_eh_set_mode() fails, pointer to the failing device is
  *	returned in @r_failed_dev.
  *
  *	LOCKING:
@@ -3422,7 +3422,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+static int ata_eh_set_mode(struct ata_link *link,
+			   struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
@@ -3926,7 +3927,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		/* configure transfer mode if necessary */
 		if (ehc->i.flags & ATA_EHI_SETMODE) {
-			rc = ata_set_mode(link, &dev);
+			rc = ata_eh_set_mode(link, &dev);
 			if (rc)
 				goto rest_fail;
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 767a61f8ff89..135e1e5ee44e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -177,7 +177,6 @@ extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
-extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset,
-- 
2.50.0

