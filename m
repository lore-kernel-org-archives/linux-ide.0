From: Tejun Heo <htejun@gmail.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Thu, 09 Feb 2006 12:58:51 +0900
Message-ID: <43EABDFB.8000505@gmail.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AFEF.4010909@gmail.com> <43EAB5BA.3050204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:5144 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1160999AbWBID7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2006 22:59:00 -0500
Received: by xproxy.gmail.com with SMTP id i30so38538wxd
        for <linux-ide@vger.kernel.org>; Wed, 08 Feb 2006 19:58:59 -0800 (PST)
In-Reply-To: <43EAB5BA.3050204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Hello, Albert.

Albert Lee wrote:
>>
>>This is sort of OT, but would it be possible to separate PIO
>>issuing/interrupt handling from ata_qc_issue_prot and ata_host_intr?
>>
> 
> Isn't overriding the ->qc_issue() and ->irq_handle() in LLDD good enough?

The driver needs its own ->qc_issue() and ->irq_handler() but it also 
needs PIO support.  AFAICS, the current PIO implementation is rather 
strongly tied into ata_qc_issue_prot() and ata_host_intr() making it 
difficult to use PIO support in drivers which use private ->qc_issue() 
and ->irq_handler().  So, what I was asking was to separate out PIO 
handling from ata_qc_issue_prot() and ata_host_intr() such that other 
issue and intr routines can use PIO.
> 
> How about refactoring the PCI-IDE specific logic from libata-core to a 
> seperate source file, say, ata_pciide.c?
> 
> Currently we have many PCI-IDE specific driving logic in libata-core.c.
> Maybe we can seperate the different driving logic required by different
> hardware interface into different source files?
> This could make libata-core.c to be more abstract and generic from the underlying
> hardware: libata-core only knows about the ata_port_operations interface.
> (ata_port_operations should be generic enough to cover all the hardware types.)
> LLDDs can either select default implementation for its hardware interface type
> (such as ata_bmdma_setup() from ata_pciide.c) or override harddware specfic functions.

I agree.  If for nothing else, the size of libata-core.c is getting too 
large.  Also, we currently have multiple levels of methods in 
ata_port_operations, some operations are only used by other operations, 
which is a bit confusing I think.

Separating out traditional driving logic from libata-core.c would 
require another level of indirection such that traditional low level 
drivers still can mix & match different legacy operations.  I thought 
about it and wasn't really sure whether the added abstraction was worth 
the clean up.  We currently don't have too many controllers which are 
legacy-free, it seems.

> Ex. hardware interface types:
>   - PCI IDE (bmdma + PRD tables)
>     (covers legacy taskfile registers interface) => ata_pciide.c
>   - ADMA     => pdc_adma.c
>   - AHCI     => ahci.c
>   - Initio   => sata_initio.c (ata_qc_issue_pio and ata_qc_pio_intr implementation here)

ata_qc_issue_pio was bad naming probably.  As I wrote before, I was 
asking for a PIO helper which inic_qc_issue() can call to drive PIO 
logic and the same for ata_qc_pio_intr().

>   - SAS/SATA => sata_sas.c (ata_sas_port_start/stop implementation here)
>   - etc.     

Thanks.

-- 
tejun
