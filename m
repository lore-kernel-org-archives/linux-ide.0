Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301402;
	b=XbBHQndn9BRpXFWGg4aECLrz8YrwUc/KginFYo2UIbtyHoHZ8wwJWx9LavJcKn7w/aTg
	 jzyETeRKQQLTDdJpAyhVvlgjx8FQfczc5ZjEv78KGpf7lGERF1LPHGADyUYahZ8FvNW1Y
	 gKw9+brn9QAk31S9N4//yNb5lmBV1gSUSxpTqEdJSkOihxx+C/QsJMXB7BhIhtAQa39bS
	 OTMb2hWrvMSKlE/sQGjuijsPIgVQiQkMghFzAr9la9Mu2mTwzPfn80C6z4RoKGePcY+P3
	 JJty3fWzxrVqSc0DC4vNzNGmviIW+8d7JqMg/vfiH6xkpbJzSNK+eJ8+OOiiQCstkRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
	b=JgsGZE5ymp9o+k1VX0OWrX85wGnbIZY7zEGar32jNgw7fAay8lM273R6YxXUSO8cfMJT
	 RtBqvSY0WecaJNrWiZh2XM8KGV9C5qpW5Rjqf+dcLkIAjrzePm0I0SPI3+sm/J2Wm0xXM
	 plT8qCefcQlww50ryPOw42bIUC+x9Ojdp2AvjOaSAmJLh7lLpMz2YjIqFTuJzFnrwLoLB
	 sp/N2C+fRkqejH1kh9hOUvspNlXG3x2IueENz6Z0o0mbO3CFYNFx2PVqvyr33hiAh03j3
	 loxibk+LVLJn8aaof8COFxEq1r/Gf44JgerbBHoU0RwEUrD5WXHkL2PCx4lCG5nEKMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQa8NbCI;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629B60A260C
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 09:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6629B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQa8NbCI
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3ada81853so1512938c88.0
        for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794301401; x=1794906201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
        b=aQa8NbCIL5iROR1xv9a893vuA9VKs+H4UP3noZWQVQc6eHiZUFmGQ19+107lwy8Hp2
         e9ypF7OCdmIIc25iDGMH7Xw1pnCfj/8fyNFIEb2WGQLkgvCdjP8MBZwconVQJlUXYoi1
         yDAtJErHd09SKjykRmQNmGs9Vu1Rmqu1U2+ba+1noReQUUo0c/9G9afr8Te1Yuw+iFne
         vfgEoWL045JiXncdLEqUhBzR/5xH0eTNb/e/w+EXdu/LQK1Lxo6Bxv4avKBJJd4vdbVw
         XGT0uQrgoTRt7PHMwafIP/Ur8zqyYCDaQo37i50bQO1NU1wGdFiO42y/dJp/nqvvSiit
         9ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301402; x=1794906202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pKo1oEO3VP8nUxaxFU+sFTw1naND9wtU7Tr0haxUyM=;
        b=MssWfoi1q5mKqFo5Hoj3JPvVEHaBeXvsaKQaD7imHLgwtzhdqmKVQYN6SWYYPibyo3
         Q4piIadooB+37ADJgCW6e9zXjDlKuB5YMuMEqMXqsF7o2Nt0DxL7RDg4g26q+13/zPea
         gL1z1O5xEfyGnYFvCHszuaRyk8PZFG53+UGdJZT9j8H1HhSGJdOkPy6jLrx96JEeCIuM
         HjFBa+8cMfJaiWARDM8qwu8ww+SChsygH792PZrP/v0PR8Y2LjZjZxtglqC2rLq6Bseb
         +saM5DPHshZQrNl/cbCi3yUG+YNI9VO3qCpSMSGL2EZHD88ELYaXlxB7Zzj2zyEzf2Se
         dOig==
X-Gm-Message-State: APuU4Z81QtHmEb2638Upi5ZCU8KHGS8ycUVTM6jxgzfS2TPGt4D4B261
	bv23r15JJvYZiIdWbDjNARm6mcqUKCA1MzUplkaJ/TjgDiWTWA2a28b7
X-Gm-Gg: AYBFou39u0QRK+5+z6EsyPXY2re9C/2/Aj+g4N/E+jPEvh6A39373tVdTUVGR4b0Yug
	apqm+Ixeea5DW5h0opvlpY05m9eE4NgalqZ3ht9P2M+QT0jE+DYBjgH0joLbep6MVpS584hokEF
	iyYyKIi7GKWVzqkCc6BiZhR90sVqftjfobMEv6OYy2rL702wr6SZ48oo351jh0FrN1a5KeiwuwG
	w5ZF82dJhxG/yRRsgE7Jo8srbUVjdql6WU2BjhbFnzwuBEd9Vk/wtXvqNstqdJnqbbzx+rNfnDK
	vH88/iGPtD6DFPAqn2K66LDUqH0GYE4fDukCGQdS/VlL/b8T/Uiv/dqUnDF8IGrGdB471JnWtZe
	HPJ9KtDnZTc1rQV3/OUTQZ+Ia5zsNnIU1gv1jb17yUF6p63PGBdzrHptjecM0s9naNddHB8+RbR
	tqQhbmtcpwq5LEUPyjG8Ay0TSkVJbFlyeft/1NgxeMtk0goPMq+qBnINNk/DjvT/Hd7LGVzs6hE
	xbsq9/E/YHRrPvFfbvBIh/zPFg4G6yzLbcn8OCil5Ri25stNZ24zGHznhxlktt6cCEN3YfY/LwB
	12DxDzjFDWuh5msPgDOgIORcn0bAAFoF0bE4T8LGTXStnXGxkbY/7nRY069DPyhThDPhXg==
X-Received: by 2002:a05:701b:2704:b0:16c:3408:760b with SMTP id a92af1059eb24-1b3b60097bemr2296116c88.32.1794301401116;
        Tue, 10 Nov 2026 01:03:21 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm5762557eec.7.2026.11.10.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:03:20 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] ata: libahci: delete the SW activity blink timer on port stop
Date: Tue, 10 Nov 2026 18:03:03 +0900
Message-ID: <20261110090303.2415681-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The software activity LED support arms a per-EM-port timer (emp->timer,
ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
callback re-arms itself while the LED is blinking. The timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer - nothing in libahci does - so
when the SW activity LED is in use and the AHCI port is stopped (driver
unbind / module unload) while the blink timer is still pending,
ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
dereferences the freed ahci_em_priv (use-after-free).

Shut the timers down in ahci_port_stop() before the port private data is
released, only when ATA_FLAG_SW_ACTIVITY is set and skipping em_priv slots
that ahci_init_sw_activity() never set up. Because the callback re-arms
itself, use timer_shutdown_sync() so a concurrent re-arm cannot resurrect
it.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v3:
- Shorten the code comment (Niklas Cassel).

Changes in v2:
- Gate the shutdown loop on ATA_FLAG_SW_ACTIVITY and skip em_priv slots
  whose timer was never set up (emp->timer.function unset), so
  timer_shutdown_sync() is not called on an uninitialised timer
  (Sashiko AI review).

v2: https://lore.kernel.org/linux-ide/20261109060709.1231946-1-hj351016@gmail.com/

 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..873645c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,24 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
 	int rc;

+	/*
+	 * Stop the SW activity blink timers before devres frees pp, skipping
+	 * the slots that ahci_init_sw_activity() never set up.
+	 */
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
+		ata_for_each_link(link, ap, EDGE) {
+			emp = &pp->em_priv[link->pmp];
+			if (emp->timer.function)
+				timer_shutdown_sync(&emp->timer);
+		}
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
--
2.43.0
