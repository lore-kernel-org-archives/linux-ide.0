Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039369;
	b=zoAXKKVinc0NId3fV+FmjvbfcoUruuQX4jQBMTEJgTBK8bL+T4qKtNNDdgSTIsRU2HnZ
	 VOpY3PMT353uewyTQtQV6oQycBoVgwKXEDjO4Th4kRVBh6ykrxnZ+ZAyCvItF3LzEb40g
	 H0PTzAMf1thaofDeBlG++8DnE0MeQDm2TnG9QhWHZOZ9TwBjVlVtPAZ6wwxxYOH9U6ONO
	 S/fmSIqPTGVJxoTUOZYmYMgJVccIAjsgsvh09J8xlx0HO//qV1qOE8ULgBqVxpgFLwBdH
	 e33JMqPrtoIhBDCB+R2RrAhHdt//9YoGq0unKfw2TTywugxWdECqAEHXJxz16fwqcSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039369;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
	b=BL0tnAbEBzxJ+TxLRvsvdcTv3IHAPoa0OUNaXArpEtlMeTWwE3uDR1tCK1lhlgAs18KK
	 +zSRZPa19/vigqZkL0DpcOcvx+N/X9dGiZ3HNBQRBwPsslWcpLyCObkKeg6vBfXRsNuWX
	 PvLIdmjPZEB6x3VZ6Oqhl9QSD6MggdykAELTRbELIm0zSeV52Rfos0810dO4y6Vhlt3fu
	 MWF4KU/4Qn+kF+2NDI3xtOL86uJ3rLu3HVgt1jA14cGDBumqFRwViCXYwrEHyr1N5vihQ
	 ZKnyjT88WPsplj+IZdQyjpf8EH0LAcSrwpiOluMVBvuo9eSS0dIHqyjpP1V/eVXuPjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NrdJqHUm;
	arc=none smtp.remote-ip=74.125.82.226
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A011606A31D
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A011606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NrdJqHUm
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-3535a54bed9so5126645eec.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039367; x=1793644167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=VJG5z8TaVv7a2LZVRK2HiBh/1E1vuVdMGmgHzj4YN9PbGPZHLPi8J+zBSBnSgIaa61
         sG9iKMJx8Q+ZxmBK8iARRSdpYdMVZrE5k8Z4btdt9BeOfqh1FQfGg5pbxyPt7T1S1djw
         cz6f7wG5kFzWaeLQ07KwJnHEeFxGRRQvg8qUmdGcpgFj6sr44l1TTmKPl3R8Vtws3pt+
         WzfrraemlS3+TQcMRl/XpMmONzG4Q+k4CWFgGjA/ilR1mNaLUTO1myEbCOIkQlFt/ox8
         8DiP8bpWYF5Z/NtqrS2LQ/vgltxOjNj41lZbzSs2xttJLLDu31NJNzTKMo/pMBX813QP
         +3Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxcRJ/ZCpSVn67V8f+P2EoJEGjvCEahV/XA9w/uSu/kTD4CljeUzVFlVOfqDlj7ikwFGJ1p+xpNG80=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHf7PIsB//FTv4CW9/FqQyTq7eU0ek0vuq7aXNXcJw1yFRWo4m
	LScA8zYLC+l9+vW5DSWujLsczQPE7yu2UakRzHWo4ee2ulX6myzvAh0n2wwoIr2FY2mlmfovIyN
	Q6J2dtwvWkzlxK0ENIgrc32nrFjTLPc8KwxSuUkX6VllXd38tTQie/hcxRe4inrUp8SeZuewXJX
	NDDte5oglNY0XHp8TJvsRKCiY74JtdSHvZ6sNmZtOLGVeUZNh4XdSKTf7XBb3Zm8yybu8K3227/
	EWfGh8aAunQpSN4/PKi4v8=
X-Gm-Gg: AYBFou2PnJAi+Dnu1OYjfl+8HEmrTOYtMMvLYntzwjRZfCyI7OCjFoKjfCD9gJpz2jj
	WvtddD9qC8pgY51vsacvkbTfRNdImjeC0dXhkW0We/yGq2TccAiblRH68O9hfCCYG+zbGktYC+Z
	smsGDntR1xLAZ12iOAiLJJFfVGytqU62QM4L8beXaQ/LWaLZkhtdb8wAmDQRYKyheTRb+fcunW0
	5C7SkUoJYsHR6JXST0yGu4u9HlOlr0JzAF8jKbF/rAz3K/tyYLEdNb04SiQ2DpERYz5NvdByODc
	c7v9/EpBKsfucjFLUSynNxznyyg4WC7yN5oqgM4QzlyShyMab18QIfE2Fa98sMOLdI61nPBUB7B
	sY0hsNIlTBRP9L1HZZB6+c5d0jusoOmWwLUx+h/KaFsu6Z+qAM740Gj2QtLfMku9q3iHpYmpNi4
	vfhA2kmZsuoG6Wkn44TyWAzs0zl3eCmolwBqsEatGC094=
X-Received: by 2002:a05:7300:88:b0:367:3d68:8480 with SMTP id 5a478bee46e88-369e81ca340mr12000354eec.0.1793039367354;
        Mon, 26 Oct 2026 11:29:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-369ef8a0538sm60205eec.22.2026.10.26.11.29.26
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so9419338eec.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039365; x=1793644165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaqGunwSleeDLPx2z6NkDc6zUunPgMcaEWPlGCr1dr4=;
        b=NrdJqHUm350MLdrMsPBipFdOudEhxlwhjdFscE+PcsUJ7vtNvqiU5npnzYfdWYJl0v
         XKoZa/oL0QkAitD9k45Y+zVS/LQTGS2gmxxiLRSpwoQMqrWq9i7OOASCjITO6LrnrJ6/
         6TAqbM+rcWIVordiufiCxWgdWjD5+6cdXfcBc=
X-Forwarded-Encrypted: i=1; AKwUvBxXcC48QT5j9tZJ88FlZjYtEbjnr4Xsq+uzBr7boIf3Dxcmh4y++vSHBKmocWv8fPCPdX0SzkLIktM=@vger.kernel.org
X-Received: by 2002:a05:693c:80cd:b0:34c:fb30:3e30 with SMTP id 5a478bee46e88-369e842cbf2mr12303459eec.7.1793039365316;
        Mon, 26 Oct 2026 11:29:25 -0700 (PDT)
X-Received: by 2002:a05:693c:80cd:b0:34c:fb30:3e30 with SMTP id 5a478bee46e88-369e842cbf2mr12303426eec.7.1793039364706;
        Mon, 26 Oct 2026 11:29:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:24 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v2 1/6] phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
Date: Mon, 26 Oct 2026 11:28:51 -0700
Message-ID: <20261026182856.3168686-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
References: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Northstar Plus has one PCB register aperture for both SATA ports. Its
per-port OOB settings use separate banks, while the PLL registers are
shared.

The 40nm MDIO refactor made all non-40nm platforms use a 0x1000 per-port
stride. NSP previously passed the shared base directly to the helpers.
For port 1, the new stride moves the bank selector from 0x1804033c to
0x1804133c in the AHCI register window, outside the PHY resource, and
prevents the second PHY from being initialized correctly.

Exclude NSP from the per-port aperture offset in both read and write
helpers, preserving its existing bank selection.

Fixes: 0ed41b33882c ("phy: brcm-sata: Correct MDIO operations for 40nm platforms")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index fb69e21a0292..b5fb9dff1ae9 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -215,9 +215,10 @@ static void brcm_sata_phy_wr(struct brcm_sata_port *port, u32 bank,
 	void __iomem *pcb_base = priv->phy_base;
 	u32 tmp;
 
+	/* NSP has one shared PCB window; its per-port OOB banks are selected below. */
 	if (priv->version == BRCM_SATA_PHY_STB_40NM)
 		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
-	else
+	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
 		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
 
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
@@ -233,7 +234,7 @@ static u32 brcm_sata_phy_rd(struct brcm_sata_port *port, u32 bank, u32 ofs)
 
 	if (priv->version == BRCM_SATA_PHY_STB_40NM)
 		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
-	else
+	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
 		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
 
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
-- 
2.53.0

