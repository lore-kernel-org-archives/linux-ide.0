Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83821764D
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436669; cv=none; b=tpAGQFGUbocQny5wgrzNApNry1JgvhL657PLRetwBZcmw83xacYTrLkQOzt1Q7j7fa6gNtAqCmC8yu/He3VDKni7pRJfpcgKloPxAy8KAhUrj6YFKM1Bm1QGRWMKpmA1WS3dCmfDLxpv6j+O7XTKr1bAXDokz5U4oAkPq8XmkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436669; c=relaxed/simple;
	bh=kHf5DPFQTi5uZ4eOf4sa4M7LPKXeDq5LegsA6EX6zhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+lniPGpl5DCFefgUa2yfcJrHku2hYv1XAWG8K9yLzd4KDeQjSqB3Hm7qO3T36cG0GVuZF+RyFxqZ11ctkI4bqSQZuORwZQdInJ7ISt9DFZmX4gVm5Hnsi/LdjusdPbfexMK6OuWfcxdo2QVP9D4WAYmd+fjo6o5tpPsNAwGhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=Xsg3eBzW; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="Xsg3eBzW"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id D9C2CBD152;
	Thu,  9 Jan 2025 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1736436665;
	bh=kHf5DPFQTi5uZ4eOf4sa4M7LPKXeDq5LegsA6EX6zhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xsg3eBzWb/NJEH050GNmpaRPZWAQHqbk/j+qAG5VNVxUO2paSDQYxQVu8xuGA2058
	 or1N5b6fH7ztOGHc3lf2mi/JrvHrsUajk9ERuxsPKDtTphN/k9QUVrpOYG8s7hcvmj
	 JBhdfcBuAs64NwKva6WUTQyjuj6Tk4lhLrBp2lLo=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 6892B2C0044;
	Thu,  9 Jan 2025 15:31:05 +0000 (GMT)
Message-ID: <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
Date: Thu, 9 Jan 2025 15:31:05 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z3-_dt0m_2UrtKon@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/01/2025 12:22, Niklas Cassel wrote:
> Hello Philip,
> 
> +linux-ide
> 
> On Wed, Jan 08, 2025 at 03:22:32PM +0000, Philip Pemberton wrote:
>> On 08/01/2025 14:05, Niklas Cassel wrote:
>>> Since we see that the drive name is printed, the ATAPI IDENTIFY command
>>> succeded (ATA_CMD_ID_ATAPI (0xA1)).
>>>
>>> The command that timed out is ATA_CMD_PACKET 0xA0, so a regular ATAPI command.
>>
>> Aha - I'd tried to debug that, but thought it was a SCSI command code, not
>> an ATA one.
>>
>> Is there a way to find out what CDB or ATAPI packet was sent to the drive?
>> If necessary I can probably build a custom kernel and add some printk()'s
>> but I'm hoping I don't need to!
> 
> If your kernel is built with trace events, you can do:
> 
> $ sudo mount -t tracefs nodev /sys/kernel/tracing

Seems like it is -- that was already mounted!

> $ sudo sh -c "echo 1 > /sys/kernel/tracing/events/libata/ata_qc_issue/enable"
> 
> $ sudo cat /sys/kernel/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 2/2   #P:32
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>      kworker/23:1-333     [023] d..1.   428.789473: ata_qc_issue: ata_port=2 ata_dev=0 tag=6 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>      kworker/11:1-321     [011] d..1.   430.837460: ata_qc_issue: ata_port=2 ata_dev=0 tag=23 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)

Here's the output I got. I've filtered out accesses to "ata_port=3" 
only, which is the Zip drive. (I had a lot of noise from "ata_port=4" 
which would be the DVD writer).

>        scsi_eh_2-219     [004] d..1. 86237.729018: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [006] d..1. 86237.735641: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_NODATA cmd=ATA_CMD_SET_FEATURES  tf=(ef/03:08:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [006] d..1. 86237.735928: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [006] d..1. 86237.742645: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_NODATA cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [006] d..1. 86237.743196: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_DMA cmd=ATA_CMD_PACKET  tf=(a0/05:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [011] d..1. 86243.440867: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [011] d..1. 86243.447703: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_NODATA cmd=ATA_CMD_SET_FEATURES  tf=(ef/03:08:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [011] d..1. 86243.448006: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [011] d..1. 86243.454721: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_NODATA cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [011] d..1. 86243.455272: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_DMA cmd=ATA_CMD_PACKET  tf=(a0/05:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [005] d..1. 86249.072704: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [005] d..1. 86249.079384: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_NODATA cmd=ATA_CMD_SET_FEATURES  tf=(ef/03:08:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [005] d..1. 86249.079656: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [005] d..1. 86249.086320: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_NODATA cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [005] d..1. 86249.086879: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_DMA cmd=ATA_CMD_PACKET  tf=(a0/05:00:00:00:00/00:00:00:00:00/a0)

The ~5-second delay between tries is about what I was seeing on the SATA 
adapter's activity LED.


This is the sort of noise I was getting for the DVD drive:

>    kworker/u64:2-243835  [006] d..1. 86250.016698: ata_qc_issue: ata_port=4 ata_dev=0 tag=3 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:1-244660  [009] d..1. 86252.064637: ata_qc_issue: ata_port=4 ata_dev=0 tag=16 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:1-244660  [006] d..1. 86254.112578: ata_qc_issue: ata_port=4 ata_dev=0 tag=4 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:1-244660  [004] d..1. 86256.160522: ata_qc_issue: ata_port=4 ata_dev=0 tag=31 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:2-243835  [009] d..1. 86258.208459: ata_qc_issue: ata_port=4 ata_dev=0 tag=19 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:8-242224  [008] d..1. 86260.256431: ata_qc_issue: ata_port=4 ata_dev=0 tag=23 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:8-242224  [002] d..1. 86262.304358: ata_qc_issue: ata_port=4 ata_dev=0 tag=15 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:8-242224  [003] d..1. 86264.352310: ata_qc_issue: ata_port=4 ata_dev=0 tag=15 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)

I think it's probably just small sector reads or status polls to see if 
the disc has changed, and not relevant to the Zip drive. Just 
interesting to see it :)


> For most regular ATA commands, the SCSI CDB that is received from the upper
> layer (SCSI) is translated to an ATA command, and so the CDB is not written
> to the device.
> 
> But for an ATA_CMD_PACKET ATAPI command, it just encapsulates the CDB as is,
> within the ATA_CMD_PACKET... interesting design...
> 
> If you want to dump the CDB, you also need to do:
> $ sudo sh -c "echo 1 > /sys/kernel/tracing/events/scsi/scsi_dispatch_cmd_start/enable"
> 
>       kworker/7:2-811     [007] .....   103.163426: scsi_dispatch_cmd_start: host_no=1 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=11 scheduler_tag=61 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>       kworker/7:2-811     [007] d..1.   103.163429: ata_qc_issue: ata_port=2 ata_dev=0 tag=11 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>      kworker/18:1-331     [018] .....   105.211404: scsi_dispatch_cmd_start: host_no=1 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=4 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>      kworker/18:1-331     [018] d..1.   105.211406: ata_qc_issue: ata_port=2 ata_dev=0 tag=0 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)

I'm pretty sure there's some noise from the CD drive in here (TEST UNIT 
READY seems like something you'd do to poll for disc presence). I don't 
see any CDBs specific to the Zip drive though:

>        scsi_eh_2-219     [001] d..1. 86654.149985: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86654.156717: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_NODATA cmd=ATA_CMD_SET_FEATURES  tf=(ef/03:08:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86654.157027: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86654.163739: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_NODATA cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86654.164286: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_DMA cmd=ATA_CMD_PACKET  tf=(a0/05:00:00:00:00/00:00:00:00:00/a0)
>    kworker/u64:8-242224  [011] ..... 86654.229960: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=3 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/11:1H-191     [011] ..... 86654.232462: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/10:1H-195     [010] ..... 86654.234515: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=1 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:2-243835  [003] ..... 86654.293953: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=2 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:2-243835  [006] ..... 86655.317932: scsi_dispatch_cmd_start: host_no=7 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:1-244660  [000] ..... 86655.509932: scsi_dispatch_cmd_start: host_no=3 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=31 scheduler_tag=15 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>    kworker/u64:1-244660  [000] d..1. 86655.509943: ata_qc_issue: ata_port=4 ata_dev=0 tag=31 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:1-244660  [000] ..... 86656.277913: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>     kworker/0:1H-196     [000] ..... 86656.280741: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=1 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/11:1H-191     [011] ..... 86656.282924: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=3 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [000] ..... 86656.341898: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=2 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [006] ..... 86657.365885: scsi_dispatch_cmd_start: host_no=7 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:2-243835  [011] ..... 86657.558879: scsi_dispatch_cmd_start: host_no=3 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=9 scheduler_tag=43 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>    kworker/u64:2-243835  [011] d..1. 86657.558889: ata_qc_issue: ata_port=4 ata_dev=0 tag=9 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>    kworker/u64:2-243835  [000] ..... 86658.325849: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=3 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>     kworker/6:1H-192     [006] ..... 86658.328070: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>     kworker/7:1H-204     [007] ..... 86658.330167: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=1 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [007] ..... 86658.390842: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=2 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [010] ..... 86659.413818: scsi_dispatch_cmd_start: host_no=7 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:2-243835  [000] ..... 86659.605846: scsi_dispatch_cmd_start: host_no=3 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=6 scheduler_tag=16 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>    kworker/u64:2-243835  [000] d..1. 86659.605855: ata_qc_issue: ata_port=4 ata_dev=0 tag=6 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86659.685828: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86659.692572: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_NODATA cmd=ATA_CMD_SET_FEATURES  tf=(ef/03:08:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [004] d..1. 86659.692866: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATA_PROT_PIO cmd=ATA_CMD_ID_ATAPI  tf=(a1/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86659.699575: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_NODATA cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:00:00/00:00:00:00:00/a0)
>        scsi_eh_2-219     [001] d..1. 86659.700126: ata_qc_issue: ata_port=3 ata_dev=0 tag=32 proto=ATAPI_PROT_DMA cmd=ATA_CMD_PACKET  tf=(a0/05:00:00:00:00/00:00:00:00:00/a0)
>    kworker/u64:2-243835  [006] ..... 86660.373797: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=3 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>     kworker/6:1H-192     [006] ..... 86660.376058: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/10:1H-195     [010] ..... 86660.378167: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=1 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [009] ..... 86660.437787: scsi_dispatch_cmd_start: host_no=8 channel=0 id=0 lun=2 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=0 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:8-242224  [009] ..... 86661.461766: scsi_dispatch_cmd_start: host_no=7 channel=0 id=0 lun=0 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=0 scheduler_tag=1 cmnd=(TEST_UNIT_READY - raw=00 00 00 00 00 00)
>    kworker/u64:2-243835  [006] ..... 86661.653786: scsi_dispatch_cmd_start: host_no=3 channel=0 id=0 lun=0 data_sgl=2 prot_sgl=0 prot_op=SCSI_PROT_NORMAL driver_tag=6 scheduler_tag=14 cmnd=(0x4a - raw=4a 01 00 00 10 00 00 00 08 00)
>    kworker/u64:2-243835  [006] d..1. 86661.653795: ata_qc_issue: ata_port=4 ata_dev=0 tag=6 proto=ATAPI_PROT_PIO cmd=ATA_CMD_PACKET  tf=(a0/00:00:00:08:00/00:00:00:00:00/a0)

(Repeating myself here, ata4 / ata_port=4 is the DVD drive; ata_port=3 
is the Zip drive)

There's quite a lot on the ATA buses, so if it helps --
   ata1: Samsung 860 SSD
   ata2: WD 500GB mechanical hard drive
   ata3: Spare port / Zip drive
   ata4: DVD writer
   ata5: Not used
   ata6: Not used

There are a couple of SATA disks and a SAS tape drive on an LSI SAS card 
but they seem to go through the "scsi" and "mpt2sas" driver route.


> Note that for ATAPI, it also looks like your SATA driver needs special support.
> See e.g. libahci.c which does a bunch of extra stuff if it is an ATAPI device,
> e.g.:
> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1699-L1702
> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1638-L1643
> 
> Same for the libata-sff driver:
> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L2672-L2684
> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L295-L297
> https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L687-L715
> 
> 
> Which SATA driver are you using?

It looks like it's "ahci" or "libahci".


> Are you saying that it does come up and work eventually?
> 
> When we see the "disable device" print, it is usually a sign that we have
> given up, and thus remove the device.

No, it tries to connect three times, then gives up and disables the device.

It won't try again unless the drive is hotplugged or the machine 
rebooted. I expect there's probably a route to reset the SATA port 
through sysfs too, but I haven't really looked closely at that.

Thanks.
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
