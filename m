From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS driver K2.4 for 180/182/965/966....
Date: Sun, 05 Aug 2007 12:36:44 +0200
Message-ID: <46B5A83C.4070506@gmx.net>
References: <200707300140.18940.fbourdonnec@chez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754375AbXHEKgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Aug 2007 06:36:47 -0400
In-Reply-To: <200707300140.18940.fbourdonnec@chez.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fbourdonnec@chez.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Franck Bourdonnec wrote:
> Hello Uwe & Jeff,
>
>
> I'm trying to follow the 'life' of this driver "sata_sis.c".
>
> I want to report back in Kernel 2.4.34 the additions found
> since some time. I do this to extend IPCOP usage of
> SATA boards and also to contribute to linux kernel if
> possible.
>   
As far as i know the kernel 2.4 is nearly frozen.
> It's not easy because there is many source, that seems
> like each others, but not exactly
>
> 1) http://driver.sis.com/linux/raid/sis18x_20060508.zip
> 2) what is today in kernel 2.6.21
>   
The 2.6.22 supports the actual SiS hardware, in 2.6.21 not all hardware
works, like the SATA SiS968
> 3) the list of patch against sata_sis.c (git)
> 4) the kernel 2.4.34 "sata_sis.c" source
>
> After compiling all this, result is a kernel 2.4 driver
> that I think, ressemble a lot to the actual 2.6 version.
>
> I would like you just to read the source (test it??) for advice.
>
>
> ========================
>
> Strange thing I noted is:
>
> Sis1180,1184: present in sis18x_20060508.zip but inexistant
>   
The 1180 is supported in 2.6.22, see pata_sis.c , the 1184 is supported
in ahci.c. The 1183 and the 0x0180 support was done by
PATA.
> elsewhere (particulary in K2.6). Why?
>
> ========================
>
> in this fix 
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.22.y.git;a=commitdiff;h=29da9f6d9cc3685ae7f6c8b817f6ed8864c78a4c
>
> the call to "ata_pci_init_native_mode" function is a little bit changed: 
> &ppi becomes ppi.
>   
libata v2 supports 2 ports with different data. This is not supported in
the libata v1. A ppi array is not necessary.
> probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | 
> ATA_PORT_SECONDARY);
>
> just a confirmation that this match K2.4 prototype. Sometimes I don't really 
> follow some C notation with **  ;-)
>
> ==========================
>
> I wasn't sure here:
>
> 1)
> .host_flags  = ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS | ATA_FLAG_SATA_RESET |
>                           ATA_FLAG_NO_LEGACY,
> 2)
> .host_flags  = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
>                           ATA_FLAG_NO_LEGACY,
> 3)
> .host_flags  = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
>
>
>
> Choosed 2) because
> ATA_FLAG_SLAVE_POSS is positionned in the code (set to one)
>
>
>   
It is ok.
> =========================
>
> Thank you to have read this.
> Hope it's ok. For my project (IPCop) or directly in k2.4
> if you don't see major obstacle.
>
> Franck
>   
Uwe
