From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: sata_mv Driver Problems Summery.
Date: Thu, 19 Jan 2006 14:12:08 +0100
Message-ID: <58cb370e0601190512t2169ec05l1bf20d80bf2900d9@mail.gmail.com>
References: <43CF697B.6040309@projecthugo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.205]:11232 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161137AbWASNML convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 08:12:11 -0500
Received: by uproxy.gmail.com with SMTP id s2so214657uge
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2006 05:12:09 -0800 (PST)
In-Reply-To: <43CF697B.6040309@projecthugo.co.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Darcy <kernel-lists@projecthugo.co.uk>
Cc: linux-ide@vger.kernel.org

Hi,

On 1/19/06, Matt Darcy <kernel-lists@projecthugo.co.uk> wrote:
> All,
>
> I/others have posted quite a few posts with regard to the sata_mv
> experimental driver included in the <2.6.15 kernels.
>
> I thought a breif summery and update of my personal experiences may
> benifit others contributing their own information and help keep a record
> of where things are up to.

Could you open a bug at http://bugzilla.kernel.org
and accumulate information there?

I think that I'm seeing that report 3rd time and each time
I have to read it entirely to verify if there is some new data.

Mails to the list are still fine but for people already knowing
background of the issue (this includes developers who are short
on time) the only thing is whether something have changed recently.

Thanks,
Bartlomiej

> First of all - I have been working through kernels and patches from
> 2.6.15-rc3 to 2.6.15-latestgit (at the last attempt it was git-11)
>
> I'm using  a Super Micro 8 port sata controller - which is displauyed as
>
> 00:0c.0 SCSI storage controller: Marvell Technology Group Ltd.
> MV88SX5081 8-port SATA I PCI-X Controller (rev 03)
>
> through out the 2.6.15 kernel progression I've seen this driver get more
> an more usable.
>
> Up until 2.6.15-rc5-mm3 the driver was unusable, I'just just get random
> hangs pretty much as soon as the disk was accessed.
>
> Post 2.6.15-rc5-mm3 the driver appeared usable, I've been able to use
> the disks as individual devices with quite reasonalbe performance
> (maxtor Diamond 10 250GB ATA disks) no data loss, and no real problems.
> I also did some basic tests using LVM2 which appears to work fine
> although performance did have a drop off, but hey the drivers still
> early so no problems.
>
> The configuration I want to use the driver in is to have a larage raid 5
> array thats within an lvm2 volume group. This should could me a bit of
> hardware resillience and the ability to manage file systems for my own
> project as they grow or new ones come along.
>
> The problem I have here, is that when I try to build a 7 disk array with
> 1 spare disk the array gets to around %30 completion and then hangs.
> this is with any kernal post 2.6.15-rc5-mm3.
>
> the machine just locks and hangs - no warnings, no logging no real
> indications any where.
> on occasion I do get errors within 2.6.15-rc5-mm3 during the raid creation.
>
> quick example
>
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c041321f>] mv_channel_reset+0xff/0x120
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c041327a>] mv_stop_and_reset+0x3a/0x60
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c04128ab>] mv_host_intr+0x13b/0x180
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c041298d>] mv_interrupt+0x9d/0x130
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c014080d>] handle_IRQ_event+0x3d/0x70
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c01408b6>] __do_IRQ+0x76/0x100
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c0105089>] do_IRQ+0x19/0x30
>
> Message from syslogd@berger at Fri Jan 13 20:59:05 2006 ...
> berger kernel:  [<c01033ee>] common_interrupt+0x1a/0x20
>
> the full output of this debug is in other posts from me
>
> on a little investigation myself and with someone input from others, I
> found that the through put on the actually building or the array gets to
> a point where it starts to slow very quickly until it gets so slow the
> machine hangs totally, and is unsable.
>
> [small example again]
> [=====>...............]  recovery = 29.6% (72787968/245111616)
> finish=153.4min speed=18720K/sec
> [=====>...............]  recovery = 29.7% (72971136/245111616)
> finish=153.2min speed=18717K/sec [=====>...............]  recovery =
> 29.8% (73139388/245111616) finish=157.3min speed=18210K/sec
> [=====>...............]  recovery = 29.8% (73139388/245111616)
> finish=208.1min speed=13769K/sec
> [=====>...............]  recovery = 29.8% (73139388/245111616)
> finish=258.9min speed=11069K/sec
> [=====>...............]  recovery = 29.8% (73139388/245111616)
> finish=309.6min speed=9254K/sec
>
> I then tried the same test setting the disks to half speed
> where it again did the same thing and died at almost exactly the same point.
> [=====>...............]  recovery = 29.8% (73139200/245111616)
> finish=251.8min speed=11381K/sec
>
> I've tried removing disks and replacing them with others, as the fact
> that it hung at the same point each time suggested a possible hardware
> issue, but I've had the same results using more/less disks, different disks.
>
> i've tried to watch the memory of the machine while the array is
> building, and it does go up and down a little, but it never really
> gradually falls in the same way that the disk throughput does.
>
> I'd love to see what the memory is when the box hangs but its just not
> possible.
>
> I've also tried partitioning the disks into smaller chunks as suggested,
> rather than 1x250gb partition per disk, and this too made no difference.
>
> I'd be interested in hearing how others have progressed with this situation.
>
> thanks
>
> Matt.
