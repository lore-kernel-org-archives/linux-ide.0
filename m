From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3]ACPI support for SATA/PATA
Date: Mon, 26 Jun 2006 03:26:14 -0400
Message-ID: <449F8C16.70308@pobox.com>
References: <1151044759.7132.153.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45474 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbWFZH0U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 03:26:20 -0400
In-Reply-To: <1151044759.7132.153.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: rdunlap@xenotime.net, htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hello, all
> 
> In ACPI spec 3.0, section 9.9 defines 4 objects for PATA/SATA:
> 
> _GTM and _STM are PATA-only objects, which are used to get/set PATA
> timing information(i.e. PIO and DMA speed);
> _SDD is SATA-only object, which is used to inform the platform of the
> type of device attached to a port;
> _GTF is for both PATA and SATA, which is used to return ATA task file
> needed to re-init the drive
> 
> In this patch set, 
> ata_acpi_get_timing() is for getting PATA timing information;
> ata_acpi_push_timing() is for setting PATA timing information;
> ata_acpi_push_id() is for operating on _SDD;
> ata_acpi_exec_tfs() is for getting ATA task file from _GTF and executing
> them for a given drive
> 
> NOTE: ata_acpi_get_timing() and ata_acpi_push_timing() are channel
> (port)-level operations, which have more suitable invocation place in
> Tejun's upcoming PM patch. So I would not bother to reference(invoke)
> them in this version of patches and will send out updated patches after
> Tejun's PM patch is merged into #upstream.

This is a great starting point for rejuvinating the SATA ACPI support, 
thanks!

I would request that you create two patches for this support:

Patch #1:  Adds everything needed to make SATA ACPI work...  Makefile, 
noacpi flag, core code, etc.

Patch #2:  Dependent on patch #1.  Adds everything needed to make PATA 
ACPI work.

And overall, I want to reinforce a principle used for Linux patches: 
applying 1-N patches for any given patchset should always produce a 
compileable (and _hopefully_ working) piece of code.  Patches are 
separated into _logical_ changes, much like the steps in a calculus proof.

Regards,

	Jeff



