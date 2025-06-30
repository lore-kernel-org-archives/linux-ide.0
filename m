Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191C1F4E59
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264934; cv=none; b=l+Ybc3gADL0n0hs1sYllJiqDpbWXckfRp97KhNjvD2OEOJtRz2ogylZISmUaXtJW7KgTMlWqL4vEUsN7FUASSoLcxkqXMrET/tuD8UGFpVKOi2fsoouFNTDZB0b+IvhS/5rfBrpZt6jVw2I86fUZtrHjNIRktLUVAaW5+fyGa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264934; c=relaxed/simple;
	bh=oPhIjmtVwH8jZasIdk8fJhIVoHzMjj5EZa1/qh6IVyQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj3eAje0Kuok5MTyAHNl+RLbam/qhg1/nMf29l5ifeSk4ma+KM+Jb1VbNW9BAsrippnMdc6nHP2xhxZgFxgmqTs+CD1RNZOCOUHyQjKd3ie1zVFHelhYesyvCaRCSyl3XLKObGyY3j/L9H1glIP+GxDx2+kpt7Xz3qxHSNXDPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEVagnCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEVagnCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003FCC4CEEB;
	Mon, 30 Jun 2025 06:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264934;
	bh=oPhIjmtVwH8jZasIdk8fJhIVoHzMjj5EZa1/qh6IVyQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VEVagnCncY/eriObOYUL/bmzPNeNA9qu8NX6Q58C1X30BTj/Oh0xEm9nNQ4i6NF1P
	 OJ9w5l4I5e1o5OPZeQ8Rwx1KlOJoviTvvFHi7G0cUlJVonXd8FnEPDt42fvSBNVb7W
	 70uzOPkRD9RxgRrTwrBsc5OFdn1V4gNlc5wSewB1+b0ZR1a/f2YjmAb4Cl2Ke3kJBU
	 HJU0wYS4s0ynyhUHZNqvn5K1aL93S2V9L2ELxx7jSnxIXVyCZ32kHJy8eqZic5xbxo
	 eUJz0ByO0lXcBgFbvjPWMLknaxMoDLP/UQoZkqoyiVzb8FCdS1vvmtw4pKIB/iLz05
	 s0xm1kI5ikYjA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 08/10] ata: ahci: Disallow LPM policy control if not supported
Date: Mon, 30 Jun 2025 15:26:35 +0900
Message-ID: <20250630062637.258329-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
supported by the HBA") introduced an early return in
ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
of ports belonging to a host that does not support the Partial, Slumber
and DevSleep power states is unchanged and remains set to
ATA_LPM_UNKNOWN and thus prevents the execution of
ata_eh_link_set_lpm().

However, a user or a system daemon (e.g. systemd-udevd) may still
attempt changing the LPM policy through the sysfs
link_power_management_policy of the host.

Improve this to prevent sysfs LPM policy changes by setting the flag
ATA_FLOAG_NO_LPM for the port of such host, and initialize the port
target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
low power state is being used on the port and its link.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 34698ae39f55..737f5d1bde11 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1793,7 +1793,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if ((ap->host->flags & ATA_HOST_NO_PART) &&
 	    (ap->host->flags & ATA_HOST_NO_SSC) &&
 	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
-		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
+		ata_port_warn(ap,
+			"No LPM states supported, forcing LPM max_power\n");
+		ap->flags |= ATA_FLAG_NO_LPM;
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 		return;
 	}
 
-- 
2.50.0

