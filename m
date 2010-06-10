From: "MadLoisae@gmx.net" <MadLoisae@gmx.net>
Subject: Fwd: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 - "dead" harddisc until reboot
Date: Thu, 10 Jun 2010 21:52:37 +0200
Message-ID: <4C114285.8050201@gmx.net>
Reply-To: MadLoisae@gmx.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000802000606090004000109"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759668Ab0FJTwl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jun 2010 15:52:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000802000606090004000109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

actually I am using kernel 2.6.34, up to now I was in every (stable) 
release since 2.6.30 affected by this issue.
Today I have reactivated legacy, regrettably deprecated parallel ATA 
support and have disabled libata. Its a  shame, libata is much faster 
(about 20% faster I/O measureable) and more forward-looking, but it is 
not a real alternative if it crashes continuous but not reproduceable on 
via-chipsets (google for this, the web is filled of this issue!). I 
know, via chipsets are not very good, but shouldn't we try to make it 
better (or at least best as possible) with newer drivers instead of worse?
I hope legacy ATA support won't be removed soon from the kernel sources ...

I like trying out a lot, but if the response is so thin it does not make 
fun just looking at the same issue with the same messages again and 
again not able to do anything beside looking at it and resetting the box 
afterwards ...

kind regards, Alois

--------------000802000606090004000109
Content-Type: message/rfc822;
 name="Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen - \"dead\" harddiscuntil reboot.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen ";
 filename*1="- \"dead\" harddisc until reboot.eml"

X-Mozilla-Keys: 
Message-ID: <4ADDC76F.60303@gmx.net>
Date: Tue, 20 Oct 2009 16:21:35 +0200
From: "MadLoisae@gmx.net" <MadLoisae@gmx.net>
Reply-To: MadLoisae@gmx.net
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen - "dead"
 harddisc until reboot
References: <4ADDB7A3.3020904@gmx.net> <19165.49281.905767.838696@pilspetsen.it.uu.se>
In-Reply-To: <19165.49281.905767.838696@pilspetsen.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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



--------------000802000606090004000109--
