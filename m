From: Etienne Basset <etienne.basset@numericable.fr>
Subject: [2.6.34-rc1][libata] regression?
Date: Tue, 09 Mar 2010 22:47:46 +0100
Message-ID: <4B96C202.6050606@numericable.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fb2.tech.numericable.fr ([82.216.111.50]:51060 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0CIV4e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 16:56:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

hello,


with .34-rc1 i see some "stalls"; systems is frozen for say 30seconds, then comes backs to life
The only clue i have is strange ATA logs that I didn't have before, see below.
My disk may be dying, it's 6 years old, but i shows the messages only in .34-rc1, never in .33 or .32

If the stalls are unrelated to ata, how could I debug that with perf? i got lots of 'WARNING: failed to keep up with mmap data' when using perf top....
'

thx
Etienne

lscpi
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)
                                                        
cat /var/log/messages
Mar  9 21:13:08 etienne-desktop kernel: ata1: clearing spurious IRQ
Mar  9 21:13:38 etienne-desktop kernel: ata1: lost interrupt (Status 0x50)
Mar  9 21:13:38 etienne-desktop kernel: ata1: soft resetting link
Mar  9 21:13:39 etienne-desktop kernel: ata1.00: configured for UDMA/133
Mar  9 21:13:39 etienne-desktop kernel: ata1.00: device reported invalid CHS sector 0
Mar  9 21:13:39 etienne-desktop kernel: ata1: EH complete
Mar  9 21:19:01 etienne-desktop kernel: ata1: clearing spurious IRQ
Mar  9 21:19:31 etienne-desktop kernel: ata1: lost interrupt (Status 0x50)
Mar  9 21:19:31 etienne-desktop kernel: ata1: soft resetting link
Mar  9 21:19:32 etienne-desktop kernel: ata1.00: configured for UDMA/133
Mar  9 21:19:32 etienne-desktop kernel: ata1.00: device reported invalid CHS sector 0
Mar  9 21:19:32 etienne-desktop kernel: ata1: EH complete

dmesg
libata version 3.00 loaded.                                                                                     
ata_piix 0000:00:1f.2: version 2.13                                                                             
ata_piix 0000:00:1f.2: PCI INT C -> GSI 20 (level, low) -> IRQ 20                                               
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]                                                                      
ata_piix 0000:00:1f.2: setting latency timer to 64                                                              
scsi0 : ata_piix                                                                                                
scsi1 : ata_piix                                                                                                
ata1: SATA max UDMA/133 cmd 0xfe00 ctl 0xfe10 bmdma 0xfea0 irq 20                                               
ata2: SATA max UDMA/133 cmd 0xfe20 ctl 0xfe30 bmdma 0xfea8 irq 20
ata1.00: ATA-6: ST3160023AS, 8.05, max UDMA/133
ata1.00: 312581808 sectors, multi 8: LBA48
ata1.00: configured for UDMA/133


