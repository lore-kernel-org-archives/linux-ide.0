From: Michael Bueker <m.bueker@berlin.de>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 17:20:41 +0100
Message-ID: <45A51259.2020904@berlin.de>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com> <45A435A3.2020506@berlin.de> <45A4DAED.9070404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sour.ops.eusc.inter.net ([84.23.254.154]:59656 "EHLO
	sour.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbXAJQVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 11:21:24 -0500
In-Reply-To: <45A4DAED.9070404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Sergei Shtylyov wrote:
>    Then it's probably the same issue as here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7703
> 
>    What's really strange is that my HPT370 is working fine.  However, 
> the chip marking says it's HPT370A despite the revision ID is 3 (which 
> should correspond to HPT370)...

Unfortunately, I'm unable to compile a 2.4.18 kernel (my gcc is probably
too new) for testing.

But anyways - do you think there's hope for fixing this? If I can
provide you with any more helpful information, please tell me.

My controller is:

http://www.michael-bueker.de/files/hpt370/

01:09.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 03)
         Subsystem: Triones Technologies, Inc. HPT370 UDMA100
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 120 (2000ns min, 2000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 9000 [size=8]
         Region 1: I/O ports at 9400 [size=4]
         Region 2: I/O ports at 9800 [size=8]
         Region 3: I/O ports at 9c00 [size=4]
         Region 4: I/O ports at a000 [size=256]
         Expansion ROM at da020000 [disabled] [size=128K]

~Mik

-- 
Hey Fred, did you save that posting about restoring filesystems
with vi and a toothpick? More importantly, did you print it out?
- From "101 Things You Don't Want To Hear Your Admin Say"

