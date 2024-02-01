Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4D779EB
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804129; cv=none; b=d9Q1KmoT1nfoJx8gKD84PQFbRNZXfkaSLz6caGE+uoTlKYiGVzP4wasgFuemZJyZNxEzCK7vwlRzw/tQ1eI52/kLPUfnokH8sWGwO2hWxe7vqXPhGAheR86JeanQQ0XwNt/ZbGLaNyjcvaAc0TFVzF04WlO0sXb7MijGhSh+Y4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804129; c=relaxed/simple;
	bh=2r3dcZBreQTomBd0Vgt/4ALr1zUJOYAvoAV2UekTB0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1KS02mwJnoVyf2A/Lcv7zuOFhEm/2/lpFr4cQJAa6CNZnLjZ9tvt50K/9lxQESwlSjPp6opH2KPLB7EzZdHu7NDw0z0qidCks8D/Fd/YFso2jSfbW+NSwOuZdb+luxdAZ4awx36aJkZUtJUVGn1VN2rhs+KdWFhtKv228U9pzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t85rbFXW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t85rbFXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97FCC43399;
	Thu,  1 Feb 2024 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804128;
	bh=2r3dcZBreQTomBd0Vgt/4ALr1zUJOYAvoAV2UekTB0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t85rbFXWBTA5EZIKlKZ4TMlvjtZwOhfUGelYcP+hm8T5EMnPeiEbk+oRYXBwYevdC
	 asTf3VIZoFiez64rRvUvlK0bZwV1LuAguDMudPilEAVIHH74QkcUq5zTwxBO7ZqapS
	 QxsTIo7MFfbO8mtmax5A0Eg8gHP5UAYBWuV+XYqe9jSMGadQ4091ZRITOqfOKd8l0D
	 9QUsIpuoUYyVi0pndD5EITktQPM4KAHEfaTOIDFsFh2lyYk4SdIjjQhZ9fG56kGsJC
	 MCC1TzH1oHYWaLiNPn0CSNTwpAk+M9YsNi7mZcLjQt0twz4dCF38VYUsNAFamBjBI/
	 cDMppZQz/lGrg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH 4/5] ata: ahci: do not enable LPM on external ports
Date: Thu,  1 Feb 2024 17:15:01 +0100
Message-ID: <20240201161507.1147521-5-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
References: <20240201161507.1147521-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SATA specification contains a known incompatibility between LPM and
hot-plug events, thus do not enable LPM if the port advertises itself as
being an external SATA port (i.e. either hot-plug capable or eSATA).

This matches the power policy used in Microsoft Windows, which disables
LPM for external SATA ports, such that hot-plug events can be received.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 19b605c98d42..d50d1ae44e7f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1664,6 +1664,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
 		return;
 
+	/*
+	 * The SATA specification contains a known incompatibility between LPM
+	 * and hot-plug events, thus do not enable LPM if the port advertises
+	 * itself as an external port (i.e. either hot-plug capable or eSATA).
+	 */
+	if (ap->pflags & ATA_PFLAG_EXTERNAL)
+		return;
+
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
-- 
2.43.0

