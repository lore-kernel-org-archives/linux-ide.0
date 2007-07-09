From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Mon, 09 Jul 2007 22:51:02 +0400
Message-ID: <46928396.5010502@ru.mvista.com>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com> <46928051.5080907@ru.mvista.com> <46928270.5030709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5369 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754654AbXGIStA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jul 2007 14:49:00 -0400
In-Reply-To: <46928270.5030709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello.

Jeff Garzik wrote:

>> The code indeed does seem meaningless. For the libata it could make 
>> sense to set bit 2 for the hardreset -- but then 
>> sil680_error_handler() needs to be turn into ata_bmdma_drive_eh(ap, 
>> ata_std_prereset, ata_std_softreset, sil680_bus_reset, 
>> ata_std_postreset)...

> Presuming bit 2 == hardreset... correct.

    It's said to control the RST pin.

>     Jeff

MBR, Sergei
