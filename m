From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PDC20267 bug and corruption (was: Re: [BK PATCHES] ide-2.6 update)
Date: Sat, 30 Oct 2004 20:06:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04103011065c265ce4@mail.gmail.com>
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <20041027133431.GF1127@zip.com.au>
	 <58cb370e04102706512283405@mail.gmail.com>
	 <20041030034745.GA1287@zip.com.au>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:33716 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261248AbUJ3SGM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 14:06:12 -0400
Received: by rproxy.gmail.com with SMTP id 77so32200rnk
        for <linux-ide@vger.kernel.org>; Sat, 30 Oct 2004 11:06:12 -0700 (PDT)
In-Reply-To: <20041030034745.GA1287@zip.com.au>
List-Id: linux-ide@vger.kernel.org
To: CaT <cat@zip.com.au>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 13:47:45 +1000, CaT <cat@zip.com.au> wrote:
> On Wed, Oct 27, 2004 at 03:51:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > http://bugme.osdl.org/show_bug.cgi?id=2494
> 
> Tried it via bk7, wasn't it.
> 
> Looks like I have found a bug relating to the pdc driver though.
> 
> The situation is such: I have 2 HDs connected to a PDC20267 PCI card,
> one on each channel, with a master on the primary channel and a slave on
> the secondry channel. Accessing each drive individually causes no
> problems at all but accessing them simultaneously (like copying data off
> one drive onto the other) causes the IDE layer to go to hell in a hand
> basket. I can duplicate this each and every time by doing the following:
> 
> 1. copying a few gig from hde to hdh
> 2. dd if=/dev/hde of=/dev/null
>    dd if=/dev/zero of=/dev/hdh
> 
> With method #1 I get the following:
> 
> Oct 27 00:37:39 nessie kernel: attempt to access beyond end of device
> Oct 27 00:37:39 nessie kernel: hdh1: rw=1, want=3034756264, limit=390716802
> Oct 27 00:37:40 nessie kernel: Aborting journal on device hdh1.
> Oct 27 00:37:40 nessie kernel: ext3_abort called.
> Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1): ext3_journal_start: Detected aborted journal
> Oct 27 00:37:40 nessie kernel: Remounting filesystem read-only
> Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1) in start_transaction: Journal has aborted

This comes from the block layer, generic_make_request(),
request is screwed up before it hits IDE layer.

> With method #2, a whole lot more fun occurs. The logfile I have is big
> (almost 400k) so I've compressed it and included it as an attachment.
> This is with kernel 2.6.10-rc1-bk7 (no logs survived from me testing
> this with rc1-mm2).

Indeed, this is a lot more fun. ;)

Is this bug new/old?

Is it pdc202xx_old specific?  Does the same havoc happen
if you connect drives to the on-board Intel IDE controller?

Please post /proc identify data for both drives and PCI config
space dump for PDC20267 so someone can verify them.
