From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/3]ACPI support for SATA/PATA
Date: Fri, 23 Jun 2006 14:39:19 +0800
Message-ID: <1151044759.7132.153.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56940 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932895AbWFWHG2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jun 2006 03:06:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, all

In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:

_GTM and _STM are PATA-only objects, which are used to get/set PATA
timing information(i.e. PIO and DMA speed);
_SDD is SATA-only object, which is used to inform the platform of the
type of device attached to a port;
_GTF is for both PATA and SATA, which is used to return ATA task file
needed to re-init the drive

In this patch set, 
ata_acpi_get_timing() is for getting PATA timing information;
ata_acpi_push_timing() is for setting PATA timing information;
ata_acpi_push_id() is for operating on _SDD;
ata_acpi_exec_tfs() is for getting ATA task file from _GTF and executing
them for a given drive

NOTE: ata_acpi_get_timing() and ata_acpi_push_timing() are channel
(port)-level operations, which have more suitable invocation place in
Tejun's upcoming PM patch. So I would not bother to reference(invoke)
them in this version of patches and will send out updated patches after
Tejun's PM patch is merged into #upstream.

Randy,
I'll add your sign-off line after you review the patch.

Thanks,
Forrest
