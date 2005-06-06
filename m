From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: sata_promise driver and 2.6.11 on a MIPS board
Date: Mon, 6 Jun 2005 14:39:21 -0600
Message-ID: <4789af9e05060613394b1809c3@mail.gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:55597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261690AbVFFUj2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 16:39:28 -0400
Received: by zproxy.gmail.com with SMTP id 16so1867502nzp
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 13:39:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I'm having an odd issue with the sata_promise driver as included with
the 2.6.11 kernel, specifically the kernel downloaded from
www.linux-mips.org, but I think their 2.6.11 branch is up-to-date with
the actual 2.6.11 release in all non-mips-related drivers.

The card in question is a Promise SataII 150 TX4 PCI adapter.  I
currently have only one drive hooked up to it.  Here is a description
of what is happening (have turned ATA debugging on already):

In short, the driver is setting the xfer mode
(libata::ata_dev_set_xfermode) which eventually calls
sata_promise::pdc_packet_start, and this routine writes 1 to what I
believe is the proper control register, and then writes the proper
xfer mode to the data register.  I think.  I don't have a whitepaper
of any sort on the PCI card, so I can't be 100% sure that the values
written or offsets are correct.

The driver then waits via a wait_for_completion apparently waiting for
the PCI card to throw an interrupt so it can continue.  However, I
never see this interrupt generated, and the driver code waits forever.
 I have taken the existing debug and added to it a little to
demostrate the problem:

ata_device_add: ENTER
ata_host_add: ENTER  
dma_alloc_coherent returning 0xa0730000
ata_port_start: prd alloc, virt a0730000, dma 730000
dma_alloc_coherent returning 0xa0733000             
ata1: SATA max UDMA/133 cmd 0xAD049200 ctl 0xAD049238 bmdma 0x0 irq 38
ata_host_add: ENTER                                                   
dma_alloc_coherent returning 0xa0731000
ata_port_start: prd alloc, virt a0731000, dma 731000
dma_alloc_coherent returning 0xa0735000             
ata2: SATA max UDMA/133 cmd 0xAD049280 ctl 0xAD0492B8 bmdma 0x0 irq 38
ata_host_add: ENTER                                                   
dma_alloc_coherent returning 0xa7c4f000
ata_port_start: prd alloc, virt a7c4f000, dma 7c4f000
dma_alloc_coherent returning 0xa0737000              
ata3: SATA max UDMA/133 cmd 0xAD049300 ctl 0xAD049338 bmdma 0x0 irq 38
ata_host_add: ENTER                                                   
dma_alloc_coherent returning 0xa7c46000
ata_port_start: prd alloc, virt a7c46000, dma 7c46000
dma_alloc_coherent returning 0xa7c3b000              
ata4: SATA max UDMA/133 cmd 0xAD049380 ctl 0xAD0493B8 bmdma 0x0 irq 38
ata_device_add: probe begin                                           
ata_device_add: ata1: probe begin
ata_bus_probe: ENTER             
ata1: no device found (phy stat 00000000)
ata_bus_probe: Reset complete            
ata_device_add: ata1: probe end
scsi0 : sata_promise           
ata_device_add: ata2: probe begin
ata_bus_probe: ENTER             
ata2: no device found (phy stat 00000000)
ata_bus_probe: Reset complete            
ata_device_add: ata2: probe end
scsi1 : sata_promise           
ata_device_add: ata3: probe begin
ata_bus_probe: ENTER             
ata3: no device found (phy stat 00000000)
ata_bus_probe: Reset complete            
ata_device_add: ata3: probe end
scsi2 : sata_promise           
ata_device_add: ata4: probe begin
ata_bus_probe: ENTER             
ata_bus_reset: ENTER, host 4, port 3
ata_bus_softreset: ata4: bus reset via SRST
ata_dev_classify: found ATA device by sig  
ata_bus_reset: EXIT                      
ata_bus_probe: Reset complete
ata_dev_identify: ENTER, host 4, dev 0
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_dev_identify: do ATA identify            
ata_qc_issue: ENTER              
pdc_qc_prep: ENTER: Protocol is 2
ata_qc_issue: About to run ap->ops->qc_issue
ata_qc_issue_prot: ENTER                    
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_qc_issue_prot: Doing PIO op              
ata_exec_command_mmio: ata4: cmd 0xEC
ata_qc_issue_prot: EXIT - Ok         
ata_pio_sector: data read   
ata_qc_complete: EXIT    
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x007e  81==0x001b  82==0x346b  83==0x7d01  84==0x4003  
ata_dump_id: 88==0x007f  93==0x0000                                      
ata4: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata_dev_identify: EXIT, drv_stat = 0x50                
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode        
ata_qc_issue: ENTER                           
pdc_qc_prep: ENTER: Protocol is 1
ata_qc_issue: About to run ap->ops->qc_issue
pdc_packet_start: ENTER, ap 87c3e9b8        
pdc_packet_start: Step 1 - Base address is 0xad049000
pdc_packet_start:          Offset is 0x00000010      
pdc_packet_start:          Write complete      
pdc_packet_start:          Read complete (0x00000001)
pdc_packet_start: Step 2 - Base address is 0xad049380
pdc_packet_start:          Offset is 0x00000040      
pdc_packet_start:          Writing 0x07c3b000  
pdc_packet_start:          Write complete    
pdc_packet_start:          Read complete (0x07c3b030)
ata_dev_set_xfermode: Waiting... 

I also found it odd that it detected this drive as the 4th one even
though it is plugged into the port labeled "J1" on the card.  In fact,
where the card is labelled J1 through 4, the driver detects them as
ATA 4, 2, 1, and 3, in that order.

I originally thought the problem may have had something to do with the
offset not matching the actual physical port location, but port 2 is
detected correctly as ATA2 and experiences the same problem, with
offset 0x08 for the control register.

Any ideas or suggestions on how to troubleshoot this further (or fix
it?) would be appreciated.

-- 
Jim Ramsay
Please CC me with responses, thanks!
"Me fail English?  That's unpossible!"
