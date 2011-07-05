From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Tue, 5 Jul 2011 13:11:48 +0300
Message-ID: <CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>
References: <4E0AEAB1.4090106@malgn.com>
	<CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>
	<4E12CAD1.3030302@malgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52004 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab1GEKLs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2011 06:11:48 -0400
Received: by vws1 with SMTP id 1so4069224vws.19
        for <linux-ide@vger.kernel.org>; Tue, 05 Jul 2011 03:11:48 -0700 (PDT)
In-Reply-To: <4E12CAD1.3030302@malgn.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Kang <turquesa@malgn.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 5, 2011 at 11:26 AM, Richard Kang <turquesa@malgn.com> wrote:
>
>> 2011/6/29 Richard Kang<turquesa@malgn.com>:
>>>
>>> Hello.
>>>
>>> I have a sil3132 pci-e card and a DB-88F6282-A-BP(Marvell development
>>> board based on Arm9).
>>> I compiled sata_sil24 driver as a module with a cross-compiler.
>>>
>>> But, when loading the driver, qc timeout error was occurred during
>>> ata_read_dev_id.
>>> What is wrong, IRQ or DMA ?
>>
>> looks to me this is DMA issue, can you force pio mode? you can do that
>> by adding "libata.dma=0" to the kernel command line.
>> saeed
>>
>>> I have 2.6.31.8
>
> Dear saeed,
>
> I excuted libata.dma=0 through "$modprobe libata dma=0"
> Then I excuted "$modprobe sata_sil24"
>
> But, result is same as before.
> I think sata_sil24 supports only dma not pio, right?
I don't think so.
can you check if interrupts working fine?
you can test that by loading the driver without any connected disk,
then check if the controller raises any interrupt from
/proc/interrupts when plugging a disk,
saeed
