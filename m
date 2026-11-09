Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204438;
	b=5Fgf+N0W7yMVXqYYGPIY7d2hZVTdaLldGkKqbXJe45m+V0+Ehn9/7/dDaHSCIxG6igZH
	 UJZQ2W7KxScydOQmQ+NLwtmAFCtcLXAzpu3/MiMJX30ndsGabKQ+fIiJxzPZ+gLuMmk7s
	 SDt81qf1h/l34swUllbKtvab63V6QVfHSqd7ztsFdEQq3ddO4izmK/wXOMM1PijmSuXud
	 Rv/7+X927a64LywO0HRAA23aWwRB9eUqjI7T2ajtEfU1ni6ofvT2FC+9d2FOjIwLzuaoA
	 ULMw94hExVa8Yg7cKvngN54YfrTxRv9VV+9AaDguEGkzBXBMBOTIlaydyWk7PHzuuoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Hx/ir9n6/52Xt0z/1r5+TdJ8onrgSGbL4t23XE1gKw=;
	b=vwy6nQ8gSVZ//drkdwutc3jHfeOLjzi/6euEeT0IhYTKBc6racijNFmBL7w0SMzjA6RU
	 EkwB9mk68rdwrhtQwvIxn0RemBC3loG5VSslFIA2mtL5+W+tKCtRAz59O513Fxa+TXYHr
	 OZAcioeWQiP/U5du6hR3ERWX9KqYB49+pX3dF3vjh4wfjHhPdrxr3wCrcR3Kvwr/es62K
	 2sXkVAP3yVQkGcrO7WpQWXD4FR2r8zZXUHRcSgnRTWBs76jT+ZSOlTi9UaF9uVdgiKh6r
	 2trbl+e8KINoW6JLOXlGnpKp/rObwjIMW3pO1/lmID+qk5rTmnouEITzC+dn+Xq6AFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s4LV6iJe;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA5606A322
	for <linux-ide@vger.kernel.org>; Mon,  9 Nov 2026 06:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EA5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s4LV6iJe
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1292508eec.0
        for <linux-ide@vger.kernel.org>; Sun, 08 Nov 2026 22:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204438; x=1794809238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Hx/ir9n6/52Xt0z/1r5+TdJ8onrgSGbL4t23XE1gKw=;
        b=s4LV6iJeGf04TyVRnrUEBWfq2NfS9J/UPf/nstbpSmtfW9dsoCj7dYG8cGieq76olq
         UBtxibZRLZrEuyGSej3GSuuaVUDOSYpPgS2pomNyS3E9CepOAEmykyVbAqV/aRRN2vr2
         OAbW3tUkonU/C5o6XhDWkmXqoREh3n7FoqbmKnrQjPL/dGQxW+06hFz83bmpyoSYfx9A
         0H876bNxiOT4xg/6Lk5ZrNkKouz1xfDaEdWhGUVbNbMTdTYKgG5WfxaoBtywj83hapHr
         +LAJ+6FQ1coQX7H2J6cvfrngNV5CcpQMCIF/onOlrAHOGZBR15M1OgrqT06rr5ZQEQ4u
         MuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204438; x=1794809238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Hx/ir9n6/52Xt0z/1r5+TdJ8onrgSGbL4t23XE1gKw=;
        b=oCgaWmU2HnrT5mgSAFhWHrzkhOnZ7m4kzfAoLe4xlDCFn5ia/XUzAu29yXUCrgZ8hp
         lPcYfS+0swi6QMXzVWQAodQynpUhg6zgqe6Rx9XCiDZzcYnL5A6hVlaBkG7FxmocO6kO
         +T5FYUmi9Aicxv5qNjvYJlgqgHqAe6Bxzh/plhrHwSs+VGsCbrBDASxoceKUzt0Lo7/L
         t9KfhAMjuZWNtBZzSjN16SfZYHepxReupwlsckn3bUzdg03hX+RLXHydVgtv8xjGkW8n
         3aHVz7UxmktrNpWhNlVaAP8Y+SB7Oi8Leyr71NuEsPy4ZXqmLIuSPj5tDYpfZgIitONQ
         A3JQ==
X-Forwarded-Encrypted: i=1; AL+hErH/rWuyDKotc08xh2pvEv1sUVxPdO5QmC3U6Rxu9u5iZy/misPg7chz+CEZHu4bb62fHHR81ad8H+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zuubJdHVJlXjegN7wXsXK2pZyhR5zkdACDTV2lVQEqjcowSEE
	e2Br0g3Tt83pTgbXBEc1eVbxDF0R0cTkyf618rzj4luQ6ghhifcLm/c8
X-Gm-Gg: AYBFou28Jy8/jTVlL9BQQ7U2/hZ6mLz9ViCcDVe6/FdatqRbKDkQLXAKT5YhfbhvXzj
	xh5igiMF61vFd3pQyxXw3OWiX+WaBQD6ZRk0CBmmuhqB9meEPriknuGsXRVe2Sz5UmYD3htJAed
	HfN6AZiYiLNp6bFFpW6y46u/bmsjTIs61pMiV3SaWZtmJAIg8OV5pGOxGN9vLNq+/cMFK4UocTF
	A0qW89oOSEBPHh2xZc26988shI9BlMAhiKQ6UhzgTajr8kt09hD1NbJsDpm9aHWkROLHJPsozee
	wjBun644zHH5bKudo7qYhhNxfgKKNwSSTnFQhgVU+mFCksFjj+S7cH3MusQkiWtUvtn1dR4O3Je
	eiIBeVQJJ44vZ3l+JbhiwD+VdNKsI4J1RvXVZgyEFWOlGDJ+YL9BbroHT8nUkHv+5zefIGAv+S9
	+++XXlqZEkHJ0vmgTUL7Fatn+jetl3362Xk9s9dq/nJEcfsbVBjw+HTZn5h2AK62QSrR+i+08fp
	LlHLylMpTTs+tOEVeL8QwibiGULUSqyyqD/NsHsIuvXmjStJwfA3u+6BgySzlUCkLD3U1/zcUyJ
	AQh4V032UaqECHtAVtsI8a+h+TAmNTv1/Bchi/cMhrTmf+xXSBclBazI/rZBgHkXQYdeqw==
X-Received: by 2002:a05:693c:6203:b0:369:ff7d:840 with SMTP id 5a478bee46e88-3725e142d96mr8228165eec.21.1794204437459;
        Sun, 08 Nov 2026 22:07:17 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a16f9csm10728942eec.12.2026.11.08.22.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:07:17 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] ata: libahci: delete the SW activity blink timer on port stop
Date: Mon,  9 Nov 2026 15:07:09 +0900
Message-ID: <20261109060709.1231946-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

The software activity LED support arms a per-EM-port timer (emp->timer,
ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
callback re-arms itself while the LED is blinking. emp->timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer, so when the SW activity LED is
in use and the port is stopped (driver unbind / module unload) while the
blink timer is pending, ahci_sw_activity_blink() runs after
ahci_port_priv has been freed and dereferences the freed ahci_em_priv
(use-after-free).

Shut the timer down in ahci_port_stop() before the port private data is
released; timer_shutdown_sync() also stops the self re-arm. The timers are
only set up (ahci_init_sw_activity()) when ATA_FLAG_SW_ACTIVITY is set, so
gate on that flag and skip slots whose timer was never initialised --
timer_shutdown_sync() on an uninitialised timer trips the debug-object and
lockdep checks. Sweep all EM_MAX_SLOTS em_priv slots rather than the
current links, so a detached Port Multiplier's fan-out timer is not missed.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5e4172..3f6844acb413 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,32 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
 	int rc;
 
+	/*
+	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
+	 * path and re-arms itself, and the ahci_em_priv it lives in is part of
+	 * the devm-allocated ahci_port_priv; shut it down before that is freed
+	 * or it can fire against freed memory.  Only slots whose timer was set
+	 * up by ahci_init_sw_activity() may be touched -- timer_shutdown_sync()
+	 * on a never-initialised timer trips the debug-object/lockdep checks --
+	 * and all EM_MAX_SLOTS slots are swept, not just the current links, so a
+	 * detached Port Multiplier's fan-out timer is not missed.
+	 * timer_shutdown_sync() also stops the self re-arm.
+	 */
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
+		int i;
+
+		for (i = 0; i < EM_MAX_SLOTS; i++) {
+			struct ahci_em_priv *emp = &pp->em_priv[i];
+
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

