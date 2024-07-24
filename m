Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FC5695
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799943; cv=none; b=hSdkR0GqZDB6fyLV99omkLXfPeCY2X1WglbE3ESocYOrndo1mnCFaSmrpgT3odjTq9aEhAt7PIlardHSpdTBeVxtf9g3ViJLS1PEnva1cL/83KrLc/Wm/CL6wyKdedUzryO6v4RPc0qisvSgcgdW/7pelGtjbBhV/OqDvUFG7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799943; c=relaxed/simple;
	bh=VBD3L08DqUTOZP6+dpG2TPZsqxTNifZatECQXdup8kQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaR0f/wH1e3MLE6V9gUz7Wknnen+uvXGhxO9yU+fqjJmb+Gyzt5eTAAXqyRdEJwXQGDqv6DzET2WQSjo3vpycmhG9EXr15dAtNrQKh8TuW1fMIPeBJ2cf7uSVMQ1flpxyJbnU4qH5xipRzWvmwoxcAQ+X6y2Do44l1svL6rBeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNIKfgAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNIKfgAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1DCC4AF09;
	Wed, 24 Jul 2024 05:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721799943;
	bh=VBD3L08DqUTOZP6+dpG2TPZsqxTNifZatECQXdup8kQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oNIKfgAWDD/Gchy18LVlQzdst5i8VXCs4YGUlYONIrhnzvalBzSp6G+qatqdr4opE
	 pNmt5vMh9vyMU2BNhTTZTjvajkUqyD5vOY6pMoRhnXsagXYyYw8M0T9Fu0ejvkHZQy
	 3p+mMV1vu15co6I9tVBjXpqZsZOa331ZY2a55IRL6l1SHCSdmYWMLumS+81hSj7HuK
	 NywjocbY455gMSX4ak1n8nuquA23wnXzWGHP26mc/HvW5Nj8acdvLNCMh+w8wmFwAV
	 hkG+dqwlPWKYbHhfqXMANDeLnoFvHD0xqp/37MBUWWAfERBPWe0eWAHHQ5kghOyumR
	 2MoTbwuHub91g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 3/4] ata: libata: Change ata_dev_knobble() to return a bool
Date: Wed, 24 Jul 2024 14:45:38 +0900
Message-ID: <20240724054539.182655-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724054539.182655-1-dlemoal@kernel.org>
References: <20240724054539.182655-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the function ata_dev_knobble() to return a boolean instead of a
u8.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 272770f09609..4ef1d14aba1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2219,12 +2219,12 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
 	return 0;
 }
 
-static inline u8 ata_dev_knobble(struct ata_device *dev)
+static inline bool ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 
 	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
-		return 0;
+		return false;
 
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
-- 
2.45.2

