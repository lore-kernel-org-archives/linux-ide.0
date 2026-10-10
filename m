Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B1408018
	for <linux-ide@vger.kernel.org>; Sat, 10 Oct 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633452; cv=none; b=A+UMUZF+0B2CP/pmMWSgWzeZ0AGz9RwF8Q/b8SSHtytJM5Oryj5bjVBTYAK9uxiUHwBOH4PbJBLxcqvfP1Q3XRSRxSCvvJNKk3FmmzRRzm0RWT90TaZzJTF90KdWHT7KxUyDMDNoiRSAIi9OCS/g4/iCMGG1nfKvnHD3bKQ5h5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633452; c=relaxed/simple;
	bh=IPHKDzjbFgM3zlhg6leD9uSe5AtAZXl5V+tpFvZLAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VG3OqGLfkQ2jfnsI6JubVoYTVgCKZDYK7BH6rfjbEAGn1KZkDNnANf8o8O2WDMv2or0mlGidilJIoQpzx45wpJgGOM/Z5w3grZMX35wEnMu25B8+9KRAg1SMxG6oQksZDL2FTgRJZjJWw7bffOlpKm4sU8hs6782J+l28F9eBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crqiOGaU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crqiOGaU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b13fb95060so864789a12.0
        for <linux-ide@vger.kernel.org>; Sat, 10 Oct 2026 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791633449; x=1792238249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=imQ1BTY49pJIiAbK6CLYEgMI91fldvadbFKmtskRHBI=;
        b=crqiOGaUpKoyFGRI/7IiEBWgcx6zToUD4CM/l5VShsPgIkZAnk7OJz2UID3tql4YhW
         KmpYHA4I96gS0lE0nz2Mq4oZooirN72YAor/cNMUQTTk93t77qctYXofMI9udpUOq0X9
         8njlUCFS2QLI5HXKvEof5GEqezFAGKKy7UK4mQWtPTYv/RELqyAqJe5VQsyfUaKKgAUT
         QMIgrwoA5zg6sO496NDllbfzPgDpqOGRViuhO8EyLPRlw/MuVLEG2CNVKb+57NfjPIJy
         9p9GCC0eA9K1j826PGkhey2alSODfNTV573TK+UTy2Zx+f6kSlIqMy+x+2RfRY4fEMnY
         bALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791633449; x=1792238249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imQ1BTY49pJIiAbK6CLYEgMI91fldvadbFKmtskRHBI=;
        b=nVF/lzJkW7q9KmhoS43rOkCp4dWjNCMBSNw01T7LukcxJPu0k8dLu4WBDHtF+9Itkq
         H63LJeozA92UwiK7EfrM7w+oIswfnVajDDicc6fmdS96S5aLbt4qJ7XuAp8n2bj7sa2Y
         JoQag/lVBfauGjq9ovXDIbjWRgzcar3YXsrvyOQYe7qwEbZK4Sbx3Mz4ITfd/5B5LiQQ
         C+vNd8cWNBqC2Rg1y33Cfub/YJ6qySFaex6H9ZJWldl+cT9XpPsXHLuw8UvuQaCYa5ma
         e2thsP8wrQ4uqwntrdJY3C5n6nOry8LIxltspX24PTntkPCSZqN8FpoF9SO56DNnWyNd
         QUag==
X-Gm-Message-State: AFq9FYJBg0Qu1SgxTsdFlUus59dKCqjvoqLr0+1BOnVb18bDAghtVRnS
	8zuNiJkZywtrgn5nFwMnhTZzhDLibG3g9u/aZvgDXNnh1Th6yZBS3fCvAeLhg7h6Zh9eLrXHUgU
	=
X-Gm-Gg: AYBFou1kDPG8j/PlUJ7BkvxKS190wMtn7E5my7hnFvgXvydp4ifJW+0Wb9EYnn/7BNn
	KitJ9rFJWdjko3tQYB8nOGS9K9XwWDDVsmBU/lFIZL5RwIeXj0fhV6wWodhx2n3dcdtCkqjxJzD
	kjGDg44jwJFvHPbmE1QffkQIoOGrBaVP2/0TSmpgsdRPrgu8yaNMtZXSi9JqysqvRWKw5T2iPUA
	ejrkGQaQzGZJcYJs7tO1+35l2FJVHk4y/qEHQH5O3PpozmJPzXyseByatB2KI3/Mb0TLOQJeW/D
	bqrRb/S7YjRDIkcDSmxvPYtp3yTuVWlsnqo6VENppJWxwwqo0R3lHzyr7yzuemlvoVJ//+ecS05
	w4ypg9hE3fLyTcOIGK5hyTVMIegKhT4Nqp1N6HtnM9JJd/6a7WDcTnOd2Mk8Ulo5Q+P5aun5VRq
	nnbp587DPCX2Xoynw0te2gYskGkXRr2liVMwMWjn+LOGOY90XQU2BiYEVnm2ASTfUAIknBB9ILT
	fgGFjUEca910swPhQtcKk3uC/ttKxy1+kPkOKYv5S/CtFXC6MNkJX7NW+3vb7cyH0ebm/H8cfbJ
	I2r6nQ==
X-Received: by 2002:a17:907:c60e:20b0:c31:e958:408c with SMTP id a640c23a62f3a-c31e9584622mr235493266b.38.1791633449130;
        Sat, 10 Oct 2026 04:57:29 -0700 (PDT)
Received: from localhost.localdomain (host-188-122-3-146.finemedia.com.pl. [188.122.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3bbeesm236359966b.18.2026.10.10.04.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 04:57:28 -0700 (PDT)
From: illofspeed <volvo.mail@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libahci: re-enable FBS after error handling on a port multiplier
Date: Sat, 10 Oct 2026 13:57:27 +0200
Message-ID: <20261010115727.401-1-volvo.mail@gmail.com>
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
Signed-off-by: illofspeed <volvo.mail@gmail.com>
---

Notes:
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

