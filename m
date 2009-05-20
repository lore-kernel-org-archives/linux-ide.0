From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 15:04:56 -0400
Message-ID: <4A145458.5080302@garzik.org>
References: <20090520065942.GD11363@kernel.dk>	 <20090520070038.GE11363@kernel.dk>	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>	 <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com> <1242845440.2881.74.camel@localhost.localdomain> <4A1452E9.7000204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33356 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579AbZETTFC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 15:05:02 -0400
In-Reply-To: <4A1452E9.7000204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Gwendal Grignou <gwendal@google.com>, Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Jeff Garzik wrote:
> Well...   The limiting factor is "ATA command slots per SATA phy", which 
> defines $N active ATA commands per port.  If a SATA NCQ device is 
> attached, you may have $N active ATA commands queued.  If two SATA NCQ 
> devices are attached to a PMP, which is attached to the SATA controller, 
> the two devices share the limit of $N active ATA commands queued.  If 32 
> devices are attached to a PMP, all 32 devices share the $N command queue 
> limit.
> 
> But additionally, as Tejun demonstrated, you might have a mix of NCQ and 
> non-NCQ devices attached to the PMP.
> 
> Thus, it is a case of nested limits:
> 
> - $N maximum active commands per port; typically N==32
> - $M maximum active commands per device; typically N==1 or N==32


Note that this applies /somewhat/ to mvsas as well:  mvsas has up to 16 
"ATA register sets" that the OS driver may assign to various ATA devices 
on a single phy.

This simulates the "command slot" concept on dedicated SATA+PMP+NCQ 
hardware like AHCI or sata_sil24.

If you attach more than 16 ATA devices to a PMP, which is theoretically 
possible, then mvsas MUST fail discovery, because it cannot address that 
many ATA devices.

But mvsas's different architecture means that it does not have similar 
"command slot" limits.

	Jeff



