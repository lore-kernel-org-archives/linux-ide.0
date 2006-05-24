From: Mark Lord <liml@rtr.ca>
Subject: Re: Problems with 1GB SimpleTech CF Card
Date: Wed, 24 May 2006 09:53:42 -0400
Message-ID: <44746566.6040601@rtr.ca>
References: <447436B3.4090906@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3483 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932748AbWEXNxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2006 09:53:44 -0400
In-Reply-To: <447436B3.4090906@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

Steven Scholz wrote:
> Hi all,
> 
> I get repeatable erros when accessing a 1GB SimpleTech CF Flash Card (SLCF1GBJ).
..
> ~ # hdparm -i /dev/hda
> Model=STI Flash 7.0.0, FwRev=05/03/04, SerialNo=STI J107004201112846
>  Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
>  RawCHS=2006/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=1, MultSect=off
>  CurCHS=2006/16/63, CurSects=2022048, LBA=yes, LBAsects=2022048
>  IORDY=no, tPIO={min:120,w/IORDY:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  AdvancedPM=no WriteCache=enabled
> 
> When doing "mke2fs /dev/hda1" after 30 seconds I get
> 
> 	hda: irq timeout: status=0xd0 { Busy }
> 	ide: failed opcode was: unknown
> 	ide0: reset: master: error (0x00?)

Mmmm.. No idea, but one thing to try is "hdparm -W0" on the card,
and see if that makes any difference.

Cheers
