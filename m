From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: How to reread disk size?
Date: Sun, 21 Feb 2010 08:22:18 +0100
Message-ID: <1266736938.4414.9.camel@mulgrave.site>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
	 <4B805487.2010900@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44620 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab0BUHWh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Feb 2010 02:22:37 -0500
In-Reply-To: <4B805487.2010900@shiftmail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Asdo <asdo@shiftmail.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Sat, 2010-02-20 at 22:30 +0100, Asdo wrote:
> Robert Hancock wrote:
> >> [CUT]
> >> In the past I was doing:
> >>
> >> blockdev --rereadpt /dev/sdX
> >>
> >> and it usually worked on other controllers to reread the size visible
> >> from "blockdev --getsize" or "blockdev --getsize64". One time I think it
> >> even worked on exactly *that* controller... but it's not working now,
> >> it's strange.
> >>
> >> Is there a technique, or I am out of luck?
> >> The machine should not be rebooted
> >> I would even enter the size manually if possible: I know how many LBA
> >> blocks are in that disk.
> >
> > What dmesg output do you get when you do this?
> 
> with "this" I suppose you mean the blockdev --rereadpt?
> 
> This is the dmesg I get upon blockdev --rereadpt:
> 
> [508100.472337] sd 3:0:1:0: [sdr] 1465149168 512-byte hardware sectors 
> (750156 MB)
> [508100.472376] sd 3:0:1:0: [sdr] Write Protect is off
> [508100.472381] sd 3:0:1:0: [sdr] Mode Sense: 00 3a 00 00
> [508100.472412] sd 3:0:1:0: [sdr] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [508100.472418]  sdr: unknown partition table
> 
> 
> It rereads the wrong size, i.e. the one of the old disk :-(
> I am sure sdr is the correct disk, I even identified it by doing dd 
> if=/dev/sdr of=/dev/null and then looking at the activity led to confirm 
> it's the right drive. It should have read a size of 1TB.

What's happening is that libata is returning the old cached size to
READ_CAPACITY.  This would likely indicate some type of libata hotplug
failure ... the dmesg  across the unplug/plug would be useful for
diagnosing this.

James


