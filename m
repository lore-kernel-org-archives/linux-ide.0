From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Thu, 09 Feb 2006 04:17:39 -0500
Message-ID: <43EB08B3.4010009@pobox.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AFEF.4010909@gmail.com> <43EAB5BA.3050204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:33949 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030526AbWBIJRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:17:44 -0500
In-Reply-To: <43EAB5BA.3050204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Albert Lee wrote:
> How about refactoring the PCI-IDE specific logic from libata-core to a 
> seperate source file, say, ata_pciide.c?

This is OK with me.


> Currently we have many PCI-IDE specific driving logic in libata-core.c.
> Maybe we can seperate the different driving logic required by different
> hardware interface into different source files?
> This could make libata-core.c to be more abstract and generic from the underlying

> Ex. hardware interface types:
>   - PCI IDE (bmdma + PRD tables)
>     (covers legacy taskfile registers interface) => ata_pciide.c
>   - ADMA     => pdc_adma.c
>   - AHCI     => ahci.c
>   - Initio   => sata_initio.c (ata_qc_issue_pio and ata_qc_pio_intr implementation here)
>   - SAS/SATA => sata_sas.c (ata_sas_port_start/stop implementation here)
>   - etc.     

We don't need abstraction, we just need to keep individual libata*.c 
file size / LOC under control.  A libata-bmdma.c would certainly be fine 
with me.

	Jeff


