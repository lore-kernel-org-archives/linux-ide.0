From: Justin Cormack <justin@street-vision.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 16:08:12 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1082041692.19571.82.camel@lotte.street-vision.com>
References: <200404150236.05894.kos@supportwizard.com>
	 <200404151826.54488.kos@supportwizard.com>
	 <1082039593.19568.75.camel@lotte.street-vision.com>
	 <200404151848.05857.kos@supportwizard.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tench.street-vision.com ([212.18.235.100]:50359 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264159AbUDOPIS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Apr 2004 11:08:18 -0400
In-Reply-To: <200404151848.05857.kos@supportwizard.com>
List-Id: linux-ide@vger.kernel.org
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2004-04-15 at 15:48, Konstantin Sobolev wrote:
> On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> > On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
> > > On Thursday 15 April 2004 18:00, Justin Cormack wrote:
> > > > hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
> > > > and Seagate from the same controller. Can you send lspci,
> > > > /proc/interrupts and dmesg...
> > >
> > > Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned off.
> >
> > ah. Make a filesystem on it and mount it and try again. I see you have
> > no partition table and so probably no filesystem. This means the block
> > size is set to default 512byte not 4k which makes disk operations slow.
> > Any filesystem should default to block size of 4k, eg ext2.
> 
> Very interesting!
> created partition table,
> kos sata # mkfs.ext2 /dev/sda1
> [..skipped..]
> kos mnt # cd /
> kos / # mkdir wd
> kos / # mount /dev/sda1 /wd
> kos / # hdparm -t -a8192 /dev/sda
> 
> /dev/sda:
>  setting fs readahead to 8192
>  readahead    = 8192 (on)
>  Timing buffered disk reads:   82 MB in  3.03 seconds =  27.02 MB/sec
> 
> kos / # mount | grep sda
> /dev/sda1 on /wd type ext2 (rw)
> kos / # hdparm -t -a8192 /dev/sda
> 
> /dev/sda:
>  setting fs readahead to 8192
>  readahead    = 8192 (on)
>  Timing buffered disk reads:  206 MB in  3.02 seconds =  68.15 MB/sec
> kos / # hdparm -t -a8192 /dev/sda
> 
> /dev/sda:
>  setting fs readahead to 8192
>  readahead    = 8192 (on)
>  Timing buffered disk reads:  206 MB in  3.02 seconds =  68.18 MB/sec
> 
> So first time it gave the same loosy 27 MB/s and subsequent tests give pretty 
> good 68 MB/s! Why?

Ah yes, I noticed that once or twice. Not sure what the reason is. It
may be something to do with how hdparm tries to deal with bypassing the
vm, or how the scsi layer deals with block size changes or something. I
wouldnt worry. It only happens if you do hdparm ever when the block size
is 512bytes. 68MB/s is pretty nice. Was thinking of getting some of
those drives.

Justin


