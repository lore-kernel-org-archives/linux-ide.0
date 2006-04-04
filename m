From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata/sata status on ich[?]
Date: Tue, 04 Apr 2006 05:28:04 -0400
Message-ID: <44323C24.4010402@garzik.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46791 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932414AbWDDJ2I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 05:28:08 -0400
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mauro Tassinari <mtassinari@cmanet.it>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mauro Tassinari wrote:
> Hi Jeff, All,
> 
> our latest tests on previously reported ICH6 platforms show
> 2.6.16.git not reporting any device on 4th master port.
> The same behaviour was previously observed with 2.6.16-mm2,
> regardless the hd brand and type.

Is this fixed in 2.6.17-rc1?


> 2.6.16.1
> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
> ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48

> 2.6.16-git16
> ata_piix 0000:00:1f.2: MAP [ P0 P1 P2 P3 ]
> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
> ata2: SATA port has no device.

Thanks for that info.  Can you also provide 'lspci -vvv' (run as root)?

	Jeff


