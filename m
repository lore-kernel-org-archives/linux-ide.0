Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD5449B26
	for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2026 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046131; cv=none; b=hoNbtdEufgMK6yNiMunOm9QkTUslLDqb/F5F4x3gnYO4GoX5vRZgfPCEFLGcEzxsSSYev+CdRE1zhYhk+uLN3quqKCzgR6mB0ht/Ri4t53FCyoUHojmn46QE4e4Mrgpo6mISalHCh1YP4OrDrwV8NYLaBjF4fMVuzVbTWhe1fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046131; c=relaxed/simple;
	bh=lYJcgOz0570mrDWEGblwJvLkZ3Jzaauu1xJjlyeugZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDwUZ9aW2vaHAyLuoE7hrwNrZP/L3Gw5JxQ18g/d8svfLlPQLCEbrwgEAmo9MwYHmvW/rwrvIdXVkv4de/OcZhvrr8s5U8ISfYuyS5xiRqlmQfoSk9AH2StHZGbCt7108s7jziCrHRMdkExQfwP1tCUeRtuO/vpN9BB2yibF40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWLo7mB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWLo7mB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC11F000E9;
	Tue, 18 Aug 2026 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046130;
	bh=sG7vh56x+VuXzedw3eRmRD98AqS8GZDfTtJVfU15A6k=;
	h=From:To:Cc:Subject:Date;
	b=FWLo7mB5FbnBZLG1jdZ90g3HN4DrZXeZP3/jr9qpSlPkk+NFj5FmQ5OOQRd6Xc8y8
	 SQ5smJMDOUrgHJMJl4NhqoZQMwHr4VsK3UfX6DrOM4GHMHStu7s9xcfE9T3xc1YQCY
	 RNgDsq7VlnZUA9OV3srUDnsPSPZ9L4NEuW3eHGtxQLtSHbstXPKYtAhc35QnF2RjVx
	 2UfQXbTyECQg7jVvKVkMFfulU4z4y4mJ2nJltPZYcD6Y22+LnD7D64++CD9YLCbEAU
	 gdTuxkBXjFfyAV9Wzl/GTanWWGKyPBY9FjpgUMP5eYfWjm8O++FCZZB+NR4lAkHwkj
	 UsJidOe8rZSig==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ata_generic: Do not bind to devices that are not IDE controllers
Date: Tue, 18 Aug 2026 11:42:05 +0200
Message-ID: <20260818094205.2672967-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3411; i=cassel@kernel.org; h=from:subject; bh=lYJcgOz0570mrDWEGblwJvLkZ3Jzaauu1xJjlyeugZA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJaNN6Kn4pd2NHnKr9PJ3baJZtVq6/YHHw/MV36CVuyv 8QFvQfTOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRbSEM/4t/aLW49Cv/0lC9 f3Ub18kNJbsvR73ZXeHD/S5XZ8PzC1sYGZ75dt+Z86TH/ZWMFMOSLP+aj3P3utsXpV6fWO55wNj FhRUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

syzbot force-bound ata_generic to 0000:00:03.0 on a QEMU arm64 virt
machine. That device is a virtio-blk-pci device holding the root file
system, and it reports PCI class 0x010000, i.e. PCI_CLASS_STORAGE_SCSI.

QEMU gives the virtio-blk-pci device a legacy virtio I/O BAR0 and a 4 KiB
MSI-X BAR1, so both resources are non-empty, the port is not discarded,
and the device control register ends up in the middle of the MSI-X table.

The emulated device rejects the byte write, and arm64 reports the
resulting bus error as a fatal synchronous external abort:

  Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
  pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606
  Call trace:
   ata_sff_freeze+0x7c/0x90
   ata_eh_freeze_port+0x34/0x5c
   ata_host_start+0x13c/0x228
   ata_pci_sff_activate_host+0x50/0x340
   ata_pci_init_one+0x19c/0x1d8
   ata_pci_bmdma_init_one+0x14/0x20
   ata_generic_init_one+0xc4/0x1ac
   local_pci_probe+0x40/0xa8
   pci_device_probe+0xd8/0x288
   really_probe+0xbc/0x2bc
   device_driver_attach+0x48/0xb4
   bind_store+0x7c/0xd8

Refuse devices which neither report the IDE class nor appear in our ID
table. Table entries keep binding as before, because some of the listed
controllers cannot be assumed to report the IDE class. A controller which
needs ata_generic but does not report the IDE class should get an ID table
entry, which is what the table is for.

Binding a driver to unrelated hardware requires root and is what
driver_override is meant to do, so this does not fix a privilege boundary.

This change only stops ata_generic from binding to a PCI device which it
has no reason to believe to be an IDE controller.

Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-ide/6a82bc54.10853dc7.22f513.001b.GAE@google.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ata_generic.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index e70b6c089cf1..f57db4480ad3 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -150,6 +150,9 @@ static int is_intel_ider(struct pci_dev *dev)
 	return 1;
 }
 
+/* Forward declaration for the pci_match_id() call in ata_generic_init_one() */
+static const struct pci_device_id ata_generic[];
+
 /**
  *	ata_generic_init_one		-	attach generic IDE
  *	@dev: PCI device found
@@ -172,6 +175,19 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
+	/*
+	 * A device matched through driver_override or through an ID added
+	 * with new_id does not come from our ID table, so pci_match_device()
+	 * hands us a synthetic ID with no driver_data and none of the checks
+	 * below apply. Probing maps BAR0 and BAR1 as the ATA command and
+	 * control blocks and writes to the device control register, so only
+	 * continue for devices which report the IDE class or which we list
+	 * ourselves.
+	 */
+	if (!pci_match_id(ata_generic, dev) &&
+	    (dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
+		return -ENODEV;
+
 	/* Don't use the generic entry unless instructed to do so */
 	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide == 0)
 		return -ENODEV;
-- 
2.55.0

