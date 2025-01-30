Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E51E6DCF;
	Thu, 30 Jan 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244159; cv=none; b=dqGyG5+E6H4vJ2h/OJW3gHNUhIZFG/rT5Je5WpKhcfNT05bQ//L/Br/IcldkQBMakjruNILDZEJgdnz2/vXDcpkW7OezqUD/1dLG17l8h/yuEQ96Gr77IU/9Db5Z1jk65h6q0VYOQ7VaQrgVfkMtsoWQz580VFuvYK4LUhvq1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244159; c=relaxed/simple;
	bh=wDMRkZ7Yz8lbsU5n1VinBrBQB358seh0rXR3CQwkTTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi/5w+7eVe77IQtV3BfbW9Q63wTzLGfWtofK9MWBERv3I+UO2kN16yZj+JMi+/2EmX4pelvc8OOqxucPjt176rSaoqLNwg9t777VlYppsH9swfCZ6bZ0OjgnHI6JNlUXKEnlU8wW4xiTLJKxKQGfiiYxs6+5MmBy+JcVdOc4BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOsYbTCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOsYbTCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545BBC4CEE0;
	Thu, 30 Jan 2025 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738244158;
	bh=wDMRkZ7Yz8lbsU5n1VinBrBQB358seh0rXR3CQwkTTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOsYbTCRT/XKT1OiPS1ah6wBg5RR/ulAFAty8SRRt9Rs+123qn+nDv9h6AjvAEpte
	 GJTW88mJ1eORhE/auQMHqh5zHUA9vnyH4dA7+I8M0Rof6ACzH1TzPZpQvKAY4VmbsY
	 5Wwp7qeCkdZGRJc4bbyUaquFgplsmlqcYiMojgUY3El/l9qfW8XNsfvroMgUJGqyH/
	 wJypu9MTCsXcDTJyFLgrHMlPatoDePcD2wWFA0tgV6Owa7VfTjv1s/opVz4HmW9eAE
	 sK0floRcyQTK0aGkx3WIm3KlktpSdLxurwMlmq03QvaATwoXaL79v0GoZJDOBx3bsK
	 Myg3htBot01HQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	linux-doc@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/1] ata: libata-core: Add 'external' to the libata.force kernel parameter
Date: Thu, 30 Jan 2025 14:35:46 +0100
Message-ID: <20250130133544.219297-4-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133544.219297-3-cassel@kernel.org>
References: <20250130133544.219297-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4279; i=cassel@kernel.org; h=from:subject; bh=wDMRkZ7Yz8lbsU5n1VinBrBQB358seh0rXR3CQwkTTk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJnN5iY+K3Mt5povZvv9Zbps/zVE5+rzP48vUCoO97x2 aGjC2oud5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi/18z/Gaf5MNq933i+X2z 5xyr9/z5V+1Zlvl2u1rmqOvv736urVvKyPDl7CYFrxMcumtuLvFK5Tt+Si0tQUnk9OITNRrpt/g emfIDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
changed so that LPM is not enabled on external ports (hotplug-capable or
eSATA ports).

This is because hotplug and LPM are mutually exclusive, see 7.3.1 Hot Plug
Removal Detection and Power Management Interaction in AHCI 1.3.1.

This does require that firmware has set the appropate bits (HPCP or ESP)
in PxCMD (which is a per port register in the AHCI controller).

If the firmware has failed to mark a port as hotplug-capable or eSATA in
PxCMD, then there is currently not much a user can do.

If LPM is enabled on the port, hotplug insertions and removals will not be
detected on that port.

In order to allow a user to fix up broken firmware, add 'external' to the
libata.force kernel parameter.

libata.force can be specified either on the kernel command line, or as a
kernel module parameter.

For more information, see Documentation/admin-guide/kernel-parameters.txt.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  2 +
 drivers/ata/libata-core.c                     | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d..d9c55dcbf4a2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3036,6 +3036,8 @@
 			* max_sec_lba48: Set or clear transfer size limit to
 			  65535 sectors.
 
+			* external: Mark port as external (hotplug-capable).
+
 			* [no]lpm: Enable or disable link power management.
 
 			* [no]setxfer: Indicate if transfer speed mode setting
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7..52b78d22c831 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -88,6 +88,7 @@ struct ata_force_param {
 	unsigned int	xfer_mask;
 	unsigned int	quirk_on;
 	unsigned int	quirk_off;
+	unsigned int	pflags_on;
 	u16		lflags_on;
 	u16		lflags_off;
 };
@@ -331,6 +332,35 @@ void ata_force_cbl(struct ata_port *ap)
 	}
 }
 
+/**
+ *	ata_force_pflags - force port flags according to libata.force
+ *	@ap: ATA port of interest
+ *
+ *	Force port flags according to libata.force and whine about it.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+static void ata_force_pflags(struct ata_port *ap)
+{
+	int i;
+
+	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
+		const struct ata_force_ent *fe = &ata_force_tbl[i];
+
+		if (fe->port != -1 && fe->port != ap->print_id)
+			continue;
+
+		/* let pflags stack */
+		if (fe->param.pflags_on) {
+			ap->pflags |= fe->param.pflags_on;
+			ata_port_notice(ap,
+					"FORCE: port flag 0x%x forced -> 0x%x\n",
+					fe->param.pflags_on, ap->pflags);
+		}
+	}
+}
+
 /**
  *	ata_force_link_limits - force link limits according to libata.force
  *	@link: ATA link of interest
@@ -486,6 +516,7 @@ static void ata_force_quirks(struct ata_device *dev)
 	}
 }
 #else
+static inline void ata_force_pflags(struct ata_port *ap) { }
 static inline void ata_force_link_limits(struct ata_link *link) { }
 static inline void ata_force_xfermask(struct ata_device *dev) { }
 static inline void ata_force_quirks(struct ata_device *dev) { }
@@ -5452,6 +5483,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 #endif
 	ata_sff_port_init(ap);
 
+	ata_force_pflags(ap);
+
 	return ap;
 }
 EXPORT_SYMBOL_GPL(ata_port_alloc);
@@ -6264,6 +6297,9 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ "no" #name,	.lflags_on	= (flags) },	\
 	{ #name,	.lflags_off	= (flags) }
 
+#define force_pflag_on(name, flags)			\
+	{ #name,	.pflags_on	= (flags) }
+
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
@@ -6323,6 +6359,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
 	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
 
+	force_pflag_on(external,	ATA_PFLAG_EXTERNAL),
+
 	force_quirk_onoff(ncq,		ATA_QUIRK_NONCQ),
 	force_quirk_onoff(ncqtrim,	ATA_QUIRK_NO_NCQ_TRIM),
 	force_quirk_onoff(ncqati,	ATA_QUIRK_NO_NCQ_ON_ATI),
-- 
2.48.1

