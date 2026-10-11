Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AC3264D5
	for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741762; cv=none; b=lcUeUozNkelLIyKc5BebNmWj6VuTdJYF2qkIxGRd4ZgEaKuXFYWW9LcqbwoLXDKksyzKnP1EJAZOM3K8URbrbxrog0waSK81t1J1LfFuo73dgc5x78f14BE/cOZS2WSttqLtC5DNVvjc0IQB3597UCP+l6o6GMcQIQiAg/NgZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741762; c=relaxed/simple;
	bh=S1pu0AtwGNp5O8yuxB5m01iXXhRtX5Rk+wvO3Mi/aqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMd3CHbkHxTCJ4BGG/uPb2WJ4Dc2BgCYFDy7FNRO1HL20ej9Ti4IAr/hTrW+ISlzK0U1QUFjMWAZU6TOTY/L2fE/hnWm6OXpuCf3gNyWKTuNd5Tyk2T9k5PjneHzqEdQcSePUgdHx9W2BC4qvyBXNQSrKJkeBvxHd2/w28/hJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ+xj7A+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ+xj7A+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so12110465e9.2
        for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2026 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791741758; x=1792346558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/HSc9UnNOXRXCKyg6XtOS9gbQDO617I0F1b7UxDU6U=;
        b=IZ+xj7A+sE6vyzJE1BQhUauYsx/ZtjeZTTv2t6XX+CyQkXn+nHpq8lYZ4lTM0ONWsP
         3xEcG7Z5x2yfFv4W313dwtmYwB4kTnbAcH1iuXwoE2Ry9E2N+gmRE9wJ2DS60HEf+0s4
         qaG/ox5inhWdikKYlxx49vUyva9te7redkwD+0XoKwZn44XNJwZMRDDFMJUpawcB5s08
         plVpLzSJQ1TbLTe2Vjwb9uX+ICwHVZknGR5oLT7tt60t7CfTfVHenarZ+uGiUeNM/LGs
         DM63h6RHuWxmdDinuS9gL5clQj1PY9ou8xpJc913h75lvk8JhBl0mNFmHR4icSrVbfso
         vihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791741758; x=1792346558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/HSc9UnNOXRXCKyg6XtOS9gbQDO617I0F1b7UxDU6U=;
        b=gu+h8/ql7DkBu6CliKcz+Tr7Y3mWZxYPTnYHk/1S7eTus2aZ82SBz9HzPtPb+NnsyH
         kRgYloeUDo/rL5JBNQLNUAZdzHupaee2qSJl2ZeQmWxK6Ekj8ZQgD8prRVEfYHltGEGX
         eSK24+0XTwBJtqzNqeepDLQTrjiTOckTQZKYhlUWI53I0J83ydRzc8HbAg4r25TzZKZk
         6e1pvfWLQwbN3/+BUvVrIcK5NJ4xAwcjxCQtEfudras5F56zBsm0v4ocjcC4YiC8nVI9
         Inm3aCCX0tKkBXPJBeXMbOqEh1qEJfZk+/5FZlaXIdSjz++ZPIIXVImvdueNAW9At5Ts
         kQYw==
X-Gm-Message-State: AFq9FYLg0TFVCLM0ExY3pvTcZRG5WR53UQRCu0XeX4tDzFNKU2li+z1M
	aY77RU5T8g9fcbp40H7y0hi3wNms8OX/9y8m0M1A8pnZDqjCgZx+gdNeNotuVmn1s0Y=
X-Gm-Gg: AYBFou3E2q0pw4mviheV7EMBU3s9P2TuZDivAVawhs7ycyrOGfhPuu2ZcwQ0dwHXk3j
	qq7g+cBOXOvnJOTqjMBRvabuc9WIDCyoplWwBnfDKR+GLlmhKnj5FZa7z25cjAxKsv3NjOY9Cn1
	NzEdl4HTsLsFe2p5Q9k2szTMN0fXMJyATxZERNAwEsLfvA7PFwiCe3aX3wI16XYk2XiZT+bpjsR
	m8RfacSi6Mvi2gm0viZFa4A2sQV0ocXWHMQRj3Iw0qQZsg2gvcdNyZxLYsOmU84ZCyYc8fez3rg
	xUskYtyPwhogkoFVsG+qkCYfWiuJWyNAMa6Z+RqTFhOJa1VNdvBd5pkJ+BIldFatQuDh3YACNvw
	jlxUfE+6Zaq/i2f/doGpCXkpOMv1XJxhS3ZnEkzVSPxvK+IEISu9GsElujpieCHrAm3w4ZkRSTJ
	C4tf87BAQ3HDmf+TprhxSURuuiqAovEfhizn7nTCo02CUrHPIxEtaCfI87S9Wo+4H8XrwztpZM6
	eX/KZSVHOf+14Dq+OhEhlHRbHmOBybayCNmLcnt3gGn5jmn
X-Received: by 2002:a05:600c:a01:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-4a18e4fe3e1mr154568895e9.35.1791741758031;
        Sun, 11 Oct 2026 11:02:38 -0700 (PDT)
Received: from localhost.localdomain (87-205-122-125.dynamic.inetia.pl. [87.205.122.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf15691sm221728095e9.6.2026.10.11.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 11:02:37 -0700 (PDT)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ata: libahci: re-enable FBS after error handling on a port multiplier
Date: Sun, 11 Oct 2026 20:02:36 +0200
Message-ID: <20261011180236.735-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahci_do_softreset() disables FBS before resetting a device behind a port
multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
when that softreset succeeds. If it fails, for example because a
hot-plugged drive is still spinning up ("softreset failed (device not
ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
The port keeps working with command-based switching until then.

Seen on a Marvell 88SE9235 (1b4b:9235) with Marvell 88SM9705 port
multipliers (1b4b:9705, in a Synology DX1222 expansion unit): after
hot-plugging a drive, the kernel logged "FBS is disabled" followed by
"softreset failed (device not ready)" and a PMP hardreset, and never
"FBS is enabled" again (twice, on two different ports).

At the end of ahci_error_handler(), re-enable FBS if a PMP is still
attached and FBS is supported but disabled.

Tested on 7.2.6 with the patch built as an out-of-tree libahci (the stock
ahci module binds to it, symbol CRCs are unchanged). Hot-plugging a drive
into a free port of the multiplier then logged "FBS is disabled",
"softreset failed (device not ready)" and a PMP hardreset, followed by
"re-enabling FBS after error handling" and "FBS is enabled". Afterwards
two other drives behind the same multiplier read 259 + 259 MB/s in
parallel (O_DIRECT, 4 MiB blocks), against 268 MB/s for one drive alone,
so their commands overlap again.

Fixes: 89dafa20f3da ("ahci: disabled FBS prior to issuing software reset")
Assisted-by: LLM
Signed-off-by: Kyrylo Biryuk <illofspeed@gmail.com>
---

Notes:
    v3: no code changes. From and Signed-off-by now carry my full name
    instead of the GitHub handle "illofspeed" used for v2 (same author).
    
    The controller is passed through (VFIO) to a KVM guest; the tested kernel is the
    guest's. The two earlier occurrences without the patch were on ata8 and ata10 of the
    same controller; this test was on ata7.

 drivers/ata/libahci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 08ab56e9556..6f374fd79f5 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2233,6 +2233,23 @@ void ahci_error_handler(struct ata_port *ap)
 
 	sata_pmp_error_handler(ap);
 
+	/*
+	 * ahci_do_softreset() turns FBS off before resetting a fan-out link
+	 * and turns it back on only if that reset succeeds. When it fails
+	 * (e.g. a hot-plugged drive is still spinning up), EH escalates to a
+	 * PMP hardreset, which never re-enables FBS, so the port would keep
+	 * command-based switching until the PMP is attached again (reboot).
+	 * Restore FBS once recovery is done and the PMP is still attached.
+	 */
+	if (sata_pmp_attached(ap) && ata_dev_enabled(ap->link.device)) {
+		struct ahci_port_priv *pp = ap->private_data;
+
+		if (pp->fbs_supported && !pp->fbs_enabled) {
+			ata_port_info(ap, "re-enabling FBS after error handling\n");
+			ahci_enable_fbs(ap);
+		}
+	}
+
 	if (!ata_dev_enabled(ap->link.device))
 		hpriv->stop_engine(ap);
 }
-- 
2.43.0

