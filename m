From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Second SATA disk is not recognized in kernel 2.6.x
Date: Mon, 25 Oct 2004 15:26:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041025062658d28930@mail.gmail.com>
References: <20041024.021758.130228080.masa@cs.osakafu-u.ac.jp>
	 <20041025.192404.59463574.masa@cs.osakafu-u.ac.jp>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:15551 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261801AbUJYN0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 09:26:06 -0400
Received: by rproxy.gmail.com with SMTP id 77so410083rnk
        for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 06:26:06 -0700 (PDT)
In-Reply-To: <20041025.192404.59463574.masa@cs.osakafu-u.ac.jp>
List-Id: linux-ide@vger.kernel.org
To: Masakazu Iwamura <masa@cs.osakafu-u.ac.jp>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 25 Oct 2004 19:24:04 +0900 (JST), Masakazu Iwamura
<masa@cs.osakafu-u.ac.jp> wrote:
> > I have a trouble which relates to serial ATA (libata). In summary, my
> > PC boots in kernel 2.4.27 with two SATA disks normally. But, in kernel
> > 2.6.x (I tested 2.6.8.1, 2.6.9), it boots with only one disk. The
> > second disk is not available. Are there any good idea to resolve this
> > problem?
> >
> > Actually, my PC has three SATA disks. One of them includes linux
> > system (the boot disk). The others construct a RAID by use of a
> > hardware RAID system "ARAID99 2000". So, BIOS recognizes there are two
> > disks. The RAID system includes my home directory only. The chipset of
> > the motherboard is ICH5R.
> >
> > In kernel 2.4.27, the first disk is recognized as /dev/hde and the
> > second one is as /dev/hdg. In kernel 2.6.x, the first disk is
> > recognized as /dev/sda. But, /dev/sdb does not appear (/dev/hdg is
> > also).
> 
> I also tested 2.6.10-rc1-bk2, 2.6.9-mm1 and 2.6.9-ac4 with almost the
> same configuration in 2.6.9.
> 
> 2.6.10-rc1-bk2 and 2.6.9-mm1 had the same problem as in 2.6.9.
> 
> In 2.6.9-ac4, the PC did not boot because of an error:
> atkbd.c: Spurious ACK on isa 0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> 
> I do not know the reason. I attached dmesg outputs in 2.4.27 and
> 2.6.10-rc1-bk2 after booting, and kernel configuration in
> 2.6.10-rc1-bk2.
> Could you please help me?

In 2.4.27 you are using IDE driver (not libata) for your SATA disks.

libata has problems with handling hw RAID connected to the second
SATA port (?), for now you can revert to using IDE driver, just disable
CONFIG_SCSI_SATA and enable CONFIG_BLK_DEV_IDE_SATA.

Bartlomiej
