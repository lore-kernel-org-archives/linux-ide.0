From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Mon, 17 May 2010 17:35:43 +0200
Message-ID: <87hbm68rsg.fsf@free.fr>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
	<201005150023.45336.marek.vasut@gmail.com> <877hn4ao32.fsf@free.fr>
	<201005160300.02076.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:45263 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab0EQPfz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2010 11:35:55 -0400
In-Reply-To: <201005160300.02076.marek.vasut@gmail.com> (Marek Vasut's message of "Sun\, 16 May 2010 03\:00\:01 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-arm-kernel@lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

>> Once the transfer is over, you have to call dma_unmap_sg() to give back the
>> memory (ie. ensure cache consistency once the peripheral has finished
>> pushing data to the memory).
>
> This should be taken care of by the libata code, shouldn't it ?
Now I checked, it is in ata_sg_setup().

>> >> are you able to detect bus error?
>> > 
>> > Sadly, no. Nor can I detect any other condition.
>> 
>> Wouldn't the DCSR_BUSERR bit of DCSR report a bus error ?
>
> I have doubts, check the PXA270 TRM for example for description of that bit.
I have checked, and from my experience with PXA dma, when a DMA transfer is
aborted (peripheral error or wrong descriptor setup), the DMA chain is stopped
(thus your ENDIRQ never happens), and a DMA irq is raised, with DCSR having
DCSR_BUSERR raised.
This was at least verified for the DMA support in pxa_camera, and the previously
DMA api submitted for pxa.

Could you clarify your doubts, please ?

Cheers.

--
Robert
