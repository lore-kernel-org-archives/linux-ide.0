Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D620551B
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425341; cv=none; b=n2r/xfvFI5yr5/xip4f/cS9fKiGPLw49o73bycG3uDN9WgxT4VKNWTu8AQEt9Npif3OK+sjj0WOA1ggf4DcubFI3dO/TpXyzd4WryQBpBdAL75gtahLsy13CTgx8QNoeTZAjOHbIdPZsFW9j9EWULzR+mQVttcHZfYh7Ss8yOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425341; c=relaxed/simple;
	bh=ACJlJS5qL4pPJHlMnrHHYCWoTmKm3EStAM02x2HDbgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPJdnulwNDd8fITsBJ1uuRK0wbDHSUCnsGRyRNPjHxkyGBMVlq6eYVzyKaxBg9pLhiNgEcWemnY4CI4vFgE+IY1fxsu4c0kaoYL28OOHElDnGggXxy/wps20qVhcZuJnW931qq+ykkMfVtNpuQ/BypgBcNxJY1CIP/HQqDRDExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWskArS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWskArS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B20C4CED2;
	Thu,  9 Jan 2025 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736425338;
	bh=ACJlJS5qL4pPJHlMnrHHYCWoTmKm3EStAM02x2HDbgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWskArS3sUeVtym02BHo6Iqw/Rv2oXNafBmZHWfGpN28KYVp8T+NFZ5Wqa7qxFObL
	 GF57PN6mEjjoFmKpiE/UadqmPAc24yL6oGKNiYrFqp+Eu8dEC3tZs31Y5roQD9WgUP
	 gHmyXTUH9SIRdGeBcvfJ6cAaIPwUv4v+scdL5L4JwA32qsSKkIRF86SwbrFK2LZVlB
	 QwirrQIqPwZkF0wj97kDn5oiMZZtM+RYemOPSV5q9ZdfmxcGUN7GgMnEnxgk0aaepT
	 lIsii4MaA3zEKzjh7Gt5o5PaIgOIuMPeGWK04vPa1+qTQV01ypu3M6uUctDaPIhssi
	 Uy+P7bP2vL8GA==
Date: Thu, 9 Jan 2025 13:22:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z3-_dt0m_2UrtKon@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>

Hello Philip,

+linux-ide

On Wed, Jan 08, 2025 at 03:22:32PM +0000, Philip Pemberton wrote:
> On 08/01/2025 14:05, Niklas Cassel wrote:
> > Since we see that the drive name is printed, the ATAPI IDENTIFY command
> > succeded (ATA_CMD_ID_ATAPI (0xA1)).
> >
> > The command that timed out is ATA_CMD_PACKET 0xA0, so a regular ATAPI command.
>
> Aha - I'd tried to debug that, but thought it was a SCSI command code, not
> an ATA one.
>
> Is there a way to find out what CDB or ATAPI packet was sent to the drive?
> If necessary I can probably build a custom kernel and add some printk()'s
> but I'm hoping I don't need to!

If your kernel is built with trace events, you can do:

$ sudo mount -t tracefs nodev /sys/kernel/tracing

$ sudo sh -c "echo 1 > /sys/kernel/tracing/events/libata/ata_qc_issue/enable"

$ sudo cat /sys/kernel/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:32
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/23:1-333     [023] d..1.   428.789473: ata_qc_issue: ata_port=2 ata_dev=0 tag=6 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
    kworker/11:1-321     [011] d..1.   430.837460: ata_qc_issue: ata_port=2 ata_dev=0 tag=23 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)



For most regular ATA commands, the SCSI CDB that is received from the upper
layer (SCSI) is translated to an ATA command, and so the CDB is not written
to the device.

But for an ATA_CMD_PACKET ATAPI command, it just encapsulates the CDB as is,
within the ATA_CMD_PACKET... interesting design...

If you want to dump the CDB, you also need to do:
$ sudo sh -c "echo 1 > /sys/kernel/tracing/events/scsi/scsi_dispatch_cmd_start/enable"

     kworker/7:2-811     [007] .....   103.163426: scsi_dispatch_cmd_start: host_no=1 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=11 scheduler_tag=61 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
     kworker/7:2-811     [007] d..1.   103.163429: ata_qc_issue: ata_port=2 ata_dev=0 tag=11 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
    kworker/18:1-331     [018] .....   105.211404: scsi_dispatch_cmd_start: host_no=1 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=4 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
    kworker/18:1-331     [018] d..1.   105.211406: ata_qc_issue: ata_port=2 ata_dev=0 tag=0 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)


Note that you could also enable the trace events using the kernel command line,
if you so prefer, by simply appending:
trace_event=libata:ata_qc_issue,scsi:scsi_dispatch_cmd_start


Note that for ATAPI, it also looks like your SATA driver needs special support.
See e.g. libahci.c which does a bunch of extra stuff if it is an ATAPI device,
e.g.:
https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1699-L1702
https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1638-L1643

Same for the libata-sff driver:
https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L2672-L2684
https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L295-L297
https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L687-L715


Which SATA driver are you using?



> > The UNIT ATTENTION print is just from atapi_eh_clear_ua(), which seems to be
> > called by ata_eh_recover() unconditionally for ATAPI devices, because they
> > always need to clear UNIT ATTENTION after a reset:
> > https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-eh.c#L3232-L3234
> >
> > But the reset is of course only triggered because a command has timed out.
>
> I wouldn't be surprised if the failure to clear Unit Attention turned out to
> be a quirk in the Zip 100 ATAPI's ATA/ATAPI or SCSI implementation. They
> were known 'in the day' to have a few bugs [1] [2].
>
> In any case the SATA bus reset (see larger log) sequence seems to get it
> talking again, though obviously it's not ideal.

There are the prints from the larger log sequence:


[ 4465.225787] ata3.00: configured for PIO0
[ 4470.419775] ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
[ 4470.419794] ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)
[ 4470.883747] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 4470.890363] ata3.00: dumping IDENTIFY data, class=3 may_fallback=1
tried_spinup=0
(...)
[ 4470.890500] ata3.00: FORCE: xfer_mask set to pio0
[ 4470.897720] ata3.00: dumping IDENTIFY data, class=3 may_fallback=1
tried_spinup=0
(...)
[ 4470.897858] ata3.00: configured for PIO0
[ 4476.051591] ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
[ 4476.051607] ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)
[ 4476.515583] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 4476.522296] ata3.00: dumping IDENTIFY data, class=3 may_fallback=1
tried_spinup=0
(...)
[ 4476.522409] ata3.00: FORCE: xfer_mask set to pio0
[ 4476.529541] ata3.00: dumping IDENTIFY data, class=3 may_fallback=1
tried_spinup=0
(...)
[ 4476.529743] ata3.00: configured for PIO0
[ 4481.683441] ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
[ 4481.683457] ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)
[ 4481.683461] ata3.00: disable device
[ 4482.147601] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)


Are you saying that it does come up and work eventually?

When we see the "disable device" print, it is usually a sign that we have
given up, and thus remove the device.


>
>
> FWIW, the drive I have is the ATAPI3 model variant, with 12.A firmware.
> The pages I linked mention a "drive A:" mode - I tried that, but all it did
> was change part of the IDENTIFY response to read "FLOPPY".
>
>
>
> [1]. <https://web.archive.org/web/20030207213746/http://iomega.com/software/betapatch.html>
>
> [2]. <https://web.archive.org/web/20030212130255/http://pw2.netcom.com/~deepone/zipjaz/atapi.html>
>
> Thanks
> --
> Phil.
> philpem@philpem.me.uk
> https://www.philpem.me.uk/
