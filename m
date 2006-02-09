From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Thu, 09 Feb 2006 11:23:38 +0800
Message-ID: <43EAB5BA.3050204@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AFEF.4010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:9704 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030554AbWBIDX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2006 22:23:56 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k193NrWs000790
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 22:23:53 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k193LlRd201860
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 20:21:47 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k193NqTH026706
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 20:23:52 -0700
In-Reply-To: <43E9AFEF.4010909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Hi Tejun,

> 
> 
> This is sort of OT, but would it be possible to separate PIO
> issuing/interrupt handling from ata_qc_issue_prot and ata_host_intr?
> 

Isn't overriding the ->qc_issue() and ->irq_handle() in LLDD good enough?

> As PIO implementation currently stands, a lldd must use those standard
> methods to use PIO, but some controllers need PIO handling but the stock
> issue and interrupt routines don't really fit. e.g. not-yet-working
> sata_inic162x.  Something like ata_qc_issue_pio and ata_qc_pio_intr maybe?
> 

How about refactoring the PCI-IDE specific logic from libata-core to a 
seperate source file, say, ata_pciide.c?

Currently we have many PCI-IDE specific driving logic in libata-core.c.
Maybe we can seperate the different driving logic required by different
hardware interface into different source files?
This could make libata-core.c to be more abstract and generic from the underlying
hardware: libata-core only knows about the ata_port_operations interface.
(ata_port_operations should be generic enough to cover all the hardware types.)
LLDDs can either select default implementation for its hardware interface type
(such as ata_bmdma_setup() from ata_pciide.c) or override harddware specfic functions.

Ex. hardware interface types:
  - PCI IDE (bmdma + PRD tables)
    (covers legacy taskfile registers interface) => ata_pciide.c
  - ADMA     => pdc_adma.c
  - AHCI     => ahci.c
  - Initio   => sata_initio.c (ata_qc_issue_pio and ata_qc_pio_intr implementation here)
  - SAS/SATA => sata_sas.c (ata_sas_port_start/stop implementation here)
  - etc.     


Albert


