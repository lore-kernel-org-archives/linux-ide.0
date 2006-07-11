From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Tue, 11 Jul 2006 10:30:01 +0800
Message-ID: <44B30D29.5090805@tw.ibm.com>
References: <20060630025341.GA4675@kroah.com> <20060630044912.GA2592@htj.dyndns.org> <20060630052021.GA4722@kroah.com> <20060630052633.GF23844@htj.dyndns.org> <20060630221052.GA4196@kroah.com> <44AFCCFD.8050708@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:44468 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965082AbWGKCaP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 22:30:15 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6B2UEjh007681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 22:30:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6B2UEoo176996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 20:30:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6B2UDXU027222
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 20:30:14 -0600
In-Reply-To: <44AFCCFD.8050708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Doug Maxey <dwm@enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Greg KH wrote:
> 
>> Sure, here's the logs for when I boot 2.6.17 with your patch:
> 
> [--snip--]
> 
>> [4294672.044000] ata_piix 0000:00:1f.2: version 1.05
>> [4294672.044000] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
>> [4294672.048000] ata_piix 0000:00:1f.2: invalid MAP value 0
>> [4294672.052000] ata_pci_init_one: ENTER
>> [4294672.055000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
>> low) -> IRQ 18
>> [4294672.059000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
>> [4294672.059000] ata_device_add: ENTER
>> [4294672.063000] ata_host_add: ENTER
>> [4294672.067000] ata_port_start: prd alloc, virt f7e55000, dma 37e55000
>> [4294672.070000] ata1: SATA max UDMA/133 cmd 0x1498 ctl 0x140E bmdma
>> 0x1480 irq 18
>> [4294672.074000] ata_host_add: ENTER
>> [4294672.078000] ata_port_start: prd alloc, virt f7cfb000, dma 37cfb000
>> [4294672.081000] ata2: SATA max UDMA/133 cmd 0x1490 ctl 0x140A bmdma
>> 0x1488 irq 18
>> [4294672.085000] ata_device_add: probe begin
>> [4294672.089000] ata_device_add: ata1: bus probe begin
>> [4294672.093000] piix_sata_probe: ata1: ENTER, pcs=0x11 base=0
>> [4294672.198000] piix_sata_probe: ata1: LEAVE, pcs=0x11 present_mask=0x1
>> [4294672.201000] ata_std_softreset: ENTER ata1
>> [4294672.205000] ata_std_softreset: about to softreset, devmask=3
>> [4294672.209000] ata_bus_softreset: ata1: bus reset via SRST
>> [4294672.364000] ata_dev_classify: found ATAPI device by sig
>> [4294672.367000] ata_dev_classify: found ATAPI device by sig
>> [4294672.371000] ata_std_softreset: EXIT, classes[0]=3 [1]=3
>> [4294672.375000] ata_std_postreset: ENTER
>> [4294672.378000] ata_std_postreset: EXIT
>> [4294672.382000] ata_dev_read_id: ENTER, host 1, dev 0
>> [4294672.537000] ata_exec_command_pio: ata1: cmd 0xA1
>> [4294672.543000] ata_pio_sector: data read
>> [4294672.546000] ata_dev_configure: ENTER, host 1, dev 0
>> [4294672.550000] ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000
>> 85:0000 86:0000 87:0000 88:0407
>> [4294672.550000] ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007 
>> 64==0x0003  75==0x0000  [4294672.553000] ata_dump_id: 80==0x0078 
>> 81==0x0000  82==0x0000  83==0x0000  84==0x0000  [4294672.557000]
>> ata_dump_id: 88==0x0407  93==0x4000
>> [4294672.560000] ata1: dev 0 ATAPI, max UDMA/33
>> [4294672.563000] ata1(0): applying bridge limits
>> [4294672.566000] ata_dev_configure: EXIT, drv_stat = 0x50
>> [4294672.569000] ata_dev_read_id: ENTER, host 1, dev 1
>> [4294672.723000] ata_exec_command_pio: ata1: cmd 0xA1
>> [4294672.726000] ata1: PIO error
>> [4294672.729000] ata1: dev 1 failed to IDENTIFY (I/O error)
> 
> 
> Ah.. I see.  IRQ-driven PIO times out while polling PIO detects it right
> away.
> 
> Thanks.  I'll push the fix to Jeff.
> 

Dear all,

Hope this phantom slave device patch for ICHx to be in the 2.6.18-rcX soon.
(Otherwise the problem imposes a long boot time when testing 2.6.18-rcX on
a Intel box.)

For those hardware without the Intel-specific PCS, the phantom slave
is still a problem. Currently no good solution about how to tell a
phantom slave from a real device. (Some phantom slave device can pass
our current PATA device presence check.)

Can we do the IDENTIFY by polling at this moment?
Polling doesn't fix the phantom slave device problem, but polling
can detect the phantom device quickly than using irq-pio and wait for
timeout.

--
albert


