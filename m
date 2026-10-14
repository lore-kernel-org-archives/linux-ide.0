Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0884E80DD
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982771; cv=none; b=sa+UnQm0Q5ASzaG33K14hwqKeVC/Ov5mlPuvIZvwRASHSipfsIxg/0GVNXrC+PVyl9zxlJ6rJGbEwD7Qa8Q6q0MK9ppCpjLLan7aE1t0FpVWz7tvBWlt03IuwnvUUsLuRa04/ehAwiZVf+W2TUq406I6e3O89Hz+F1Pu+ZrK9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982771; c=relaxed/simple;
	bh=hYpWg6LR7aM2r0rm24GBlRLmn7ycEzlqWb9KqXmtfdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKKMd/6wNNznBPD7PL4fTkrUzETZ5wfNfN3dJ6DU1moRrBn8NTQbiJtQ7afaV5Vez6pzeme3hlwaZ/cZwNa0XMnWEaMSIBRa8JdUvsphvE+vBuFk+7BevQSIYo2/i3YzCpZxf+6hRRWG8LxIKFdsQu59p5JFji9LxyGqb2IV1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iujTBTLp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iujTBTLp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cc1ab5f6cso488504285a.0
        for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982763; x=1792587563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYlhwFkUpCVKjfexAmtqqH1N+XVRono8VvtEAovIlYc=;
        b=iujTBTLp7yOiL3CKRxiHYLvhGw2s5yrwlw480MfKxEi0fVkF3CCGDSvBU1CctZi1v4
         ET8O9WcS8R0Mus+l65hr/HKyyFGM/bnXkz18RMuR0hfO/zHR8f3/sIguMI5FdG71yzE0
         CaMgvkoKyP+ROAZxlyxtSCO7BWWYdR3jVBH9zyf+w32j2rnrj5/KJdSX9hHKULZWUn/3
         cVXTnYMzSAJkshxQJGWOdeyKhcfn1u0cfJ1vhQK0h2NGOAbOWbBAO5Vkv6WKYfMa8QlW
         FoF2W+dRI0/BmLHDMJHA7EOXKhJOgog3znIQhrQfLs5zmLDN/Q6+TCfY1KOBzhCxyxIQ
         V5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982763; x=1792587563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYlhwFkUpCVKjfexAmtqqH1N+XVRono8VvtEAovIlYc=;
        b=gTJj+dQ3Wl3IXzf5U5QWTzsnHHY7cVri5zuXQPS2BuX2S89Mm5MF/yibnYnfw3Nryl
         CNN0vkzbOGLcEODov+qDinO30SkN576gJQZUA8mkuImwXgcGJF1S9VhNRNAX6US30w/h
         +++HXJIkwUj/TXEVOG2K296ni99JnQm/eoAhvn793l3yGMyW922FJvtRG/6ZDoNNjugx
         rmo3/qE0mJgTmIsDunK2WdIkIJjgNbOicAw3YsP0U38JVq6lAsU53qwurR3swH8yxRC3
         w+VwK0uBf4dALTmzByPoMerN6NTizWX0zebZkLLNmgqkVGrw7Rf9QA+8ZjRbS6PcRZ9J
         Q8gw==
X-Forwarded-Encrypted: i=1; AKwUvBwdEISPIKOACuTiA4GvYAFYK9HNnnPBzwyAB73kazP35Fg05gBusEdIBo97q/Ew2wah6denmgtrzPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjpQofwU+k7sw1hMm3+kO4HiiNhp8cvD5LTzfsEyxXhzDwfsO0
	wd+OtXlhdRt0LgGe22lmxjehWBC2JhyL4CS/j0UdhAUr93uvusf33ZPh
X-Gm-Gg: AYBFou0sZ2x12J1AXWkRyHvyPRCszXdpX1rCxgAvjUhM8TL6d5UdEykO/xYOSgadc4o
	tuQsTMnPhSVDrtKu4txHdtaFZ9rExY+kt6zWQe/ICzY8TIE9aF9NXKY5m9bNq6Btcm7470nCb6D
	rnaFiVSh38kzSn7Uyz+MxDkC4EBqT/k7FtC2f3V+ShtyWVc2UEYO7/IWq8ZDV5LojDMEkJw65k+
	vhVreaPMddWxE8wMhSWRJsqOhyuv0GYvBFHfy+ASTLHxJ9XcTwH2z/Frvye828jRjfn5aBBSUi1
	SfxbM0NZrLS7Xnm66FODKrDwiqROA3ntWP+RzLnDILeRbqvQo/LpGezQNp9NTWorGQvwtu5+/Zm
	SEXA6QNY3OLajxZKyKskVzz0sz3P0F6N55buVfeZ5xJQnFEUH/ZyAcddy1avh6vDS/ze3NtmJH1
	TfAG3+p2I99smfC2jBalVTj7QXwclNV0n2OJF9+NCE2uL9mdLAJz9pfs44TcD2OrciA/Y03L5rb
	0MXdl7Jpxg8YX6dLI3cGbYpmy4SBXUB5qVa77C2pOqXVkyNNKrLI1fGadEL4By0q4JnJGdPqg==
X-Received: by 2002:a05:620a:44c1:b0:93e:9927:fd34 with SMTP id af79cd13be357-93ebd2244camr2410037485a.28.1791982763407;
        Wed, 14 Oct 2026 05:59:23 -0700 (PDT)
Received: from DESKTOP-DIIS71I ([178.157.168.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5051333sm484825285a.28.2026.10.14.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:59:22 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: deeb.rand@confident.ru,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] ata: libata-core: Ignore forced transfer modes the host does not support
Date: Wed, 14 Oct 2026 15:59:16 +0300
Message-ID: <20261014125916.1975-1-rand.sec96@gmail.com>
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

Make ata_force_xfermask() ignore a forced transfer mode that is not in
the port's PIO, MWDMA or UDMA mask, and warn about it. Forcing a mode the
host supports still works as before, including a mode that
ata_dev_xfermask() removed for the device or cable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 332673257056 ("libata: implement libata.force module parameter")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ata/libata-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 92233fb25..324aaa81c 100644
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
+		/* Never force a transfer mode the host does not support */
+		if ((pio_mask & ~ap->pio_mask) ||
+		    (mwdma_mask & ~ap->mwdma_mask) ||
+		    (udma_mask & ~ap->udma_mask)) {
+			ata_dev_warn(dev,
+				     "FORCE: %s not supported by the host, ignored\n",
+				     fe->param.name);
+			return;
+		}
+
 		if (udma_mask)
 			dev->udma_mask = udma_mask;
 		else if (mwdma_mask) {

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.39.5

