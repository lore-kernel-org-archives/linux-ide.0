Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DF1C3C11
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317397; cv=none; b=TnNHu3XuPBqPMquaqSRui/56ULoR+3ra6jexP6WEuo9hmK6WNqzI8fwJzFp5B5zcMgef5PcyKoiFQASxV0Z3IUPEIyLAT9HNM10G7Sf/3cBbLixA5U3mM1hnYOw4aAUolY4e4ajWux75AA/0KkTUk1/bFp+hM7VxqzhzvLFd0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317397; c=relaxed/simple;
	bh=IEyzkrscG+PwWOsptPrkSsW8gX04Hmq8SXc0etD/q00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoK46jqDGAB35NC7H/ZNvwKmnjt5PLOFzYho/+VxQgdlClOJ7r0+L7dfZKpfCLRl/nIAq7J40iHajuQFkz1aSeS3tiJxGQHd2xbhXny32rvWBcl0Swqv8ecm/l0mKxeL/vgIkRBpOfRy1qnAfATUzCRWmAJsJZ6bk+fVRtw3oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvv47qi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvv47qi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A4C4CEE7;
	Thu, 15 May 2025 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317397;
	bh=IEyzkrscG+PwWOsptPrkSsW8gX04Hmq8SXc0etD/q00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvv47qi68JrFSAWUM+wXkt9ZVUA0Xp0S4+0Yt9G2jFd/DFjy9hn9SQst4kXPCV0NO
	 lDK1Nj82LluDfSH2ZPN9QDXkU2p45Gq4zSqTfQDVbBe95y+F3JyLiegExN1KUhUS2a
	 KKAZZZAxA2LowIARWvZ1r+v3hFgB+X88r626W1CzB8oYEXkAkQqiqRCQhLipW5KzNj
	 iZe7wFhn4wMbZ4iPJCxdcSOWeGj4CkmaoecsvEu72B4rwaoNyjaZZWjBsTyxrfqBDx
	 g2GJi+x+fV9B8ryyjwJaw1Fq5QqlemzIXDS0Zt+PcTDoF46WGr/jB+kxyOQ0cwqUcT
	 zoZR8JECqFwxg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 2/5] ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
Date: Thu, 15 May 2025 15:56:24 +0200
Message-ID: <20250515135622.720623-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
References: <20250515135622.720623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=cassel@kernel.org; h=from:subject; bh=IEyzkrscG+PwWOsptPrkSsW8gX04Hmq8SXc0etD/q00=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP3UfveNcfFb+0hJn98sPj67hdNGcMKti4ell/g8Xa 3QpBf126ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEqhMZ/keW+k4UbddXXzf7 1AGHPWzHpYPPruhS2XE2WjZb/87n98yMDEvy9XdE+TVmf3wzwVHR1+LZVJ4GBrHeTZH7eLYfO1i wjxsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

link->lpm_policy is initialized to ATA_LPM_UNKNOWN in ata_eh_reset().

ata_eh_set_lpm() is then only called if
link->lpm_policy != ap->target_lpm_policy (after reset)

and then only if link->lpm_policy > ATA_LPM_MAX_POWER (before
revalidation).

This means that ata_eh_set_lpm() is currently never called with
policy == ATA_LPM_UNKNOWN.

Add a WARN_ON_ONCE so that it is more obvious from reading the code that
this function is never called with policy == ATA_LPM_UNKNOWN.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f39756a26751..89b7b2139a16 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3442,6 +3442,13 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
 		return 0;
 
+	/*
+	 * This function currently assumes that it will never be supplied policy
+	 * ATA_LPM_UNKNOWN.
+	 */
+	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
+		return 0;
+
 	/*
 	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
 	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
-- 
2.49.0

