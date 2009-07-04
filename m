From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPT370 fails in 2.6.30
Date: Sat, 04 Jul 2009 16:42:37 +0400
Message-ID: <4A4F4E3D.6020704@ru.mvista.com>
References: <200906291328.25824.jan.mette@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31421 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751944AbZGDMmk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Jul 2009 08:42:40 -0400
In-Reply-To: <200906291328.25824.jan.mette@berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Mette <jan.mette@berlin.de>
Cc: linux-ide@vger.kernel.org

Hello.

Jan Mette wrote:

> After looking at git.kernel.org and reading a bit of "how to report
> kernel bugs" i am now hoping that i have contacted the right person :)
>   

   I'm not quite right person -- I'm maintaining the "old" IDE hpt366 
driver, not the libata driver. The best "person" to report IDE/libata 
bugs is th linux-ide mailing list and/or http://bugzilla.kernel.org.

> Since 2.6.30 my Highpoint HPT370 doesnt work anymore, it does
> not detect my drives and tells me that there could be failures. There
> are a lot of errors in dmesg, and a google search doesnt reveal any
> useful information, at least for me. It seems that this bug was also in
> earlier kernel versions, but it got fixed on the way. On 2.6.29 and earlier
> kernels everything works fine for me.
>
> I am running an almost vanilla 2.6.30 kernel:
> http://repos.archlinux.org/viewvc.cgi/kernel26/repos/core-i686/
> ftp://ftp.archlinux.org/other/kernel26/patch-2.6.30-5-ARCH.bz2
>
> Here is the downstream bug:
> http://bugs.archlinux.org/task/15230
>
> As said, i hope i am contacting the right person. If you or someone else
> needs any additional info, please tell me about it. I am also able to build
> and/or patch a kernel, so you can use me for testing :)
>   

   First of all, will it fail if you apply only this patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=265b7215aed36941620b65ecfff516200fb190c1

to 2.6.29 -- it's the only pata_hpt37x driver change between 2.6.29 and 
2.6.30.

> pata_hpt3x2n 0000:01:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
> pata_hpt3x2n 0000:01:00.0: PCI INT A disabled
> Driver 'sd' needs updating - please use bus_type methods
> sd 2:0:0:0: [sda] 625142448 512-byte hardware sectors: (320 GB/298 GiB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda:<6>pata_hpt37x 0000:01:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
> pata_hpt37x: HPT370A using 33MHz bus clock.
> scsi8 : pata_hpt37x
> scsi9 : pata_hpt37x
> ata9: PATA max UDMA/100 cmd 0xbc00 ctl 0xb880 bmdma 0xb000 irq 21
> ata10: PATA max UDMA/100 cmd 0xb800 ctl 0xb480 bmdma 0xb008 irq 21
>  sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
> sd 2:0:0:0: [sda] Attached SCSI disk
> ata9.00: HPA detected: current 488397168, native 31170441795952
> ata9.00: ATA-7: SAMSUNG SP2514N, VF100-33, max UDMA/100
> ata9.00: 488397168 sectors, multi 0: LBA48 
> ata9.00: Drive reports diagnostics failure. This may indicate a drive
> ata9.00: fault or invalid emulation. Contact drive vendor for information.
>   

   Hm, this looks fishy... and you're saying that 2.6.29 doesn't show 
this message?

> ata9.01: HPA detected: current 488397168, native 31170441795952
> ata9.01: ATA-7: SAMSUNG SP2514N, VF100-50, max UDMA/100
> ata9.01: 488397168 sectors, multi 0: LBA48 
> ata9.00: configured for UDMA/100
> ata9.01: configured for UDMA/100
> scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG SP2514N  VF10 PQ: 0 ANSI: 5
> sd 8:0:0:0: [sdb] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
> scsi 8:0:1:0: Direct-Access     ATA      SAMSUNG SP2514N  VF10 PQ: 0 ANSI: 5
> sd 8:0:0:0: [sdb] Write Protect is off
> sd 8:0:1:0: [sdc] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
> sd 8:0:1:0: [sdc] Write Protect is off
> sd 8:0:1:0: [sdc] Mode Sense: 00 3a 00 00
> sd 8:0:1:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdc:<7>sd 8:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> ata9: lost interrupt (Status 0x7f)
>   

   The status of 0x7f looks fishy/unnatural. Is this a PATA or SATA drive?

> ata9: drained 2048 bytes to clear DRQ.
> ata9.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata9.01: cmd c8/00:08:00:00:00/00:00:00:00:00/f0 tag 0 dma 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata9.01: status: { DRDY }
>   

  And things go downhill from there...

> ata9: link is slow to respond, please be patient (ready=0)
> ata9: device not ready (errno=-16), forcing hardreset
> ata9: soft resetting link
> ata9.01: qc timeout (cmd 0xec)
> ata9.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata9.01: revalidation failed (errno=-5)
> ata9: link is slow to respond, please be patient (ready=0)
> ata9: device not ready (errno=-16), forcing hardreset
> ata9: soft resetting link
> ata9.01: qc timeout (cmd 0xec)
> ata9.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata9.01: revalidation failed (errno=-5)
> ata9: link is slow to respond, please be patient (ready=0)
> ata9: device not ready (errno=-16), forcing hardreset
> ata9: soft resetting link
> ata9.01: qc timeout (cmd 0xec)
> ata9.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata9.01: revalidation failed (errno=-5)
> ata9.01: disabled
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> ata9.00: revalidation failed (errno=-5)
> ata9: link is slow to respond, please be patient (ready=0)
> ata9: device not ready (errno=-16), forcing hardreset
> ata9: soft resetting link
> ata9.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
> ata9.00: revalidation failed (errno=-22)
> ata9: soft resetting link
> ata9.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
> ata9.00: revalidation failed (errno=-22)
> ata9.00: disabled
>   

   Hm, failed soft resets seem like too much... After this point, 'sd' 
vainly tries to talk to the disabled drive...

> ata9: EH complete
> sd 8:0:0:0: [sdb] Asking for cache data failed
> sd 8:0:0:0: [sdb] Assuming drive cache: write through
> sd 8:0:0:0: [sdb] READ CAPACITY(16) failed
> sd 8:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
> sd 8:0:0:0: [sdb] Sense not available.
> sd 8:0:0:0: [sdb] READ CAPACITY failed
> sd 8:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
> sd 8:0:0:0: [sdb] Sense not available.
> sd 8:0:0:0: [sdb] Asking for cache data failed
> sd 8:0:0:0: [sdb] Assuming drive cache: write through
> sdb: detected capacity change from 250059350016 to 0
> sd 8:0:0:0: [sdb] Attached SCSI disk
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> ldm_validate_partition_table(): Disk read failed.
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
>  unable to read partition table
> sd 8:0:1:0: [sdc] Attached SCSI disk
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
> Buffer I/O error on device sdc, logical block 1
> Buffer I/O error on device sdc, logical block 2
> Buffer I/O error on device sdc, logical block 3
> sd 8:0:1:0: [sdc] Unhandled error code
> sd 8:0:1:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
> end_request: I/O error, dev sdc, sector 0

MBR, Sergei


