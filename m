Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160920;
	b=ViaG1/ihMapm1Wx6kif0iduCU3PBrky8y3REkfA8/bvUFbEeGa90Oxcwvk9T9vkDhR49
	 0hb8a8pt0IJfHNo1gzCLC8tFUfMCBZGQdi1IgFw8j0LRoxzhq9zKYnJfqoWQOklaYBZa5
	 kjoGz2z9x+7L1AoY9IsxvHsamp1g7430iOcFSqwGaHM35FQ0LuDEVFb6klAmGtrUAVflV
	 2+JNCt/jNn1mwEBliLilLsaTUJoLQ6+MV6Q8gx3GXOqccWR5DIWcy6f7KKBheKEy7OVZy
	 8cFUNRpeI3Ek/6f1bw3ba0wbzSzwI4yqE8h6brRZfo//pRzrbhAor+ehWCGGoVlAcMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
	b=oDBm66wUbJQlO7BjaOagtmy6MFXgrMpBZKI0gn704bsNxGSiQZoLlJIcB/++sFVffAjj
	 GbLSZhjr+GJiUx2UDv4TlH/gQW4+//jXLlPWmytWpgwd4ptg7njoCrFZTE9+76wVxFFbU
	 F02vqowLBeBjk8eGcwj5ESgjU8GNnwzbcOKbV+48VUT7Phk5v1VJjvbsjuX9FUX6X6YON
	 JnK18HC2/V642VEqkCDh/+jprA7qZJqEsU2Cyl6/o5zXn7YTrTMxVCIojfhBlL0WHwYrR
	 hqu4NsfxIUy0Og2jDcDiMJJL+VdKv8Tl5oaRlzeZPNCDvDEssSJvlM3IwA+8Euv4yKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ctrdQGuK;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8836606A31C
	for <linux-ide@vger.kernel.org>; Sun,  8 Nov 2026 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8836606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ctrdQGuK
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so413965eec.0
        for <linux-ide@vger.kernel.org>; Sun, 08 Nov 2026 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794160919; x=1794765719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
        b=ctrdQGuKBIDYxv+Pr5fuEd9lWvvp/+ykFKPPW6jyc51ty42U/81eMwrhyGbHajr0pB
         /ECkIFQr2fzCw8v2m/8Pv8MGfPc25QEQUpZtGgfdzsdLKukCpoj83UjukbPrdjOS6Fs7
         GvJsgbS6fNHA20ITNDawIdpcFbAYmXdDUwpbSCez3CeRPaXBZP2pAKyBGIDK7QoQ5uHM
         XSWTh9qXlTSFjpsUjoDuLvi02LjObwJ0vwHN6ZlpH4fSZlA3Y1V7yWSvkq6clZzgok/l
         Wcq8YUgg8Fk2Nt6SxJJ3KA5Q+nNc+dWTVXkKrtEGlMeey95GAYFtcRfZrxRoXlISLJRe
         zzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794160919; x=1794765719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AryQU7CqG24/r+NiOYec3B/lZ+GdRJNknAEAX2AGwNI=;
        b=CCQLFLg26B3H/QydYDjU/W5/53qrjz87faP2q07lDzVZK/Iqppbx/jcdS4/AsycnI0
         TxOOixQlRTPrKy/PDlvlr07ktHwkplziGPxTw6UASFa6qGziuGEN6occTmsT7V4hN3pi
         JYMEKE0LcFHeArTta+Q5qQJPbmiht9Lgp8FEwZ7myqkAHjBe6ogx+NTufCdj+6zm0KGQ
         SMdwmLOyrkfxnAeC4F7VsogC7ZYH7EHrrL0OIMLjPKMNiKX4xjifypQDTvG3lhYDDc1x
         xM7ggQzZ25kPsozI11uKzQRNe0oO4srcs1UE0zXc/PrUjz1cHNqohAGRALml1SmX23tg
         f48w==
X-Gm-Message-State: APuU4Z/TBzuIP+VVd9wxRuwWGu62uxnr4SymuQwcp0Z7NRmX0+ecqLX6
	czrdu+axIhwxd7CMx1ANm+sNNnCzJKwmXPEsdaDdzXTMXr3Jx4Uo+5Ip
X-Gm-Gg: AYBFou3SP6eVtQ3RXo+mpb4ISLup8n943bxl3Nh4CNfQHASQIwAXzDXVpc+ZGd0uvdJ
	MFAoSJel/wWt2qNeuX9db3f4Brnsrb9CCflBolDFLqp723RBxIpgYcANQ4gnatWR/sGltoStn8l
	/f9CKKeuyuCO+jNnG4a3gXIEn5xNlcA6zYcMGuPLoJ35zwcmRHWlpOYtYoODZFeFUMi/1AbBFLT
	aDMhTyi20bWgyQ0BGQ01eyy/OKtjGLH2WwpXm0V9LW0Etz+evGeGKL5adiZXf8Pxa7rZlXW/7Ob
	QLQm7wstW0yuJUMiYVDtFyOgIH0dZ9+2IROEjmQdb1egRZUmrh6ckFK6fzys9c3wChGx/ebioY6
	id4VwmZsVqrAazhyLWY9uS1T8CYXkIfa0oVMsHnatrOXa80rU14YENCMzNi5L7x4kLrmL3YYbl8
	xvsPiKWTR1VbjBSFaHG0ZYxmC8Y2rTe2DTQ1ZIbTlR68I/Zyjk3y6hVs4NZnU8rZsPtRGz5C3lZ
	rAJRZEs0KlBUdztuQUC3CuhdoVuXaVw1jqoj0cO0j1CIcKgz98JBQ0+3VkoxAp6x5zdkf3CSflF
	qgdKjLRjEMuuquvGUr+FWwHyXHa0QCLN9iIpjhwdq3n36UHuYpwoGY5qJuLJlrdQyDSOZw==
X-Received: by 2002:a05:7300:c3a5:b0:373:5561:8d06 with SMTP id 5a478bee46e88-37355618d75mr936629eec.37.1794160918896;
        Sun, 08 Nov 2026 10:01:58 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm7072856eec.26.2026.11.08.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:01:57 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ata: libahci: delete the SW activity blink timer on port stop
Date: Mon,  9 Nov 2026 03:01:34 +0900
Message-ID: <20261108180134.734111-1-hj351016@gmail.com>
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
callback re-arms itself while the LED is blinking. The timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer - nothing in libahci does - so
when the SW activity LED is in use and the AHCI port is stopped (driver
unbind / module unload) while the blink timer is still pending,
ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
dereferences the freed ahci_em_priv (use-after-free).

Shut the timer down in ahci_port_stop() for every link's em_priv before
the port private data is released. Because the callback re-arms itself,
use timer_shutdown_sync() so a concurrent re-arm cannot resurrect it.
em_priv entries without an armed timer are zero-initialised, for which
timer_shutdown_sync() is a no-op.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 365cfa1ed5a3 ("ahci: Move generic code into libahci")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/ata/libahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5..873645c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,23 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
+	struct ata_link *link;
+	struct ahci_em_priv *emp;
 	int rc;
 
+	/*
+	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
+	 * path and re-arms itself; shut it down before the devm-allocated
+	 * ahci_port_priv it lives in is freed, or it can fire against freed
+	 * memory.  timer_shutdown_sync() also stops the self re-arm.
+	 */
+	ata_for_each_link(link, ap, EDGE) {
+		emp = &pp->em_priv[link->pmp];
+		timer_shutdown_sync(&emp->timer);
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
-- 
2.43.0

