From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx6 sata cdrom driver issue
Date: Thu, 28 May 2015 16:16:49 -0300
Message-ID: <CAOMZO5DzhSvvebTfzx3L1Gnwex8AXp3AQS2zPCBfcREKeARHKg@mail.gmail.com>
References: <5539101D.1020909@lenbrook.com>
	<15678294.L2fz4hMtva@wuerfel>
	<555B8B6D.2070500@lenbrook.com>
	<E4B483B64FC69D4292AD9E0D554A23A4098E96D6@FLINT.pickering.lenbrook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36666 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbbE1TQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 May 2015 15:16:51 -0400
Received: by lagv1 with SMTP id v1so39567908lag.3
        for <linux-ide@vger.kernel.org>; Thu, 28 May 2015 12:16:49 -0700 (PDT)
In-Reply-To: <E4B483B64FC69D4292AD9E0D554A23A4098E96D6@FLINT.pickering.lenbrook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Groeneveld <KGroeneveld@lenbrook.com>
Cc: Jonathan Bagg <JBagg@lenbrook.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Tejun Heo <tj@kernel.org>

On Tue, May 19, 2015 at 4:18 PM, Kevin Groeneveld
<KGroeneveld@lenbrook.com> wrote:
> -----Original Message-----
> From: Jonathan Bagg
> Sent: May-19-15 3:14 PM
>
>>Adding my co-worker Kevin who has done a few experiments in the kernel
>
> I am one of Jonathan's co-workers who has been helping to diagnose and
> fix the SATA issue we are experiencing.  Most of my testing has been
> with an optical drive connected directly to the Freescale Sabre board.
>
> Using the debug patch I wrote that Jon posted earlier I can see that the
> response to the ATAPI 0x4A command (Get Event Status Notification)
> during initial boot is always random. For example:
>
> [    2.237783] CDB rbuf: [4a 01 00 00 10 00 00 00 08]
> [    2.237789] CDB rbuf: 00000000: 7e 31 f7 fd ff f5 7d fd
> ~1....}.
>
> Running the same test on an iMX53 EVK board the response is always:
>
> [    2.452303] CDB rbuf: [4a 01 00 00 10 00 00 00 08]
> [    2.452308] CDB rbuf: 00000000: 00 06 04 56 02 02 00 00
> ...V....
>
> We have rented a Lecroy STX-231 SATA protocol analyzer. Using this tool
> I have verified that the response from the optical drive is always
> correct in this case but for some reason the data is corrupt by the time
> the debug code I added to atapi_qc_complete dumps the response.
>
> I have added debug code to dump the AHCI command header and table before
> issuing a command. I have not seen anything out of the ordinary here. I
> also added debug code to dump the received FIS on an interrupt. I
> haven't studied the received FIS extensively but I did not see anything
> out of the ordinary here either.
>
> One thing I suspected and confirmed with the Lecroy analyzer is that the
> response to the previous command during boot (ATAPI command 0x5A - Mode
> Sense) is always 64 bytes even though the kernel is requesting 128
> bytes. This exact behaviour is probably drive dependant.  On a hunch I
> modified the get_capabilities function in drivers/scsi/sr.c to only
> request 64 bytes. With that change the response to the Get Event Status
> Notification command during boot is always valid.  Although running
> cdparanoia or trying to keep using the system in other ways still
> results in issues.
>
> Using the Lecroy analyzer I found some other commands where cdparanoia
> requests lengths longer than the drive responds with.  Comparing the
> debug dumps in the kernel to the data captured by the analyzer I can see
> problems always start after this happens.
>
> To try and characterize this further I started messing around with the
> request lengths.  I noticed in the AHCI command header dumps I added
> that many of the ATAPI commands have a second SG DMA buffer. I found the
> second buffer is added when atapi_drain_needed returns true in
> libata-scsi.c.  I started hacking the DMA buffer sizes by manipulating
> the lengths written to the AHCI command table in the ahci_fill_sg
> function in libata.c.  I also hacked atap_drain_needed to sometimes
> return false to force only one DMA buffer for ATAPI commands.
>
> What I found is that if there are two DMA buffers and the response
> length is less than the first buffer size then the response to the next
> command is always corrupted.  Every other scenario I tried worked okay.
> Filling the first buffer and under, over or exactly using the second
> buffer does not trigger the issue.  If there is only one buffer under,
> over or exactly using the one buffer does not trigger the issue.
>
> One other thing I noticed is that if the response under runs the first
> buffer and the second ATAPI drain buffer is smaller than the next
> command response then the response to the next command is missing the
> begging of the response equal to the length of the second buffer from
> the previous command. I decided to add some debug code to print out the
> DMA buffer used for the previous command. What I found is that the
> missing part of the response is written to the DMA buffer from the
> previous command.  This is very bad as that memory could be dynamically
> allocated and subsequently freed and now in use by something else!
>
> Since overruns never seem to cause an issue in this setup I decided to
> simply change the atap_drain_needed function to always return false.
> With this change I can run cdparanoia successfully and rip audio tracks.
> I can also add a port multiplier back to the setup and connect both an
> HDD and the optical drive and experience no readily apparent issues.
>
> So it seems I have found a workaround for the most severe symptoms we
> were experiencing. But this still leaves me with several questions and
> concerns:
>
> 1. Is the root cause some obscure bug in the kernel I have not found
> yet? Or is it a hardware bug in the iMX6 AHCI SATA host? Or maybe
> something else silly we have been doing?
>
> 2. When cdparanoia is ripping the actual data it uses large reads which
> use multiple SG DMA buffers. What happens if the response is short in
> this case? My atapi_drain_needed hack won't help in this case.
> cdparanoia could probably be modified to only do smaller reads that fit
> in one page to avoid the issue.
>
> 3. Can the issue happen with non ATAPI commands?  If for any reason an
> ATA command to a HDD has a short response could all future commands (and
> possibly even system memory) be corrupted similar to what I saw with
> ATAPI commands? I wonder if the kernel could be easily modified to limit
> the size of ATA commands to avoid this scenario.
>
> 4. The Lecroy analyzer can also emulate a device. Using this mode I
> tried to trigger the issue with ATA commands. I couldn't figure out how
> to trigger the exact scenario I wanted.  I was able to cause the
> response to be too short, just not short enough to underrun anything but
> the last DMA buffer which doesn't seem to cause a problem.  What I did
> notice though was that this didn't seem to trigger an error anywhere in
> the kernel or user space, the data would just simply be corrupted. I
> would expect the system should flag the response as being invalid and an
> IO error propagated all the way to user space.

Just tested this and I could reproduce this bug on a mx6 board running
kernel 4.0.4.

Adding some more folks in case anyone has some ideas about this DMA
buffer corruption.

Regards,

Fabio Estevam
