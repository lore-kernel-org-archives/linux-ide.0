Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1D1B942
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254073; cv=none; b=jx9bfegRxa6yJ6SMdOkX3KtV26eily7xiSUhAzWHE6TXouvwfq5uqMflH/6YfwV65gsWf2r+MATr5ZYxeVKLvMNbEICCqmP3EsGnPo+z0SHnWSDaE9O7uX/4oVG0iQAjNJsSK6KV+E6YiqBKk8UeAEN97SYXAzWMAqDef2FhLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254073; c=relaxed/simple;
	bh=NS4SaNpNQa7CdWa0/E2wzUyz9FCCNQgTrOp0D4znAGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLntoZQwfJChwIxrzopqfACxULlBYQgcVwlOnFbvAkEB/6TTUptJOfmWk3mNocJMrO6ngM34OVidG6dCZbTsOxmAPDJPVVfPs4fRdarYQcST9zsJanf/wOafjozJiVE8GAUjCusVCFLWqI4R/k+JZJV5ObKn1UylqulIfKmeh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf1/XO0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf1/XO0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90681C43390;
	Tue,  6 Feb 2024 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707254073;
	bh=NS4SaNpNQa7CdWa0/E2wzUyz9FCCNQgTrOp0D4znAGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf1/XO0rmw8dSJg3iuCAn+6kfqXICbK4uS9PPSqXOI44oTqEWW6p3S57+h0vMK2XB
	 AHSRoPpDbWLnfZWBcPjaQsi/sPfsh2YTPnNUbzLhel4dgAdNYHXLxxaP61kQmAF6Lu
	 +S6bBlGe2sXhOD1PKhE9a+0WI0uYA9XxW2qjn8eLdsBqmoM0jDWB2gTvL5VsP89w60
	 zJroHqzQhDUjmCz8mbD6EvFWOiWN2OQHresSNalCrxsB/6CSi73CIW13QBTtQXG0LV
	 RItXCMXUbkah86wrDfqeMJSIjtES+jSKFLjP+IAYDBp0+8t44J9txX3s6zyVhlfx63
	 HQQqi8/XxStww==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 4/5] ata: ahci: do not enable LPM on external ports
Date: Tue,  6 Feb 2024 22:13:45 +0100
Message-ID: <20240206211352.1664816-5-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AHCI 1.3.3, 7.3.1.1 Software Flow for Hot Plug Removal Detection states:
"To reliably detect hot plug removals, software must disable interface
power management.

Software should perform the following initialization on a port after a
device is attached:
-Set PxSCTL.IPM to 3h to disable interface power management state
 transitions.
-Set PxCMD.ALPE to ‘0’ to disable aggressive power management.
-Ensure PxIE.PRCE is set to ‘1’ to enable interrupts on hot plug removals.
-Disable device initiated interface power management by issuing the
 appropriate SET FEATURES command."

Further, AHCI 1.3.3, 7.3 Native Hot Plug Support states:
"The HBA shall set the PxSERR.DIAG.X bit to ‘1’ when a COMINIT is received
from the device. Hot plug insertions are detected via the PxIS.PCS bit
that directly reflects the PxSERR.DIAG.X bit. The HBA shall set the
PxSERR.DIAG.N bit to ‘1’ when the HBA’s internal PhyRdy signal changes
state.

Hot plug removals are detected via the PxIS.PRCS bit that directly
reflects the PxSERR.DIAG.N bit. Note that PxSERR.DIAG.N is also set
to ‘1’ on insertions and during interface power management entry/exit."

ahci_set_lpm() already disables the PxIS.PRCS interrupt if setting a
LPM policy != ATA_LPM_MAX_POWER, so we cannot detect hot plug removals
when LPM policy != ATA_LPM_MAX_POWER.

We do have PxIS.PCS interrupt enabled even for LPM policy !=
ATA_LPM_MAX_POWER, so we should theoretically still be able to detect
hot plug insertions even when LPM is enabled.

However, in practise, for LPM policy ATA_LPM_MED_POWER_WITH_DIPM,
ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MIN_POWER, if there is
no link enabled, sata_link_scr_lpm() will set SControl.DET = 0x4,
which will transition the port to the "P:Offline" state.

The P:Offline mode is described in SATA Gold 3.5a:
4.1.1.103 Phy offline:
"In this mode the host Phy is forced off and the host Phy does not
recognize nor respond to COMINIT or COMWAKE. This mode is entered by
setting the DET field of the SControl register to 0100b. This is a
mechanism for the host to turn off its Phy."

So in the P:Offline state the PHY does not recognize the unsolicited
COMINIT which is sent on a hot plug insertion.

While we could change sata_link_scr_lpm() to never power off an external
port for LPM policy != ATA_LPM_MAX_POWER (in order be able to handle hot
plug insertions), we still would not be able to handle hot plug removals.

Thus, simply modify ahci_update_initial_lpm_policy() to not enable LPM if
the port advertises itself as an external port, as this function is
already being used to set/override the initial LPM policy.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 346a0f9ef246..9d052ff2b86c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1665,6 +1665,15 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
 		return;
 
+	/*
+	 * AHCI contains a known incompatibility between LPM and hot-plug
+	 * removal events, see 7.3.1 Hot Plug Removal Detection and Power
+	 * Management Interaction in AHCI 1.3.1. Therefore, do not enable
+	 * LPM if the port advertises itself as an external port.
+	 */
+	if (ap->pflags & ATA_PFLAG_EXTERNAL)
+		return;
+
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
-- 
2.43.0

