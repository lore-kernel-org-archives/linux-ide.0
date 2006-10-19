From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Question about Scsi error handling/recovery
Date: Thu, 19 Oct 2006 09:22:59 -0600
Message-ID: <8202f4270610190822g71992718ka17858321e2affb7@mail.gmail.com>
References: <8202f4270610181711k7b15f81bw589f956f6e521988@mail.gmail.com>
	 <4536D9FD.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:43408 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1946121AbWJSPlT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 11:41:19 -0400
Received: by py-out-1112.google.com with SMTP id z74so820022pyg
        for <linux-ide@vger.kernel.org>; Thu, 19 Oct 2006 08:40:46 -0700 (PDT)
In-Reply-To: <4536D9FD.4050708@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/18/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Hi,
> >
> > I tested two SATA drives on the same controller (Sil3124) and found
> > that if their hotplug/unplug sequences overlaps, scsi layer will block
> > the use of any of the drives during error recovery phase.  So even if
> > one drive is recovered way early, it won't process any commands until
> > the error recovery  on another drive is completed.  Could someone
> > explain why the block is on controller/host basis instead of on port
> > basis? Is this because the controller could be reset during any error
> > recovery?
>
> I don't think that's true.  Each ATA port is represented as separate
> host to SCSI midlayer, so SCSI doesn't have any way to enforce such
> cross-port synchronization.  In fact, libata needs to implement such
> facility to properly implement transfer mode reconfiguration on several
> controllers.  What exactly are you seeing?
>

Below is the relevant dmesg log when both drives were power cycled:
...

[14054.070000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
[14054.070000] ata1: (irq_stat 0x00a00080, device exchanged)
[14054.070000] ata1: hard resetting port
[14055.830000] ata2: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[14055.830000] ata2: (irq_stat 0x01100010, PHY RDY changed)
[14055.830000] ata2: hard resetting port
[14056.380000] ata2: SATA link down (SStatus 0 SControl 300)
[14056.380000] ata2: failed to recover some devices, retrying in 5 secs
[14056.790000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[14056.790000] ata1.00: ATA-7, max UDMA/100, 39070080 sectors: LBA48
NCQ (depth 1)
[14056.790000] ata1.00: configured for UDMA/100
[14056.790000] ata1: EH complete
[14056.790000]   Vendor: ATA       Model: ST920217AS        Rev: 3.01
[14056.790000]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[14056.790000] SCSI device sdb: 39070080 512-byte hdwr sectors (20004 MB)
[14056.790000] sdb: Write Protect is off
[14056.790000] sdb: Mode Sense: 00 3a 00 00
[14056.800000] SCSI device sdb: drive cache: write back
[14056.800000] SCSI device sdb: 39070080 512-byte hdwr sectors (20004 MB)
[14056.800000] sdb: Write Protect is off
[14056.800000] sdb: Mode Sense: 00 3a 00 00
[14056.810000] SCSI device sdb: drive cache: write back
[14056.810000]  sdb: unknown partition table
[14056.860000] sd 0:0:0:0: Attached scsi disk sdb
[14056.860000] sd 0:0:0:0: Attached scsi generic sg1 type 0
[14061.390000] ata2: hard resetting port
[14061.940000] ata2: SATA link down (SStatus 0 SControl 300)
[14061.940000] ata2: failed to recover some devices, retrying in 5 secs
[14066.950000] ata2: hard resetting port
[14067.500000] ata2: SATA link down (SStatus 0 SControl 300)
[14067.500000] ata2.00: disabled
[14068.010000] ata2: EH complete
[14068.010000] ata2.00: detaching (SCSI 1:0:0:0)

Note that it took less than 3 seconds for ata1 to be reconfigured as
sg1. My user space application opened sg1 for ioctl -
SCSI_IOCTL_GET_BUS_NUMBER once it's available but got block for around
11 seconds.  It seems the ioctl call was unblocked until the error
recovery on ata2 was completed at time stamp 14068.  I suspect it's
blocked in the scsi_ioctl.c:
int scsi_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
{
	char scsi_cmd[MAX_COMMAND_SIZE];

	/* No idea how this happens.... */
	if (!sdev)
		return -ENXIO;

	/*
	 * If we are in the middle of error recovery, don't let anyone
	 * else try and use this device.  Also, if error recovery fails, it
	 * may try and take the device offline, in which case all further
	 * access to the device is prohibited.
	 */
	if (!scsi_block_when_processing_errors(sdev))
		return -ENODEV;
...
}

If the ioctl() on sg1/ata1 was not blocked due to ata2 error recovery,
then where it could be blocked?

Thanks,
Fajun
