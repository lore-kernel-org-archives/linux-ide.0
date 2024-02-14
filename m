Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD7127B51
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934842; cv=none; b=bzirov2Nsfzdy04heKGA4cwP2dBJD4by5RmRTzoOCv/K7K1zHltEMk4ZkKLiYXOYDX6iZB1R82KhuOrDFFYqTOIrEHK9lxlMXryAgWgL2Otx5GCEDvhmyahenoVoWk5BA+9ruJJ6Z3uTU7iXxUJbPqGvEi6bcyCCfsbOWOwcV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934842; c=relaxed/simple;
	bh=upv4ULSCJzAIhb4pPCFYA/MGhhp/kW6xzwFDIB1tDPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1PUJrWLr/qMhDAMDLsPpUjs6BxmlS70zJIdmWl1nfv9ImIWMy3iOMN8nDG9tBMQ78iJcd9NrOVGMJx+jY0aH5xEPQ7t+19N4OQzqXlL7n31KOTxuRkdYx4TZLN6lOekgJTzWsPX41kDe0oFCM4SoFMUhoOXP5E7jtMMJKfhBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B207ivSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B207ivSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381DAC433F1;
	Wed, 14 Feb 2024 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934841;
	bh=upv4ULSCJzAIhb4pPCFYA/MGhhp/kW6xzwFDIB1tDPM=;
	h=From:To:Cc:Subject:Date:From;
	b=B207ivSdpyKscCnxaQ2KDmoILVOobaOHxbpjp7q/Txr9bEi7e2PnaTP6PRz4iAunl
	 KvVOeVWtMxCu59egaG7H7RjjcBQW5W+N2HyTqqyK4kPcrILIvQm4Rj6k50ptGIMNjI
	 xpJZLYGl2aLBHt1xt7823r3hXUVX9EmHefVIbAQxuQzlN3ZoGMWqcDAGQnQGJO9W6V
	 BYv6xvhFj63ZupgpTV3RFJtZZ6+10/33BxWy9TGLdMXE0Hj7dJeDB0D/0hFFGXeeY5
	 JQkoaP5/dI5DJEb/R30ELUqTBuGb3kB8d+5exlbIVb3pHtXGwVN2pyMJArxP0WISct
	 +ai8WvuaB53qA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Andrey Melnikov <temnota.am@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ahci: print the number of implemented ports
Date: Wed, 14 Feb 2024 19:20:30 +0100
Message-ID: <20240214182031.1004788-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are currently printing the CAP.NP field.
CAP.NP is a 0's based value indicating the maximum number of ports
supported by the HBA silicon. Note that the number of ports indicated
in this field may be more than the number of ports indicated in the
PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
Offset 00h: CAP – HBA Capabilities.)

Print the port_map instead, which is the value read by the PI (ports
implemented) register (after fixups).

PI (ports implemented) register is a field that has a bit set to '1'
if that specific port is implemented. This register is allowed to have
zeroes mixed with ones, i.e. a port in the middle is allowed to be
unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
Implemented.)

Fix the libata print to only print the number of implemented ports,
instead of the theoretical number of ports supported by the HBA.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.h    | 11 +++++++++++
 drivers/ata/libahci.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index df8f8a1a3a34..92d29a059763 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -455,4 +455,15 @@ static inline int ahci_nr_ports(u32 cap)
 	return (cap & 0x1f) + 1;
 }
 
+static inline int ahci_nr_ports_in_map(u32 map)
+{
+	unsigned long port_map = map;
+	int i, n = 0;
+
+	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS)
+		n++;
+
+	return n;
+}
+
 #endif /* _AHCI_H */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..82ebe911a327 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2637,7 +2637,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		vers & 0xff,
 
 		((cap >> 8) & 0x1f) + 1,
-		(cap & 0x1f) + 1,
+		ahci_nr_ports_in_map(impl),
 		speed_s,
 		impl,
 		scc_s);
-- 
2.43.0

