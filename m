Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1A3672B8
	for <linux-ide@vger.kernel.org>; Sat, 10 Oct 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648996; cv=none; b=LeUW7GyvTRTAjBKOgIPLmBbmM77iVr7pQaa2zwXd9OsHUL7m1yVA0LhbXes7rw/hsecFpbfvVR8d4E4kN+JiWp3AjX6qnFq99gTKJOPMYIgfbtw1MrPAf+KteQPrtPn0KEfs9qcHuX/D9osZubc4KYhT0S4Suv4MceSNARjIGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648996; c=relaxed/simple;
	bh=yxoxZmGSqvIPcrImakjIUGsaLNToxRhFjaiZF8tsmR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Awebje6iaGHN/4VXWngDmu6HuKNf3AVShz5sNuYAALmwmWaLKEL2GgLQmlITYoicAW6hlgyy24Xs7CTxPtuvN73t1EOY3h5yfMetg62Vk3u1vyWjhMQnKodBy1fVCApaGtTw3oMhvsP7kIW3vEAlA2ylq0C21bAUoo2miMlwmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTCiOfOB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTCiOfOB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e5e801487so126011566b.3
        for <linux-ide@vger.kernel.org>; Sat, 10 Oct 2026 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791648993; x=1792253793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YS2hvS/618HryJMsQ1ZZ9gBCMap6EYSMZfX0Cp5Lf/E=;
        b=NTCiOfOBbsqZZD5EzbAm63PDdRwav5FEMpUyhaNXF1AboZ4V0/Pd31DECTlqs3A0Co
         cJuVyVsY7Tfn+eXBD70llnNGZ+iALDV60UXOhSNM0iYtKS15ZnHYIatAhHyvqUHWncJv
         GTq9PArusJooVeYyAjB+Qkd1JkUVzVFZZcHLkObO27zV5ZtEyeRKy9DzdKR+rDQAWYRN
         Dz3QAewxxXfv+aHfZezTvdAe6JtSCqzioWGL4ZOMXRyPtzNXb6WVXJIFbCHEumuaH7Uv
         eVfhmqQ47b/14DldYQpSovrQBp3TrJc/fE/t2UOlDnAKZAjWeIX1lmyQWNKTapZTwCJ/
         46Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791648993; x=1792253793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YS2hvS/618HryJMsQ1ZZ9gBCMap6EYSMZfX0Cp5Lf/E=;
        b=zFcgbO+MGyTx9V2SH3MsLnKb6o3aYf4UokxkgcKuK9XcVJElC98p6eBgLuO9YOQPC7
         cXsbyQkmIGM/jfKx/x7s6uwZmlO/awaGiNDNU1dv8JCiEXCGCbiCFsQv9eo8ysiQSPkn
         kAoOma1HjeqfjdJqba9pAJgNfL8dacq1cS3bFOQoy4R5dNfCMomR1oOSbUCbbv6TZ2Ap
         m/9ZnDxYtJugKTL3Hcq8uyCNs4hcmQx328pgTs3IwQmaRnqH7JVzNxmupONq1DiXFiuJ
         PCwzs4LZSl3OPS1R4uLX3/ILt2XA8Kj1GFJvGGvl1o+AKEynYcKeBkBXoWMowb3ym3fd
         dNhw==
X-Gm-Message-State: AFq9FYKJMeit8nYfy1WGCuhT26/nw/fRaqZAKtic3wY77o4/Wz27fueH
	zB03jg2PeJfJBrBupUsOWm2p2YNVAqsDNWDIBQDQWrD7MmFzTGNb6L+zn7FRnmjdy8M=
X-Gm-Gg: AYBFou0j0Osq9VC1AwfP32mhBlE0YeGp5d3AAEzfq9DVrgTkpdCthpQXOVyHL/BqDgD
	Gjp+g2UowvfDTLf38x7Wsk7jWL+gYnXpvpk+qD5g0I4B4yn4MBLej/XqT1AdAfjvUWkGuxUnyE6
	f2HLf9cX8go3wmaqdyRrr4KxZZN2vP6T3xu72Is18vpSre6h5t8cjPwWdg/3szOoJD++0AMsxJ3
	5khgSstWtkzjjOj7JuuXRcwHJmoUeOxg1nyrd44BBT9DgWqP8x1mup5fAXMCRRds7kSA5//d+NJ
	inSpMleQyX4F/ZYtvFIdY3L4d5JYU99AzrugAWAjMiTNnUuil1N4vaYe1b0gdLOPBepEIMXpv10
	oq/7WeEpL5HhMznJkobpsthQ96UpykQQmpRwgBMwUa4CoEfpGj8gRfPxCiANcUV/VvklqZzhtT7
	YvjQ06VaEwiXwtefZiW9UxT2cwHi7Jcltpo4s8q7nDMWHZV6jHq1IYjlGqtW9HnIEjDEJQTxYX8
	EC8z8ZRaeizF76MB97Uhuy00vt0qVFPpDzmNwFMnWNrAzA=
X-Received: by 2002:a17:907:97c8:b0:c2e:4de1:956f with SMTP id a640c23a62f3a-c31aa0c34b6mr528057166b.43.1791648993023;
        Sat, 10 Oct 2026 09:16:33 -0700 (PDT)
Received: from localhost.localdomain (87-205-122-125.dynamic.inetia.pl. [87.205.122.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a7b988sm263929866b.46.2026.10.10.09.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:16:32 -0700 (PDT)
From: illofspeed <illofspeed@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ata: libahci: re-enable FBS after error handling on a port multiplier
Date: Sat, 10 Oct 2026 18:16:30 +0200
Message-ID: <20261010161630.431-1-illofspeed@gmail.com>
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
Signed-off-by: illofspeed <illofspeed@gmail.com>
---

Notes:
    v2: no code changes. The only change is my author address: v1 went out on
    2026-10-10 from my previous address. Please apply this version instead of v1.
    
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

