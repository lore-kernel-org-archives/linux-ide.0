From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Buggy IDE / ATA drive on 2.6? DMA timeouts, 2.4 is fine
Date: Tue, 8 Nov 2005 14:17:13 +0100
Message-ID: <58cb370e0511080517p282b9c52l85ae6081f1616623@mail.gmail.com>
References: <1131453301.43709b75ddbbf@imp2-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:35483 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965025AbVKHNRP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Nov 2005 08:17:15 -0500
Received: by nproxy.gmail.com with SMTP id q29so162568nfc
        for <linux-ide@vger.kernel.org>; Tue, 08 Nov 2005 05:17:13 -0800 (PST)
In-Reply-To: <1131453301.43709b75ddbbf@imp2-g19.free.fr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rahul Siddharthan <rsidd@online.fr>
Cc: linux-ide@vger.kernel.org

On 11/8/05, Rahul Siddharthan <rsidd@online.fr> wrote:
> I have a HP Pavilion ze5385us laptop bought in 2003, which has a
> ALi15X3 IDE controller and a Toshiba MK6021GAS ATA disk.  For about
> two months, since an upgrade to kernel 2.6.10+, I'd been noticing
> occasional sluggishness with the laptop, and occasionally "DMA timeout"
> errors.  But until a week ago they were rather rare, and never occurred
> with the other kernel/OS's I have on the machine: Linux 2.4.27, Windows XP,
> DragonFly BSD.    The exact error is:
>
> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 (busy)
>
> ide: failed opcode was: unknown
> hda: DMA disabled
> ide0: reset: success
>
> Last night the timeouts became so severe to be unmanageable and started
> occurring under Linux 2.4 too (I was trying to burn a CD but these timeouts
> caused buffer underruns).  Soon both linux 2.4 and 2.6 became unbootable,
> and Windows XP too hung when booting.  I did manage to boot DragonFly
> (which takes a tiny fraction of the time ubuntu linux does), and this
> also constantly reported timeout errors (but didn't mention DMA).  The
> messages were:
>
> ad0: READ command timeout tag=0 serv=0 - resetting
> ata0: resetting devices .. ata0-slave: ATA identify retries exceeded
> done
>
> This morning I brought the laptop to back it up on a work machine, using
> DragonFly with the Linux partition mounted.  For about an hour the machine
> stumbled along, timing out and occasionally refusing to read directories,
> reporting read errors at particular sectors etc.
>
> Then suddenly all seemed to be ok and the remaining backup happened
> rapidly.  I was even able to back up the directories it refused to read earlier.
>
> Now I have been running the laptop on DragonFly and Linux 2.4 for about
> 3 hours each and there have been no problems whatever.  I even successfully
> burned a CD in dummy mode and then in real mode.
>
> I have no clue what's going on but I am convinced that the 2.6 IDE driver is
> somehow bad for my laptop.
>
> Any ideas?

http://smartmontools.sf.net
