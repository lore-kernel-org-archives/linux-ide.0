From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Mon, 09 Jul 2007 14:46:08 -0400
Message-ID: <46928270.5030709@garzik.org>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com> <46928051.5080907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50442 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbXGISqM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jul 2007 14:46:12 -0400
In-Reply-To: <46928051.5080907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Sergei Shtylyov wrote:
> The code indeed does seem meaningless. For the libata it could make 
> sense to set bit 2 for the hardreset -- but then sil680_error_handler() 
> needs to be turn into ata_bmdma_drive_eh(ap, ata_std_prereset, 
> ata_std_softreset, sil680_bus_reset, ata_std_postreset)...

Presuming bit 2 == hardreset... correct.

In some datasheets it is not clear whether this means resetting the 
silicon's ATA state machine, or truly hard-resetting the port.  There is 
occasionally a difference.  I do not remember if Sil680 is one of those.

	Jeff


