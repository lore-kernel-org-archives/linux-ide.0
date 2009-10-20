From: "MadLoisae@gmx.net" <MadLoisae@gmx.net>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen - "dead"
 harddisc until reboot
Date: Tue, 20 Oct 2009 16:21:35 +0200
Message-ID: <4ADDC76F.60303@gmx.net>
References: <4ADDB7A3.3020904@gmx.net> <19165.49281.905767.838696@pilspetsen.it.uu.se>
Reply-To: MadLoisae@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752103AbZJTOVe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Oct 2009 10:21:34 -0400
In-Reply-To: <19165.49281.905767.838696@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Mikael,

thanks for your response.
to 1.) If I stop limiting the harddisk to UDMA3 it will try to speak 
every time UDMA4 - this does not work flawless and so there are a lot of 
hard resets of the IDE-channel.
Is there another possibility to limit the drive to UDMA3? With 
legacy-IDE I did this always with hdparm, but this does not work with 
libata. :-/
to 2.) I cannot separate the two devices - the CF-port is soldered onto 
the mainboard and is connected to the secodary master, the 2.5" harddisc 
has a 44pin connector to the 44pin-connector on the mainbaord. :-/

kind regards, Alois

Mikael Pettersson wrote:
> MadLoisae@gmx.net writes:
>  > Hello Jeff, hello linux-ide-team,
>  > 
>  > I encounter here sometimes a strange problem - I hope you do not bother 
>  > me that I write direct to you.
>  > I use following hardware: VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
>  > Master IDE (rev 06) as PATA-controller (so I use the pata_via module - 
>  > 1106:0571), on the secondary channel as master a Compact Flash card, as 
>  > slave a 2.5" WDC 320GB harddisc. The harddisc is only able to speak 
>  > UDMA3 (caused by the cable), the Compact Flash Card is able to speak 
>  > UDMA4. So I force this values with the kernel command line 
>  > (libata.force=2.00:udma4,2.01:udma3). I am using ext3 on the FlashCard 
>  > and ext4 on the harddisc, splitted in 4 partitions.
>  > I use linux 2.6.31.4, my config is attached.
>  > Since 2.6.30 I use libata instead of legacy IDE.
>  > After a not reproduceable time my machine is not able to handle my 
>  > harddisk any more. There are always the same logs:
>  > 
>  > [1036724.000131] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
>  > 0x6 frozen
>  > [1036724.000256] ata2.01: cmd c8/00:08:0b:72:04/00:00:00:00:00/fa tag 0 
>  > dma 4096 in
>  > [1036724.000262]          res 40/00:00:00:78:00/00:00:00:00:00/10 Emask 
>  > 0x4 (timeout)
> ...
>  > at this time the only workaround is a reboot - i did not find any way 
>  > yet to reanimate the harddisc in this state.
>
> Two suggestions:
> 1. don't use libata.force
> 2. put the CF card and the PATA disk on separate channels with separate cables
>
>
>   

