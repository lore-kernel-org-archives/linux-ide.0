From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 21:02:31 +0300
Message-ID: <45A52A37.7070602@ru.mvista.com>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com> <45A435A3.2020506@berlin.de> <45A4DAED.9070404@ru.mvista.com> <45A51259.2020904@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16834 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965003AbXAJSCd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 13:02:33 -0500
In-Reply-To: <45A51259.2020904@berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Bueker <m.bueker@berlin.de>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello.

Michael Bueker wrote:

>>    Then it's probably the same issue as here:

>> http://bugzilla.kernel.org/show_bug.cgi?id=7703

>>    What's really strange is that my HPT370 is working fine.  However, 
>> the chip marking says it's HPT370A despite the revision ID is 3 (which 
>> should correspond to HPT370)...

> Unfortunately, I'm unable to compile a 2.4.18 kernel (my gcc is probably
> too new) for testing.

> But anyways - do you think there's hope for fixing this? If I can
> provide you with any more helpful information, please tell me.

    Hope dies last. :-)
    Unfortunately, I don't have enough time to work on this, and the fact that
it's not locally reproducible also doesn't help.  I'll try to come up with
something to test but not very soon...

> My controller is:

> http://www.michael-bueker.de/files/hpt370/

> 01:09.0 Mass storage controller: Triones Technologies, Inc.
> HPT366/368/370/370A/372/372N (rev 03)
>         Subsystem: Triones Technologies, Inc. HPT370 UDMA100
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
> 
>> TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 
>         Latency: 120 (2000ns min, 2000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 9000 [size=8]
>         Region 1: I/O ports at 9400 [size=4]
>         Region 2: I/O ports at 9800 [size=8]
>         Region 3: I/O ports at 9c00 [size=4]
>         Region 4: I/O ports at a000 [size=256]
>         Expansion ROM at da020000 [disabled] [size=128K]

    Exactly what I have here but the chip marking is HPT370A. A bit puzzling...

> ~Mik

WBR, Sergei

