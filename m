From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/2]ACPI support for SATA/PATA
Date: Tue, 8 Aug 2006 12:14:06 -0700
Message-ID: <20060808121406.87fcde32.rdunlap@xenotime.net>
References: <1153899345.4957.59.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:44514 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964872AbWHHTLY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 15:11:24 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 12:11:22 -0700
In-Reply-To: <1153899345.4957.59.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

On Wed, 26 Jul 2006 15:35:45 +0800 zhao, forrest wrote:

> Hello, all
> 
> In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:
> 
> _GTF is for both PATA and SATA, which is used to return ATA task file
> needed to re-init the drive;
> _SDD is SATA-only object, which is used to inform the platform of the
> type of device attached to a port;
> _GTM and _STM are PATA-only objects, which are used to get/set PATA
> timing information(i.e. PIO and DMA speed).
> 
> In this patch set, 
> ata_acpi_exec_tfs() is for getting ATA task file from _GTF and executing
> them for a given drive;
> ata_acpi_push_id() is for setting _SDD.
> 
> 
> NOTE: this patch doesn't include the support for _GTM and _STM because
> libata defines ->set_piomode(), ->set_dmamode() callbacks for LLDD,
> which do the same work as _GTM and _STM. So I think it's not necessary
> to provide redundant functionality by _GTM and _STM.

Do LLDDs use set_piomode() and set_dmamode() to save those modes
before suspend and restore them on resume?

Thanks,
---
~Randy
