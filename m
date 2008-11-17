From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Mon, 17 Nov 2008 12:47:44 +0100
Message-ID: <492159E0.1050804@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk> <4920D093.2030508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:32855 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYKQLsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Nov 2008 06:48:53 -0500
In-Reply-To: <4920D093.2030508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Tejun,

Thanks for your reply.

Tejun Heo wrote:
> Does unloading and reloading sata_promise fix the problem?

I had sata_promise linked into the kernel so I had to recompile and 
reboot. The reboot fixed it (didn't turn power off - just reboot).

I then tried with sata_promise as a module. Four dd's reading the drives 
and shortly same problem:

[  700.520101] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[  700.520112] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[  700.520120] ata1.00: cmd c8/00:00:90:0e:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[  700.520122]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[  700.520126] ata1.00: status: { DRDY }
[  700.520169] ata1: hard resetting link
[  705.910331] ata1: link is slow to respond, please be patient (ready=-19)
[  710.531474] ata1: COMRESET failed (errno=-16)
[  710.531531] ata1: hard resetting link
[  715.920526] ata1: link is slow to respond, please be patient (ready=-19)

I tried removing sata_promise the nice way using modprobe:

# modprobe -r -f sata_promise
FATAL: Module sata_promise is in use.

then the not-so-nice way using rmmod -f and inserting it again. It 
doesn't work. Here are the relevant parts from dmesg (removing and 
inserting):

[ 1001.080120] Buffer I/O error on device sda, logical block 3981785
[ 1001.080123] Buffer I/O error on device sda, logical block 3981786
[ 1001.080126] Buffer I/O error on device sda, logical block 3981787
[ 1001.080148] sd 0:0:0:0: rejecting I/O to offline device
[ 1001.080155] ata1: EH complete
[ 1001.080165] ata1.00: detaching (SCSI 0:0:0:0)
[ 1001.080268] sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
[ 1001.080272] end_request: I/O error, dev sda, sector 31854480
[ 1001.080484] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1001.084116] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1001.084124] sd 0:0:0:0: [sda] Stopping disk
[ 1001.084131] sd 0:0:0:0: [sda] START_STOP FAILED
[ 1001.084133] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1857.939501] ata2.00: disabled
[ 1857.974792] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[ 1857.974923] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[ 1857.974928] sd 1:0:0:0: [sdb] Stopping disk
[ 1857.974971] sd 1:0:0:0: [sdb] START_STOP FAILED
[ 1857.974974] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[ 1857.975067] ata3.00: disabled
[ 1858.021338] sd 2:0:0:0: [sdc] Synchronizing SCSI cache
[ 1858.021569] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[ 1858.021574] sd 2:0:0:0: [sdc] Stopping disk
[ 1858.021744] sd 2:0:0:0: [sdc] START_STOP FAILED
[ 1858.021747] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[ 1858.021967] ata4.00: disabled
[ 1858.075341] sd 3:0:0:0: [sdd] Synchronizing SCSI cache
[ 1858.075583] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[ 1858.075588] sd 3:0:0:0: [sdd] Stopping disk
[ 1858.075760] sd 3:0:0:0: [sdd] START_STOP FAILED
[ 1858.075763] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[ 1858.075914] sata_promise 0000:01:08.0: PCI INT A disabled
[ 1889.910087] sata_promise 0000:01:08.0: version 2.12
[ 1889.910336] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> GSI 
18 (level, high) -> IRQ 18
[ 1889.910736] scsi4 : sata_promise
[ 1889.912425] scsi5 : sata_promise
[ 1889.912582] scsi6 : sata_promise
[ 1889.913039] scsi7 : sata_promise
[ 1889.913107] ata5: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[ 1889.913114] ata6: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[ 1889.913119] ata7: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[ 1889.913123] ata8: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[ 1895.300008] ata5: link is slow to respond, please be patient (ready=-19)
[ 1899.920484] ata5: COMRESET failed (errno=-16)
[ 1905.310009] ata5: link is slow to respond, please be patient (ready=-19)
[ 1909.930012] ata5: COMRESET failed (errno=-16)
[ 1915.320008] ata5: link is slow to respond, please be patient (ready=-19)
[ 1944.960008] ata5: COMRESET failed (errno=-16)
[ 1944.960017] ata5: limiting SATA link speed to 1.5 Gbps
[ 1949.990008] ata5: COMRESET failed (errno=-16)
[ 1949.990015] ata5: reset failed, giving up
[ 1950.340041] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1955.340026] ata6.00: qc timeout (cmd 0xec)
[ 1955.340240] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1960.730007] ata6: link is slow to respond, please be patient (ready=-19)
[ 1965.350009] ata6: COMRESET failed (errno=-16)
[ 1970.740007] ata6: link is slow to respond, please be patient (ready=-19)
[ 1975.360010] ata6: COMRESET failed (errno=-16)
[ 1980.750007] ata6: link is slow to respond, please be patient (ready=-19)
[ 2010.392068] ata6: COMRESET failed (errno=-16)
[ 2010.392078] ata6: limiting SATA link speed to 1.5 Gbps
[ 2015.420013] ata6: COMRESET failed (errno=-16)
[ 2015.420021] ata6: reset failed, giving up
[ 2015.420042] ata6: hard resetting link
[ 2020.810007] ata6: link is slow to respond, please be patient (ready=-19)
[ 2025.430011] ata6: COMRESET failed (errno=-16)
[ 2025.430026] ata6: hard resetting link
[ 2030.820007] ata6: link is slow to respond, please be patient (ready=-19)
[ 2035.440011] ata6: COMRESET failed (errno=-16)
[ 2035.440025] ata6: hard resetting link
[ 2040.830007] ata6: link is slow to respond, please be patient (ready=-19)
[ 2070.470007] ata6: COMRESET failed (errno=-16)
[ 2070.470023] ata6: hard resetting link
[ 2075.500008] ata6: COMRESET failed (errno=-16)
[ 2075.500015] ata6: reset failed, giving up
[ 2075.500021] ata6: EH complete
[ 2075.850041] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2080.850027] ata7.00: qc timeout (cmd 0xec)
[ 2080.850241] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 2086.240010] ata7: link is slow to respond, please be patient (ready=-19)
[ 2090.860010] ata7: COMRESET failed (errno=-16)
[ 2096.250008] ata7: link is slow to respond, please be patient (ready=-19)

I tried it one more time with the same result.

Best regards,

Peter
