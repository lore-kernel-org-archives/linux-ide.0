Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307851;
	b=x2LvKbldobqFH64iswZJpWfibKtIW5848EpOuTImb6te7kK6UVVBy5S0Du2mRmfmGkbw
	 dGKEmBZxaLLVn1OPHpq5CgN7xUa2ayM3ZAjEyvo6bRhZ80/DybYy5gjvD21BQDf0jbUhJ
	 noWCoJdPMcIiax35d0u91z3Ow7mCyyjNfav59oOLjJzI728uGNfxozXpdNd79befTTIjy
	 Rhl6fWhhJmt7FK8HA1zo8iOD28FpcySsFIqx4ha5tp/e6X37GWgOro9cZDhUG4tMwZ43q
	 KfY3sdXy2TGHt0wOsdmvFRm7Hb+HkxWC7o9DRNcXk99oYlgVyAWvkfQAwKP3/LP8H5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
	b=Cwx5YdMyn/6QJdlKBsaGYxb78GidwFJYoRZSqB/Xujq+flr7gzEhYBVPb6C/h41g+WBQ
	 QmrAuxpxWAvEK7+0rdMsUmFY5cJaFjXFyvdVrFZLRb0yIIFBPhOeUCAAJ1Fpi1/DN7vfY
	 3IWQBZVhUkoCMSyEzH4NoWSz+N5i0veTl3fJdBrtgrXR20FTZgVEAVfPMrY21vcbdZIWh
	 HaY9z6dCaCZmJkrY/zjckJl12fYiKm3mwY02nL7OOyC2w4RS9qji3F1t8Y5UEFDZsIWPm
	 1fH38Kqg3kGeeFQna7IlmmF72wsxVc7CMjL0wpxuLp9pBLTUy+jBXEA8i97v5Mh9MHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7oOBOLJ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99DF606A32A
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 10:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E99DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7oOBOLJ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so1676609c88.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307850; x=1794912650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
        b=S7oOBOLJgkm5j3tpXKpiwJK8P5y+iQiS8q2DMIqq1hbNqUzm3Dk9Nt3P44CdaCrFnC
         NP1lvXmBMlAZLOlnIfUtw/GDGqi+w1LuNye8okF2f3p0ztePm1n0Pwhdry4x7bQ5Qk+k
         L/mhIwUJT75aXGy9Cr82QMvFE7QF9OzoYoCmNt1uqiJ/VtTHPbqHCYey1HDMra8+WsKY
         UTT9n9segkNKlcyfDUmqglN0a3BdUI3nlcSbj2+zZqkBoF+pZ+kXkeGvqIFaqOyoFaQZ
         rMQlfgtW9dZc07qCWSy+dKhp138PASsfNg8ulKkUOytLlUrqKw6VzftrgIOyvWwqE2Bu
         2HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307850; x=1794912650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnDWGbanVCtYqiunIfMsBWStugmAURIRo8wUmU6j1tA=;
        b=tMEBzn7UutJBvQFeUtEeK/dQ9PZnNs+V0Sbgmg3gZjlzRS4HE47oTjjdl026LCIFNy
         P3tmi0w3ZLBPsznQtAnEhVI6u4wVZsHDS0ZMMyTblNziPE6qhlIlrUqUEKBk7G9nZ3R8
         NXve1KfiOVjV8YvPVj5r+mKzQ6PjvZJ5vvt0YEvwTf6knofUPYKMZTgI7lD3ewORNJI+
         H6a60pc7mkEc6to94/nrPKIMohSzS31nFb2AA2mb2CJ+uqvS0mcUCElv26c4E4dO3wJ1
         bEAfh2e30tl1XqREO3IpzR7XQ6gKGd+ZSMU0u7OCXsfRFWzes6tZZuOCAG3qORJUpTI/
         ZyEw==
X-Gm-Message-State: APuU4Z+dwl6nz4sAQCzplCoXCluzKRDvsuypNiPt85wFd/gUFzfdy9ek
	GQvieOtBrQueiw9v2AmguPBj0JCr8gHyoV/0+9rwHG05U4IjFb4nKX17
X-Gm-Gg: AYBFou1xk70/HQ65mvcDuIxesKRnYB0otSCBEMwaJ9/OLNggMh+8BXgjAya6X/QNjkS
	XALM5NAeb1qabgc0XmUAebf5Xulwntz5S6NWlsSh15HVo1VyE+g3TNaBnsOUcMhKVQ7JP4rOq1g
	M/0Sd7nFR6BrVcE4xjK0Q6uFOBl7emzrDRxeLamJjR2hXluLfkIeex5DE+0QqhVRj+6HmVdswgE
	oFj2iEGpQuxCDUqVlDyFh0a0j3Iv1n1LlNJm1JmZZGMz08Ly5e6KFO20rR3sa4WhZjVhCKKHszW
	BtxuoWlFoNPl/RVg1LpF1WTPCAqvQuHCtLHhAEpb4w0P2XDK9T3fLhPTTxDMKacig94DsM22LmM
	F5hYBu7gMpGQz5YEqNQHqMbR4AwpyH+6DWz3TWbKsvNcKwDplt5HbOXwnrBabSTeUTWmUtPA3gP
	ZVU6JxyJMChSxYGqA0PTeeuoQZRSojZMXqRrMu4MXnxKglPzb9s6jqIqhkFTXa/YfQP6fJnit3O
	C3Eq/1bNH5iRe7evGd3pdkIH2Z7qnWKC9SmWGuw0knnHcgDErNQk37+dZXs3ASEH70sOVva/rQ6
	QT4cjEtQfljD+8xFTRinb4YcKyc2kN5hSWQxcOOcgcmoF6ULTp0CJDZXYvRzaHr9KI9ORw==
X-Received: by 2002:a05:701a:815a:20b0:190:b2de:1549 with SMTP id a92af1059eb24-1b3b5e6524dmr3147999c88.1.1794307849889;
        Tue, 10 Nov 2026 02:50:49 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm7899356c88.11.2026.11.10.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:50:49 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v4] ata: libahci: delete the SW activity blink timer on port stop
Date: Tue, 10 Nov 2026 19:50:40 +0900
Message-ID: <20261110105040.2483806-1-hj351016@gmail.com>
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
released. Iterate every em_priv slot and skip the ones that
ahci_init_sw_activity() never set up (emp->timer.function is NULL), so a
timer armed on a fan-out link whose port multiplier was detached before
port stop is not missed. Because the callback re-arms itself, use
timer_shutdown_sync() so a concurrent re-arm cannot resurrect it.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v4:
- Iterate all pp->em_priv[] slots instead of the current links, so a blink
  timer armed on a fan-out link whose PMP was detached before port stop
  (e.g. by sata_pmp_detach() on failed EH recovery) is still shut down
  (Sashiko AI review). This drops the now-redundant ATA_FLAG_SW_ACTIVITY
  gate, since the emp->timer.function check already skips unset-up slots.
- Correct the Fixes tag to the commit that introduced emp->timer
  (Sashiko AI review).

Changes in v3:
- Shorten the code comment (Niklas Cassel).

Changes in v2:
- Gate the shutdown loop and skip em_priv slots whose timer was never set
  up (Sashiko AI review); superseded by the all-slots iteration in v4.

v3: https://lore.kernel.org/linux-ide/20261110090303.2415681-1-hj351016@gmail.com/

 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..6d73c7f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,8 +2605,23 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ahci_em_priv *emp;
 	int rc;
+	int i;
+
+	/*
+	 * Stop the SW activity blink timers before devres frees pp, skipping
+	 * the slots that ahci_init_sw_activity() never set up.  Iterate all
+	 * em_priv slots rather than the current links, so a timer armed on a
+	 * fan-out link whose PMP was detached before port stop is not missed.
+	 */
+	for (i = 0; i < EM_MAX_SLOTS; i++) {
+		emp = &pp->em_priv[i];
+		if (emp->timer.function)
+			timer_shutdown_sync(&emp->timer);
+	}

 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
--
2.43.0
