Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068E361974
	for <linux-ide@vger.kernel.org>; Thu, 15 Oct 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093789; cv=none; b=rx69XD2uKOoqHJ2r/RI0CN2fbcVh48+EtjTmZgwaBpwKGzy6nMk309TjGN7HeMxudjtgwxbYtu0fwcmW42Y9ppnLx5WUus4/NcUUl0B+ERjS7v9tQ0sRoLWBY6F3zc2gcAUPruXlmC2TotRHw0PVV1ho5827lYqD+uAEuXCwphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093789; c=relaxed/simple;
	bh=lt0aaY5L6+HzuSlLyKVL+nE1UrL+fC+kf8+i1evj5BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ta9752XHtEMnoWMRzJQzo6Vi7a7+PNTh/Qb/Yh97+hFOP+mQPqI68K5uUEiby3Hjwl3Rxue+Rol8J0ubVDt8c9fA05LRlKlwQ0UMVuHFloQGuU8iFJLQ060/uAi/zgYJfuLIa8Tm/sz3pjh7kIx19eCKSvKaR+tTQJAcd8c7B58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idGhZESb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idGhZESb"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2293880a12.0
        for <linux-ide@vger.kernel.org>; Thu, 15 Oct 2026 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792093786; x=1792698586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fy8lkGKobQCb50zP/q0nA2f/wP9XA9UQk+HvRGjW/tI=;
        b=idGhZESbXAGCwGYCM1FKqO35bhO18YG1924+dXSVRgOL4ai9mI4/SpXE0p1azI0xi7
         2F3OxAmJPE3+nB6XUpOsjOkrkWkNKVjr/cDaGVr1Esgj+P6huqnYNzR3vyBM7OzITjb7
         Sw28wPFaXRkHP2P1A7RCy3dhc4A2UMWbdprX46FGwyg8MH9TCJL/cmsFLOfhGv8+H4mx
         eTOtyBFPtYB1LABBIjaC6DKpIORdJhsfcQkb3w6RR18DaQUqfD+4k7e5RTGTA8aSaQm0
         aKOoAaeBOa7GaEq5A5enyW3UggGnrqJQAy0b2Me5RJcWQSe9nq/KNOTelPxrhKx8ZkRt
         ZSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792093786; x=1792698586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fy8lkGKobQCb50zP/q0nA2f/wP9XA9UQk+HvRGjW/tI=;
        b=DsZB5I6jBpGr69/HBW0oFnT0eF4chaf5qVSOqGUswbZE8t4cp6qrznNg9uxeBfto8d
         7syF/Vw4geKsRxHc3Dpl21gEUEMOY4NKZBbY5rGqD3Msz7ZVf4myPZpgkrN7FlQxnob5
         rw3pfTq4dd9bBlNDH4F0sJjXc0RxcQ1rAY+ZHh8/nlaIO7h7Z3iN5FUejw0nwyK9CnQm
         TehHt+eB8xtLacVkXMo/gbFZYEMIeg4eGGsFNtH+NqD6yGFRg8hsxqvGA7EH+JYOtLqp
         5ATsCT02yS39D+cPIdtI7Id9OhAcJZYP6yKE54tRHIJHCCQh/KkahoXdPKRkRV/nwl6u
         B33w==
X-Forwarded-Encrypted: i=1; AKwUvBwUSdUbBDDFWQpbVA7e9o+CTYL79Aua7pJjLXE5v8J95mSzL2tE5nrgusvOfl0HZm+dbCQxjAQjzhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmrkRMNYbamnv+gLdLhjFWDZ7HsX52yTuALbFWI/uyjx/ks1jV
	BaawiOESV/YOD3dnjfvesGwwRHGEu4eK3kIDbcVo3c72d+iEc/BClWFw
X-Gm-Gg: AYBFou2wD4rPn8M20bRIjYt8HkM+nAy2vEp7Nz3l2uWJiNgN9mdERhyDXYIOefYEgGM
	2QRrs/jNKEGJajOAu6YogcQsoIJjgiZu/9QY+xayqrEeqKePAItoZ+qvuwRRVn4jtec1D4NJuce
	6a0nx3hHrBPT8rV3GaxcJmPEsbruApj5z0ILEMEOD2YW3w8VEejHprOPFwLFoSXPKX4aHjKSaQR
	mCFpos2avLLl8Wsd1CPVUubHFFI8VJam+LTKIqm176UZDkKhLHIyvEJdwUu4GGzR6gK+oOq38uB
	M+aO3RUDUPTxkHmt9FfWmm5d4d9CvTpVvS7wtENt8ubK0gAuqPfdxO3QJvloqiHNJXLXYpb9rCO
	YxjqEGrLSNxgmR0KDFWz2AY0n5s7Vyw5ppIYANyDCCSNI6E8lOl+xS0pe1lqD//VVWYROq+hGBf
	zWKq2sqca+zLa4dIAT5pa+Hgv+3iSxp9jHESrEeZMxedHdoPr3STL0M6d0bT6JB4Vd/xgOj3tIb
	wTsSEw6M3+/LIlVPo0hB4Dk3OJMRPwo8pXEUhedjYoplkjrTY7hYmo6H1fVgipx8HumaJhZbA==
X-Received: by 2002:a17:907:7294:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c31aa0d3641mr1974240166b.47.1792093786134;
        Thu, 15 Oct 2026 12:49:46 -0700 (PDT)
Received: from DESKTOP-DIIS71I ([5.18.140.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1e9e44sm55521a12.32.2026.10.15.12.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:49:45 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: deeb.rand@confident.ru,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH v2] ata: libata-core: Ignore forced transfer modes the host does not support
Date: Thu, 15 Oct 2026 22:49:35 +0300
Message-ID: <20261015194935.1497-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libata.force parameter can force a transfer mode (pio0-6, mwdma0-4,
udma0-7) for a port or device. ata_force_xfermask() applies it in
ata_do_set_mode() right after ata_dev_xfermask() has limited the device
masks to what the host supports. It replaces those masks with the forced
mode without checking the host masks, so a mode the controller does not
support is passed to the driver's ->set_piomode() or ->set_dmamode().

Several PATA drivers rely on the host masks to keep the mode number in
range when indexing their timing tables. ata_piix, pata_efar,
pata_it8213, pata_oldpiix, pata_radisys and pata_rdc declare ATA_PIO4
and ATA_MWDMA12_ONLY, index a five-entry PIO timing table with
pio_mode - XFER_PIO_0, and index a three-entry needed_pio[] table with
dma_mode - XFER_MW_DMA_0. Booting with libata.force=pio5, pio6, mwdma3
or mwdma4 makes them read past those tables, use the values read as
further indices into the timing table, and write the result to the
controller's timing registers.

Make ata_force_xfermask() skip, with a warning, a forced transfer mode
that is not in the port's PIO, MWDMA or UDMA mask, and keep looking for
an earlier matching libata.force entry, as it already does for entries
that do not apply to the device. With libata.force=pio4,1.0:pio5 on a
PIO4 host, device 1.0 now gets pio4 instead of pio5. Forcing a mode the
host supports still works as before, including a mode that
ata_dev_xfermask() removed for the device or cable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 332673257056 ("libata: implement libata.force module parameter")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---

Notes:
    v2:
    - Skip the unsupported entry and keep searching instead of returning,
      so an earlier matching entry still applies, e.g.
      libata.force=pio4,1.0:pio5 (Sashiko AI review).
    - Rewrite the check and the warning as suggested by Damien.
    - Update the commit message to match.
    v1: https://lore.kernel.org/r/20261014125916.1975-1-rand.sec96@gmail.com

 drivers/ata/libata-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 92233fb25..578071eea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -434,6 +434,7 @@ static void ata_force_link_limits(struct ata_link *link)
  */
 static void ata_force_xfermask(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->link->ap;
 	int devno = dev->link->pmp + dev->devno;
 	int alt_devno = devno;
 	int i;
@@ -458,6 +459,17 @@ static void ata_force_xfermask(struct ata_device *dev)
 
 		ata_unpack_xfermask(fe->param.xfer_mask,
 				    &pio_mask, &mwdma_mask, &udma_mask);
+
+		/* Make sure that the port supports the specified xfer modes. */
+		if (!(pio_mask & ap->pio_mask) &&
+		    !(mwdma_mask & ap->mwdma_mask) &&
+		    !(udma_mask & ap->udma_mask)) {
+			ata_dev_warn(dev,
+				     "FORCE: ignoring unsupported xfer_mask %s\n",
+				     fe->param.name);
+			continue;
+		}
+
 		if (udma_mask)
 			dev->udma_mask = udma_mask;
 		else if (mwdma_mask) {

base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
-- 
2.39.5

