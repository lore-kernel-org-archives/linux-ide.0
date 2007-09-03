From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 3 Sep 2007 11:40:13 +0100
Message-ID: <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com>
	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
	 <46DB755C.308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:4789 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbXICKkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 06:40:16 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1349269fkz
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 03:40:14 -0700 (PDT)
In-Reply-To: <46DB755C.308@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 03/09/07, Tejun Heo <htejun@gmail.com> wrote:
> > [    4.504000] ata1.00: ATA-0: SMI MODEL, 20070709, max MWDMA2
> > [    4.504000] ata1.00: 7928928 sectors, multi 0: LBA
> > [    4.504000] ata1.00: applying bridge limits
> > [    4.520000] ata1.00: configured for MWDMA2
> [--snip--]
> > [ 1301.836000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > [ 1301.836000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
> > cdb 0x0 data 65536 out
> > [ 1301.836000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
> > 0x4 (timeout)
> > ** End ***
> >
> > I can see that it falls back from MWDMA2 to MWDMA1, but it doesn't
> > fall back again to Single Word DMA?
>
> libata doesn't use SWDMA.  SWDMA is pointless to support.  It buys
> almost nothing over PIO modes.  The condition to fall back to PIO is
> very strict to prevent premature fall back.  I think it needs some
> relaxation and special handling for cases where DMA transfer has never
> succeeded after configuration so that it can fall back more easily.

Sorry, by SWDMA I meant PIO4 - and as the log shows - it does not seem
to drop from MWDMA1 to the PIO modes - even after about 15 minutes.

> > What is very strange also is that I can mount the NTFS drive just
> > fine, and copy 70Mb of files off it (pretty nippily, I might add =D) -
> > without any timeouts, but as soon as I tried to do something
> > "lowlevel" to the disk (i.e. as you may have spotted, I used gparted
> > to try and resize the NTFS partition, so I could try and run mkfs.ext3
> > again - which was what caused the timeouts when I originally tried to
> > install.
>
> Hmmm.. it could be that the timeouts occur only on write or are
> dependent on transfer size.  You should be able to find out what causes
> the timeouts by playing with dd with 'direct' added to iflag and oflag.

I'll look into that when I get home from work.

> > I can confirm that my chipset does indeed support UDMA, here is the
> > hdparm -I report on my original disk:
>
> Yeah, it's really difficult to come by a controller which doesn't
> support UDMA these days.

So from that, we can determine that the CF card doesn't support UDMA
(or if you're being optimistic like I am - it doesn't report it, or it
doesn't report it in a way which the controller recognises)

> > In regards to Windows performance: I have been using the tool HDTune
> > to see which mode the device is in - and it reports Multiword DMA 2.
> > Also, the benchmark facility with HDTune reveals that the burst speed
> > of the drive is 2MB - consistent with the hdparm -t speed when
> > ide-generic is used.
> >
> > Strangely enough, I've gone into Device Manager, and the transfer mode
> > Windows claims it is using is PIO, which seems to be contradictory to
> > what HDTune is telling me (and leads me to ask another question, I've
> > included in my reply to Alan) I've also tried to various registry
> > settings to try and force the device into UDMA or PIO, to no success -
> > as far as I can tell MWDMA may well be the lowest speed Windows XP
> > supports operating devices at?
>
> WXP uses PIO modes just fine.  I dunno how HDTune determines the current
> transfer mode but if it uses IDENTIFY to query the device setting, it's
> possible that the device reports MWDMA while the OS drives it in PIO
> mode.  The best way to tell is watching cpu usage while transferring
> data from the device.  If you're using mwdma, you won't see too high cpu
> usage; otherwise, you'll notice high spikes during data transfer.  Can
> you please try that and report?

Like I said before, the CF card is operating extremely slowly: HDTune
shows that I'm getting 2MB/s burst which often drops to about 0.1MB/s
- and the qualitative observation is the same as what I get when I'm
using ide-generic.

My X41 has a 1.5Ghz P4M, and a 0.1MB/s hit (if it is using PIO) is
hardly going to make a dent - I'm fairly sure that it is spending most
of its time waiting for IO, but I shall take a deeper look tonight.

I believe the transfer mode is set in the registry - though I've not
been able to find any documentation that explains their values. I've
tried guessing and setting some lower values/bits, but not had any
success.

What's confusing me is that my 40MB/s card only supporting MWDMA2 -
which offers only a max transfer rate of 16.7MB/s - how have other
people achieved 30MB/s then!?! (I'm referring to an ICH8 user who
claims he has here, with a very similar CF card:
http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/6818048.html

Also, does libATA support the PIO5 and PIO6 modes, which according to
Wikipedia are not part of the ATA standard, but the CF 2.0 standard?
(source: http://en.wikipedia.org/wiki/Programmed_input/output )

Many thanks,

Eddie
