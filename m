From: Richard Kang <turquesa@malgn.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Tue, 05 Jul 2011 17:26:57 +0900
Message-ID: <4E12CAD1.3030302@malgn.com>
References: <4E0AEAB1.4090106@malgn.com> <CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [125.7.223.35] ([125.7.223.35]:50296 "EHLO mail.malgn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754642Ab1GEI1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jul 2011 04:27:01 -0400
In-Reply-To: <CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org


> 2011/6/29 Richard Kang<turquesa@malgn.com>:
>> Hello.
>>
>> I have a sil3132 pci-e card and a DB-88F6282-A-BP(Marvell development
>> board based on Arm9).
>> I compiled sata_sil24 driver as a module with a cross-compiler.
>>
>> But, when loading the driver, qc timeout error was occurred during
>> ata_read_dev_id.
>> What is wrong, IRQ or DMA ?
> looks to me this is DMA issue, can you force pio mode? you can do that
> by adding "libata.dma=0" to the kernel command line.
> saeed
>
>> I have 2.6.31.8

Dear saeed,

I excuted libata.dma=0 through "$modprobe libata dma=0"
Then I excuted "$modprobe sata_sil24"

But, result is same as before.
I think sata_sil24 supports only dma not pio, right?

Thank you.

