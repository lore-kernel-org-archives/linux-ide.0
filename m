From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
	init model
Date: Wed, 09 Aug 2006 12:00:14 +0100
Message-ID: <1155121214.5729.153.camel@localhost.localdomain>
References: <1154919840689-git-send-email-htejun@gmail.com>
	 <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>
	 <44D98388.8030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12964 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030672AbWHIKoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 06:44:06 -0400
In-Reply-To: <44D98388.8030005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Ar Mer, 2006-08-09 am 02:41 -0400, ysgrifennodd Jeff Garzik:
> ata_generic, ISA, VLB, and embedded controllers that use libata are not 
> PCI.  libata-bmdma can drive older non-PCI controllers.
> 
> Its a bit confusing because "PCI IDE" is often used to refer to the 
> legacy IDE shadow register interface.  I started to use "bmdma" to 
> describe the interface, but it drives Alan crazy :)

Properly we have

	ST506		(register layout for PIO)
	BMDMA		(register layout for dma area/sg tables) [SFF]
	SFF		(full SFF - BAR4, PCI BMDMA)
	ADMA		(also in SFF)
	AHCI

	+ various weird vendor stuff


