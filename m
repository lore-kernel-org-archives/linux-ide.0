From: Lieven Marchand <mal@wyrd.be>
Subject: Re: timeouts with SiI 4726/3531
Date: Thu, 11 Oct 2007 22:07:58 +0200
Message-ID: <87bqb5wh29.fsf@wyrd.be>
References: <87lkaf3moh.fsf@wyrd.be> <87lkadsab5.fsf@wyrd.be>
	<470D93B2.9000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.169.223.adsl.dyn.edpnet.net ([213.219.169.223]:53906
	"EHLO black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753944AbXJKUqj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Oct 2007 16:46:39 -0400
In-Reply-To: <470D93B2.9000603@gmail.com> (Tejun Heo's message of "Thu, 11 Oct 2007 12:08:34 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> writes:

> Lieven Marchand wrote:
>> I've solved the problem with the timeouts by disabling NCQ on the four
>> disks. Apparently there's something in the combination of NCQ+PMP that
>> gives problems.
>
> (can't find the original thread) Can you post failing dmesg and the
> result of "hdparm -I /dev/sdX"?  So, without PMP, those drives behave
> okay with NCQ turned on?

This was the original mail:

Hi,

I have an external enclosure based on the SiI 4726 connected to the
3531 controller. It mostly works on a Debian 2.6.22 kernel patched
with libata-tj-2.6.22.1-20070808. But occasionally under high load
there are timeouts. Usually, the system recovers without a problem but
once a disk wasn't found after the reset. It took a power off/power on
of the device.

Another weird problem is that the SiI 4726 software doesn't find its
controller, although the config disk is found by the system. I was
going to use the device in JBOD mode anyway so this isn't a big deal.

Thanks for a great job. It's amazing how well this works already. I
see on the SiI site they distribute a kernel module for Suse/Redhat
for the 3531. Is the source available for it and does it work better
with it?

Oct  6 22:18:09 black kernel: ata1.03: exception Emask 0x0 SAct 0x2 SErr 0x0 act
ion 0x2 frozen
Oct  6 22:18:09 black kernel: ata1.03: cmd 60/40:08:5f:f1:c1/00:00:0e:00:00/40 t
ag 1 cdb 0x0 data 32768 in
Oct  6 22:18:09 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
mask 0x4 (timeout)
Oct  6 22:18:09 black kernel: ata1.15: hard resetting link
Oct  6 22:18:11 black kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 0)
Oct  6 22:18:11 black kernel: ata1.00: hard resetting link
Oct  6 22:18:12 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:12 black kernel: ata1.01: hard resetting link
Oct  6 22:18:13 black kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:13 black kernel: ata1.02: hard resetting link
Oct  6 22:18:13 black kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:13 black kernel: ata1.03: hard resetting link
Oct  6 22:18:14 black kernel: ata1.03: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:14 black kernel: ata1.04: hard resetting link
Oct  6 22:18:14 black kernel: ata1.04: SATA link down (SStatus 0 SControl 300)
Oct  6 22:18:14 black kernel: ata1.05: hard resetting link
Oct  6 22:18:15 black kernel: ata1.05: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 0)
Oct  6 22:18:15 black kernel: ata1.06: hard resetting link
Oct  6 22:18:16 black kernel: ata1.06: SATA link up 1.5 Gbps (SStatus 113 SContr
ol 300)
Oct  6 22:18:16 black kernel: ata1.00: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.01: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.02: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.03: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.05: device is on DMA blacklist, disabling DMA
Oct  6 22:18:16 black kernel: ata1.05: configured for PIO4
Oct  6 22:18:16 black kernel: ata1: EH complete
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] 640 512-byte hardware sectors (0
 MB)
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write cache: disabled, read cach

e: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] 640 512-byte hardware sectors (0
 MB)
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write cache: disabled, read cach
e: enabled, doesn't support DPO or FUA

I haven't tested the disks out of the enclosure so I don't know if
they work well with NCQ without PMP. I can't move other disks to the
enclosure to test because all of the disks internal in the machine are
in an LVM needed to boot.

Most of the time there's just the timeout which is bad for performance
but occasionally one of the disks doesn't come up and then I have to
rebuild the array.


Oct  7 16:34:39 black kernel: ata1.00: NCQ disabled due to excessive errors
Oct  7 16:34:39 black kernel: ata1.00: exception Emask 0x0 SAct 0x19f SErr 0x0 action 0x2 frozen
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/18:00:bf:0f:7e/00:00:0a:00:00/40 tag 0 cdb 0x0 data 12288 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/00:08:bf:09:7e/04:00:0a:00:00/40 tag 1 cdb 0x0 data 524288 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/00:10:bf:0d:7e/02:00:0a:00:00/40 tag 2 cdb 0x0 data 262144 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/78:18:3f:09:7e/00:00:0a:00:00/40 tag 3 cdb 0x0 data 61440 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/08:20:37:08:7e/00:00:0a:00:00/40 tag 4 cdb 0x0 data 4096 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/08:38:b7:09:7e/00:00:0a:00:00/40 tag 7 cdb 0x0 data 4096 out
Oct  7 16:34:39 black kernel:          res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.00: cmd 61/60:40:cf:07:7e/00:00:0a:00:00/40 tag 8 cdb 0x0 data 49152 out
Oct  7 16:34:39 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct  7 16:34:39 black kernel: ata1.15: hard resetting link
Oct  7 16:34:39 black kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.01: hard resetting link
Oct  7 16:34:39 black kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.02: hard resetting link
Oct  7 16:34:39 black kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.03: hard resetting link
Oct  7 16:34:39 black kernel: ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.04: hard resetting link
Oct  7 16:34:39 black kernel: ata1.04: SATA link down (SStatus 0 SControl 300)
Oct  7 16:34:39 black kernel: ata1.05: hard resetting link
Oct  7 16:34:39 black kernel: ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct  7 16:34:39 black kernel: ata1.06: hard resetting link
Oct  7 16:34:39 black kernel: ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1.00: revalidation failed (errno=-5)
Oct  7 16:34:39 black kernel: ata1.01: configured for UDMA/100
Oct  7 16:34:39 black kernel: ata1.02: configured for UDMA/100
Oct  7 16:34:39 black kernel: ata1.03: configured for UDMA/100
Oct  7 16:34:39 black kernel: ata1.05: device is on DMA blacklist, disabling DMA
Oct  7 16:34:39 black kernel: ata1.05: configured for PIO4
Oct  7 16:34:39 black kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1.00: revalidation failed (errno=-5)
Oct  7 16:34:39 black kernel: ata1.00: limiting SATA link speed to 1.5 Gbps
Oct  7 16:34:39 black kernel: ata1.00: limiting speed to UDMA/100:PIO3
Oct  7 16:34:39 black kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1.00: revalidation failed (errno=-5)
Oct  7 16:34:39 black kernel: ata1.00: disabled
Oct  7 16:34:39 black kernel: RULE 4 -- DENY IN=ppp0 OUT= MAC= SRC=82.241.68.88 DST=213.219.154.47 LEN=70 TOS=0x00 PREC=0x00
 TTL=51 ID=31778 PROTO=UDP SPT=41063 DPT=16400 LEN=50
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1.00: limiting SATA link speed to 1.5 Gbps
Oct  7 16:34:39 black kernel: ata1.00: limiting speed to UDMA7:PIO5
Oct  7 16:34:39 black kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Oct  7 16:34:39 black kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Oct  7 16:34:39 black kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct  7 16:34:39 black kernel: ata1.00: hard resetting link
Oct  7 16:34:39 black kernel: ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Oct  7 16:34:39 black kernel: ata1: EH pending after completion, repeating EH (cnt=4)
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176033727
Oct  7 16:34:39 black kernel: raid5: Disk failure on sde1, disabling device. Operation continuing on 3 devices
Oct  7 16:34:39 black kernel: sd 0:0:0:0: rejecting I/O to offline device
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176032191
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176033215
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176032063
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176031799
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176032183
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
Oct  7 16:34:39 black kernel: Descriptor sense data with sense descriptors (in hex):
Oct  7 16:34:39 black kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
Oct  7 16:34:39 black kernel:         00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Add. Sense: No additional sense information
Oct  7 16:34:39 black kernel: end_request: I/O error, dev sde, sector 176031695
Oct  7 16:34:39 black kernel: ata1: EH complete
Oct  7 16:34:39 black kernel: sd 0:0:0:0: rejecting I/O to offline device
Oct  7 16:34:39 black last message repeated 2 times
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] READ CAPACITY failed
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK

Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Sense not available.
Oct  7 16:34:39 black kernel: sd 0:0:0:0: rejecting I/O to offline device
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Write Protect is off
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Mode Sense: 00 00 00 00
Oct  7 16:34:39 black kernel: sd 0:0:0:0: rejecting I/O to offline device
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Asking for cache data failed
Oct  7 16:34:39 black kernel: sd 0:0:0:0: [sde] Assuming drive cache: write through
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] 640 512-byte hardware sectors (0 MB)
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:1:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:2:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:3:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] 640 512-byte hardware sectors (0 MB)
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Write Protect is off
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  7 16:34:40 black kernel: sd 0:5:0:0: [sdi] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Oct  7 16:34:40 black kernel: ata1.00: detaching (SCSI 0:0:0:0)
Oct  7 16:34:40 black kernel: sd 0:0:0:0: [sde] Stopping disk
Oct  7 16:34:40 black kernel: sd 0:0:0:0: [sde] START_STOP FAILED
Oct  7 16:34:40 black kernel: sd 0:0:0:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Oct  7 16:34:40 black kernel: RAID5 conf printout:
Oct  7 16:34:40 black kernel:  --- rd:4 wd:3
Oct  7 16:34:40 black kernel:  disk 0, o:0, dev:sde1
Oct  7 16:34:40 black kernel:  disk 1, o:1, dev:sdf1
Oct  7 16:34:40 black kernel:  disk 2, o:1, dev:sdg1
Oct  7 16:34:40 black kernel:  disk 3, o:1, dev:sdh1
Oct  7 16:34:40 black kernel: RAID5 conf printout:
Oct  7 16:34:40 black kernel:  --- rd:4 wd:3
Oct  7 16:34:40 black kernel:  disk 1, o:1, dev:sdf1
Oct  7 16:34:40 black kernel:  disk 2, o:1, dev:sdg1
Oct  7 16:34:40 black kernel:  disk 3, o:1, dev:sdh1

black:/tmp# hdparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
        Model Number:       SAMSUNG HD501LJ                         
        Serial Number:      S0MUJ1FP814121      
        Firmware Revision:  CR100-10
        Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
        Supported: 8 7 6 5 
        Likely used: 8
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  976773168
        device size with M = 1024*1024:      476940 MBytes
        device size with M = 1000*1000:      500107 MBytes (500 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 udma7 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        168min for SECURITY ERASE UNIT. 168min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct
