Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFB43ACB
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829664; cv=none; b=qpbtK4AyRvx3bsA19WCfob178LtJe6A6WRY+UZ9eg9JaZQC/YBrC88+Edr1R4Ha2ccnJYO9nAYEBqnaw3MlhUBXADMwUN87CZ0VEenemqgO8wXFCKwitXgvHGZ+dP2o+Nx5kP9rbkbFKbXVQuu7L0E061c3aIXfefBfYYmr8GrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829664; c=relaxed/simple;
	bh=wflkioK5U4TiDSOZ3GngKl8nYEIU6IiCO9y/PUb3GQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glmbUUvlIhevXYtnAIcrsRZe04wJ6J+1vm7cJSiXnGgnkqWJ3fK7KjZOH4gqIPIKRCrdQ3NZMTBEMJEL4PZqEf1J+Ecyf9X5YxQhxhOIAsIdhCLit1+o645JKNj5xBmzwMAvEAMoXpGcw450V/Jbj8pWn0JfJUBhooIfPHQppIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdB7APuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdB7APuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE9BC433C7;
	Tue, 13 Feb 2024 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707829663;
	bh=wflkioK5U4TiDSOZ3GngKl8nYEIU6IiCO9y/PUb3GQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdB7APuAwXaX5Sh/bSqIc/IVhMPZ8uYZU+MR2aSIbGe5SZh6QdygCtdlBJYIEzgjT
	 lLIc8CfY+PW91XwXhq66D1ifgjggBLDZk1kOsvb4IbxXnBc1u4rkYJgnQJk0at8EgP
	 vk86rtpuIr3rpquhYqLqGgOrda/k1Ic3jN7DmKbnLH1ULF+R+nxGwTDaUWhHIwPss9
	 Ul9zUf+jsLMtXcpFDmAtP0Iwr+sJ3s8GZg0pzPohX12HoOqHQPQtZPUjOZgw3QmWWp
	 x7Bilu1B/syQPyL3RrQjvLfoBekJU82LQ+opfpEVnjLvRksaXpq0ZIiJ86MmXf7r/z
	 RlXrNap2GfdYw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ahci: rename board_ahci_nosntf
Date: Tue, 13 Feb 2024 14:07:30 +0100
Message-ID: <20240213130733.819524-2-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213130733.819524-1-cassel@kernel.org>
References: <20240213130733.819524-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7edbb6059274 ("ahci: clean up intel_pcs_quirk") added a new board
type (board_ahci_pcs_quirk) which applies the Intel PCS quirk for legacy
platforms. However, it also modified board_ahci_avn and board_ahci_nosntf
to apply the same quirk.

board_ahci_avn is defined under the label:
/* board IDs for specific chipsets in alphabetical order */
This is a board for a specific chipset, so the naming is perfectly fine.
(The name does not need to be suffixed with _pcs_quirk, since all
controllers for this chipset require the quirk to be applied).

board_ahci_nosntf is defined under the label:
/* board IDs by feature in alphabetical order */
This is a board for a specific feature/quirk. However, it is used to
apply two different quirks.

Rename board_ahci_nosntf to more clearly highlight that this board ID
applies two different quirks.

Fixes: 7edbb6059274 ("ahci: clean up intel_pcs_quirk")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 41b4c9777c85..c28ad3f4b59e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -53,7 +53,7 @@ enum board_ids {
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
-	board_ahci_nosntf,
+	board_ahci_nosntf_pcs_quirk,
 	/*
 	 * board_ahci_pcs_quirk is for legacy Intel platforms.
 	 * Modern Intel platforms should use board_ahci instead.
@@ -165,7 +165,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_nosntf] = {
+	[board_ahci_nosntf_pcs_quirk] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF |
 				 AHCI_HFLAG_INTEL_PCS_QUIRK),
 		.flags		= AHCI_FLAG_COMMON,
@@ -271,7 +271,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci_pcs_quirk }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci_pcs_quirk }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pcs_quirk }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf_pcs_quirk }, /* ICH8/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pcs_quirk }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pcs_quirk }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pcs_quirk }, /* ICH8M */
-- 
2.43.0

