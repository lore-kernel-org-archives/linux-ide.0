From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 00:54:54 -0700
Message-ID: <20060829075454.GA22899@geeks.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:4058 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S1750726AbWH2Hy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 03:54:56 -0400
Content-Disposition: inline
In-Reply-To: <20060829045816.GA21746@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On Mon, Aug 28, 2006 at 09:58:16PM -0700, Derek Taubert wrote:
> On Tue, Aug 29, 2006 at 11:39:57AM +0900, Tejun Heo wrote:
> > The result doesn't seem to indicate any problem in libata or any storage 
> > related kernel subsystem.  I would track down the reader first.
> 
> This drive has only been partitioned; there is no filesystem on it.  So,
> it certainly isn't mounted anywhere.  There honestly isn't _anything_
> other than the dd going on to sda1, and that's the only partition on
> sda.
> 
> After starting dd:
> 
> # fuser -v /dev/sda1
> 
>                      USER        PID ACCESS COMMAND
> /dev/sda1            root      21753 f....  dd
> 
> avg-cpu:  %user   %nice    %sys %iowait   %idle
>            0.90    0.00   11.01   88.09    0.00
> 
> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> sda            1306.61      1295.60      1310.11      12943      13088

Another thought about this...

The sd cache_type is set to "write back" for this drive.  I suspect that
the reads are coming from the block driver attempting to fill lines.

# cat /sys/bus/scsi/devices/0:0:0:0/scsi_disk:0:0:0:0/cache_type
write back

Also, a problem here:

# echo "none" > /sys/bus/scsi/devices/0:0:0:0/scsi_disk:0:0:0:0/cache_type
echo: write error: invalid argument

dmesg says:

sda: Current: sense key: Illegal Request
    Additional sense: Invalid field in cdb

Derek
