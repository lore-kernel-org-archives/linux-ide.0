From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ahci timeouts, retries etc.
Date: Thu, 15 Oct 2009 18:52:41 -0600
Message-ID: <4AD7C3D9.9090805@gmail.com>
References: <4AD60194.8030106@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:50952 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737AbZJPAxV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Oct 2009 20:53:21 -0400
Received: by qyk2 with SMTP id 2so1148428qyk.21
        for <linux-ide@vger.kernel.org>; Thu, 15 Oct 2009 17:52:45 -0700 (PDT)
In-Reply-To: <4AD60194.8030106@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

On 10/14/2009 10:51 AM, Tim Small wrote:
> Hi,
>
> I have a Tyan S5375 (BIOS v1.03) ICH9 which periodically (approx twice a
> week) logs timeouts like this:
>
> [6475755.652262] ata2.00: exception Emask 0x0 SAct 0x3832 SErr 0x0
> action 0x6 frozen
> [6475755.652262] ata2.00: cmd 60/18:08:2a:90:ee/00:00:12:00:00/40 tag 1
> ncq 12288 in
> [6475755.652262] res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
> (timeout)
> [6475755.652262] ata2.00: status: { DRDY }
> [6475755.652262] ata2.00: cmd 61/60:20:6a:8c:ee/00:00:12:00:00/40 tag 4
> ncq 49152 out
> [6475755.652262] res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
> (timeout)
> ...
> [6475755.652262] ata2.00: cmd 60/10:68:6a:65:ee/00:00:12:00:00/40 tag 13
> ncq 8192 in
> [6475755.652262] res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
> (timeout)
> [6475755.652262] ata2.00: status: { DRDY }
> [6475755.652262] ata2: hard resetting link
> [6475756.009863] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [6475756.040731] ata2.00: configured for UDMA/133
> [6475756.040731] sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors
> (1000205 MB)
> [6475756.040731] sd 1:0:0:0: [sdb] Write Protect is off
> [6475756.040731] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [6475756.040731] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
>
>
> A look at the libata wiki suggests interrupt delivery problems as a
> possible explanation, but is this likely to be the case here? I'm
> guessing that multiple interrupts must have been dropped by the time
> this error has occurred, as multiple requests are queued for the drive?

Interrupt delivery doesn't seem too likely here - it normally either 
works or it doesn't, it doesn't randomly fail once in a while..

>
> I'm assuming that the kernel will retry these requests after the sata
> link has been reset?

Yes.

>
> The errors appear to be randomly distributed over the four drives on
> this machine - all are Seagate ST31000340NS with either firmware version
> SN05 or SN16...

This kind of problem often seems to be due to signal integrity or power 
problems. For whatever reason, an insufficient power supply (or 
something like overloading one power cable) can tend to trigger SATA 
errors as an early symptom..
