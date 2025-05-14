Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E8278161
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243348; cv=none; b=Aair6eu8mwp+7s+gFJ/XLaEws9Cg2/zFFHk1fIe/+33uYyfe7UZpYJaEeMVV+/vWOif/qNWpCq9s+H+TsTy2KyrZ+w2r+bpZHrqD1lCrrAQkDRg9tgS9AAnDHRiPTWvgJVnZvUYy1sBvbJkwAomza6XaF2tyQZtZN/q/OQXb7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243348; c=relaxed/simple;
	bh=qwfvb3y/eLjGRB/szILJAXslX6sBGEz+FQ4frYhdsEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUyGUq4vfgTyW93KT/ppxzpy1QRkXktea9P28iQ+tXb97bUCM7JoRLfK0gMPl5kuLAiR4z8vLWvI1z+472/H/FpDmTpPPVpKQYyoFD1evxrsxQoOVQ8M1/i+X2chHMkx9r5Y7O29v8ikUcqZXqPuIRXwaGJrL638sdR8N2H4WZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGUAugM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGUAugM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBA8C4CEE3;
	Wed, 14 May 2025 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243348;
	bh=qwfvb3y/eLjGRB/szILJAXslX6sBGEz+FQ4frYhdsEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGUAugM9zgnxoxM+OsTI8gawdXBPQSbIbAxKRplZnhtgrQ93l8K8McLl6Wct3AyyU
	 yWkFhFYfhVIeaUAe4jQYZfYWoQNYxZW8B477VgCNdZFLdxcGe6aTe8Zk4ntvDRjeSE
	 0STbIT/Jol0rzecWu37Dew44qeJa12Rp195fSPYvqF9r2petdDC6jQIbRh3WyToQBR
	 WuRff/XETXl9AYeiPH14SEIy0uIzkENJSG7k8aeLTNq8wrgXR35mY5xhwIJv2uBQCN
	 ootKJDvMHMwSitFe/hmiBhMBPeYZNxprQUj+WgllnParcvMup5wAqpSBXBWWQKpP7L
	 QQke8/XLJqMhA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 6/7] ata: libata-eh: Host support has nothing to do with disabling DIPM
Date: Wed, 14 May 2025 19:22:16 +0200
Message-ID: <20250514172210.383801-15-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514172210.383801-9-cassel@kernel.org>
References: <20250514172210.383801-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=cassel@kernel.org; h=from:subject; bh=qwfvb3y/eLjGRB/szILJAXslX6sBGEz+FQ4frYhdsEs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULroETmXX6g30/fjtgOjenMcuh+PinrFPSpBoFJWdl DfphbhhRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbS9Zrhn8KC9EdfreZsSPsv GCkc7C3AHcB47u4rtonV22YuUTm6fT0jQ5/etg1aLFfjOPg5BIqbrgXqXLrJKXbkOf8Sm2cSZ6r 3sAIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

It makes sense to take host support for DIPM into account when
enabling DIPM, however, it makes zero sense to take host support
into account when disabling DIPM.

If the host does not support DIPM, that is a very good reason to
not keep the feature enabled on the device side.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bc3654265053..91d97d98eed1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3473,8 +3473,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
-		    (dev_has_dipm && host_has_dipm)) {
+		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
-- 
2.49.0

