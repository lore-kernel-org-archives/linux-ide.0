From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Thu, 10 Aug 2006 15:12:39 +0800
Message-ID: <44DADC67.5060707@tw.ibm.com>
References: <1154919840689-git-send-email-htejun@gmail.com>	 <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>	 <44D98388.8030005@pobox.com> <1155121214.5729.153.camel@localhost.localdomain>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:38045 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751421AbWHJHNb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 03:13:31 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7A7D1x2001641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 03:13:28 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7A7D0UM193982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:13:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7A7CxgL012155
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:13:00 -0600
In-Reply-To: <1155121214.5729.153.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, mlord@pobox.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-08-09 am 02:41 -0400, ysgrifennodd Jeff Garzik:
> 
>>ata_generic, ISA, VLB, and embedded controllers that use libata are not 
>>PCI.  libata-bmdma can drive older non-PCI controllers.
>>
>>Its a bit confusing because "PCI IDE" is often used to refer to the 
>>legacy IDE shadow register interface.  I started to use "bmdma" to 
>>describe the interface, but it drives Alan crazy :)
> 
> 
> Properly we have
> 
> 	ST506		(register layout for PIO)
> 	BMDMA		(register layout for dma area/sg tables) [SFF]
> 	SFF		(full SFF - BAR4, PCI BMDMA)
> 	ADMA		(also in SFF)
> 	AHCI
> 
> 	+ various weird vendor stuff
> 
> 

The first time libata-"bmdma".c was seen, it looked strange to me, too.

I remember the WD1003/ST-506 adapter on my old i386 PC, which was later replaced by
an "AT-Bus" IDE controller. The IDE controller is register level compatible
to the WD1003 ST-506 adapter, with the same legacy PIO address and irq 14.
(IDE had to be register-level compatible with the old WD1003 interface,
because the Int 13h code for the WD1003 is in the main PC/AT BIOS, not on the adapter.)

At about the 486 VL-bus days, an additional "secondary" port was added, with irq 15.
In those old 286/386/486 days, the IDE adapters were PIO only.

The BM-DMA came at about the time of the Intel Pentium/PCI-bus, with the new BM-DMA registers. 

When libata-bmdma.c is seperated out from libata-core.c, I was wondering why the
BM-DMA PRD table management codes such as ata_sg_setup() are left in libata-core.c,
while the old WD1003/ST-506 like logic ata_tf_load(), ata_exec_command() and ata_check_status()
are moved to the libata-bmdma.c.

Jeff explained the traditional WD1003 ST-506 registers can be viewed as subset of BM-DMA,
but I still feel strange to call the old WD1003-like IDE controllers on my 386/486 as "BM-DMA"...

--
albert


