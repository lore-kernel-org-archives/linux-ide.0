From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: poor sata performance on 2.6
Date: Fri, 16 Apr 2004 17:48:38 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200404150236.05894.kos@supportwizard.com> <200404152030.51052.vda@port.imtp.ilyichevsk.odessa.ua> <407F315E.2000809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:5125 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263229AbUDPOtZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Apr 2004 10:49:25 -0400
In-Reply-To: <407F315E.2000809@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Konstantin Sobolev <kos@supportwizard.com>, Justin Cormack <justin@street-vision.com>, Ryan Geoffrey Bourgeois <rgb005@latech.edu>, Kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Friday 16 April 2004 04:05, Jeff Garzik wrote:
> Denis Vlasenko wrote:
> > On Thursday 15 April 2004 17:48, Konstantin Sobolev wrote:
> >>On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> >>>On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
> >>>>On Thursday 15 April 2004 18:00, Justin Cormack wrote:
> >>>>>hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
> >>>>>and Seagate from the same controller. Can you send lspci,
> >>>>>/proc/interrupts and dmesg...
> >>>>
> >>>>Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned
> >>>>off.
> >>>
> >>>ah. Make a filesystem on it and mount it and try again. I see you have
> >>>no partition table and so probably no filesystem. This means the block
> >>>size is set to default 512byte not 4k which makes disk operations slow.
> >>>Any filesystem should default to block size of 4k, eg ext2.
> >>
> >>Very interesting!
> >>created partition table,
> >>kos sata # mkfs.ext2 /dev/sda1
> >>[..skipped..]
> >>kos mnt # cd /
> >>kos / # mkdir wd
> >>kos / # mount /dev/sda1 /wd
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:   82 MB in  3.03 seconds =  27.02 MB/sec
> >>
> >>kos / # mount | grep sda
> >>/dev/sda1 on /wd type ext2 (rw)
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:  206 MB in  3.02 seconds =  68.15 MB/sec
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:  206 MB in  3.02 seconds =  68.18 MB/sec
> >>
> >>So first time it gave the same loosy 27 MB/s and subsequent tests give
> >>pretty good 68 MB/s! Why?
> >
> > Time to CC ide/libata/block layer folks
> >
> > Jeff Garzik <jgarzik@pobox.com>
> > 	libata man
>
> It seems like the situation is already resolved, to me.
>
> When you mount a filesystem, it changes the default block size (512 or
> 1024) to the filesystem block size, normally 4096.  This would certainly
> increase the throughput.

Yes, this works.

But if one uses unpartitioned disk, why does (s)he need to
do some blocksize tricks before hdparm starts to measure good performance?
I think that in this case block layer can coalesce small read requests
into large ones regardless of block size.

Konstantin, does dd give you the same behaviour as hdparm?
--
vda

