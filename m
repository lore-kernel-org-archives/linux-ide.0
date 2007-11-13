From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: pata_serverworks hangs
Date: Tue, 13 Nov 2007 12:12:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711131212030.14654@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0711021415300.1316@bizon.gios.gov.pl>
 <20071102174148.49358f7e@the-village.bc.nu> <Pine.LNX.4.64.0711091523090.951@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:55114 "EHLO
	bizon.gios.gov.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXKMLNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 06:13:08 -0500
In-Reply-To: <Pine.LNX.4.64.0711091523090.951@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org



On Fri, 9 Nov 2007, Krzysztof Oledzki wrote:

>
>
> On Fri, 2 Nov 2007, Alan Cox wrote:
>
>> On Fri, 2 Nov 2007 14:29:17 +0100 (CET)
>> Krzysztof Oledzki <olel@ans.pl> wrote:
>> 
>>> Hello,
>>> 
>>> I just tried to switch from old IDE to libata but unfortunately kernel
>>> (2.6.22.10) hangs during boot:
>>> 
>>> ata1: PATA max UDMA/66 cmd 0x000101e8 ctl 0x000103ee bmdma 0x00012c40 irq 
>>> 11
>>> ata2: DUMMY
>>> ata1.00: ATAPI: HL-DT-ST CD-ROM GCR-8482B, 1.00, max MWDMA2
>>> ara1.01: ATAPI: LITE-ON LTR-62327S, QS75, max UDMA/33
>>> ata1.00: configured for MWDMA2
>>> ata1.01: configured for UDMA/33
>>> scsi 2:0:0:0: CDROM             HL-DT-ST CDROM GCR-8482B 1.00 PQ: 0 ANSI 5
>>> (kernel hangs)
>>> 
>>> Attaching lspci and dmesg from working system, with pata_serverworks
>>> disabled.
>> 
>> Try the following patch and let me know if it helps:
>
> It did not help. :( System still hangs exactly like before.

I'm willing to test more patches if that's possible. ;)

Best regards,

 			Krzysztof Oledzki
