From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/2]ACPI support for SATA/PATA
Date: Wed, 26 Jul 2006 15:35:45 +0800
Message-ID: <1153899345.4957.59.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56224 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030219AbWGZHsQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 03:48:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, all

In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:

_GTF is for both PATA and SATA, which is used to return ATA task file
needed to re-init the drive;
_SDD is SATA-only object, which is used to inform the platform of the
type of device attached to a port;
_GTM and _STM are PATA-only objects, which are used to get/set PATA
timing information(i.e. PIO and DMA speed).

In this patch set, 
ata_acpi_exec_tfs() is for getting ATA task file from _GTF and executing
them for a given drive;
ata_acpi_push_id() is for setting _SDD.


NOTE: this patch doesn't include the support for _GTM and _STM because
libata defines ->set_piomode(), ->set_dmamode() callbacks for LLDD,
which do the same work as _GTM and _STM. So I think it's not necessary
to provide redundant functionality by _GTM and _STM.

Randy,
I'll add your sign-off line after you review the patch.

Thanks,
Forrest

