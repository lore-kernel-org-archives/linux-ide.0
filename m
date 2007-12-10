From: Tejun Heo <htejun@gmail.com>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 16:15:49 +0900
Message-ID: <475CE7A5.3060608@gmail.com>
References: <4750A523.7010501@clear.net.nz> <20071201001740.7ffce6f6@the-village.bc.nu> <4750CFB7.7040400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:9760 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbXLJHP5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 02:15:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1523982rvb
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 23:15:56 -0800 (PST)
In-Reply-To: <4750CFB7.7040400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Alan Cox wrote:
>>> The comment I saw, which I'm trying to verify, mentioned the SATA
>>> drives "held the bus" or similar longer than SAS ones.
>>
>> SATA normally uses one link per device so the device side isn't contended
>> unless you descend into the murky world of port multipliers. 
> ..
> 
> And that's where NCQ comes into it's own, allowing full bus release
> so that other drives on the same port multiplier can burst as needed.

Non-NCQ R/W does full bus release too.  It's basically packet based so
nothing really holds the bus.  Even the ATAPI commands don't hold the bus.

> I've only had a port multiplier here for a few days, and used only a pair
> of *notebook* SATA drives on it thus far.  Both drives can stream at full
> rate without any slowdown -- that's 55MByte/sec from each drive, at the
> same time, for sequential reading, 100MByte/sec total.  Notebook drives.

With FIS-based switching, PMP won't impose performance limits on most
configurations until it fills up the connection bandwidth.  Catches are...

1. All currently supported controllers have only upto 32 command slots
per port, which means all devices sharing a PMP will compete for command
slots.  This doesn't really matter unless the PMP is very large (say >
16 ports).

2. The only FIS-based switching controller we currently support is
sata_sil24.  It generally works impressively well.  Unfortunately, it
has some limitations - it for some reason can't fully fill the
bandwidth.  It seems the silicon itself is limited.  This problem is
reported on different operating systems too.  I don't remember the exact
number but it's somewhere between 100 and 150MB/s.

3. sil24/32 family controllers have another quirk which basically forces
command-switching mode for ATAPI devices, so if you connect an ATAPI
device to PMP, the ATAPI device virtually holds the bus while command is
in progress.

I have untested code for ahci 1.2 FIS-based switching PMP support and
the next gen JMB and ICHs are slated to support FIS-based switching.  I
just need more hardware samples and time which seems so scarce these
days.  :-P

Mark, how is marvell PMP support going?

Thanks.

-- 
tejun
