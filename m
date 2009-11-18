From: Marc MERLIN <marc@merlins.org>
Subject: Re: help with PMP failures
Date: Wed, 18 Nov 2009 10:29:17 -0800
Message-ID: <20091118182917.GE19472@merlins.org>
References: <20091116184242.GA22250@merlins.org> <20091116184853.GA23126@merlins.org> <4B0238EC.6060803@kernel.org> <20091117173955.GA19029@merlins.org> <4B0371F4.9060703@gmail.com> <20091118074145.GA24488@merlins.org> <4B03B153.8050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:44471 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbZKRS3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 13:29:13 -0500
Content-Disposition: inline
In-Reply-To: <4B03B153.8050507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Wed, Nov 18, 2009 at 05:33:23PM +0900, Tejun Heo wrote:
> All the loggedcommands are write but the one which triggered the
> failure was read.  Error value of 0x84 indicates ICRC and ABORT, so
> all the logged commands were failed due to transmission failure from
> the host.  Hmmm....

If that helps, I dug up my 3rd such failure in my logs (back a month ago
now).

This should let you confirm or contradict your earlier suspicions

Funny how it also starts with a CRC error with the PMP too.
For that matter, it's a similar failure string then the previous
one I posted.
However this trace doesn't show any media error.

Comparing this with the last one you looked at, does it help pinpointing where
the fault might be?

Oct 17 21:18:25 gargamel kernel: ata6.00: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.01: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.02: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.03: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.04: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.05: failed to read SCR 1 (Emask=0x40)
Oct 17 21:18:25 gargamel kernel: ata6.15: exception Emask 0x100 SAct 0x0 SErr 0x200000 action 0x6 frozen
Oct 17 21:18:25 gargamel kernel: ata6.15: irq_stat 0x02060002, PMP DMA CS errata
Oct 17 21:18:25 gargamel kernel: ata6.15: SError: { BadCRC }
Oct 17 21:18:25 gargamel kernel: ata6.00: exception Emask 0x100 SAct 0xa SErr 0x0 action 0x6 frozen
Oct 17 21:18:25 gargamel kernel: ata6.00: cmd 60/80:08:bf:67:cc/00:00:2b:00:00/40 tag 1 ncq 65536 in
Oct 17 21:18:25 gargamel kernel:          res 3c/36:00:00:00:00/cd:00:40:10:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:25 gargamel kernel: ata6.00: status: { DF DRQ }
Oct 17 21:18:25 gargamel kernel: ata6.00: error: { IDNF ABRT }
Oct 17 21:18:25 gargamel kernel: ata6.00: cmd 60/10:18:3f:68:cc/00:00:2b:00:00/40 tag 3 ncq 8192 in
Oct 17 21:18:25 gargamel kernel:          res 60/10:18:3f:68:cc/00:00:2b:00:00/40 Emask 0x81 (invalid argument)
Oct 17 21:18:25 gargamel kernel: ata6.00: status: { DRDY DF }
Oct 17 21:18:25 gargamel kernel: ata6.00: error: { IDNF }
Oct 17 21:18:25 gargamel kernel: ata6.01: exception Emask 0x100 SAct 0x885 SErr 0x0 action 0x6 frozen
Oct 17 21:18:25 gargamel kernel: ata6.01: cmd 60/70:00:cf:66:cc/00:00:2b:00:00/40 tag 0 ncq 57344 in
Oct 17 21:18:25 gargamel kernel:          res 3c/36:00:00:00:00/cd:00:00:00:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:25 gargamel kernel: ata6.01: status: { DF DRQ }
Oct 17 21:18:25 gargamel kernel: ata6.01: error: { IDNF ABRT }
Oct 17 21:18:25 gargamel kernel: ata6.01: cmd 60/10:10:bf:66:cc/00:00:2b:00:00/40 tag 2 ncq 8192 in
Oct 17 21:18:25 gargamel kernel:          res 3c/36:00:00:00:00/00:00:00:20:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:25 gargamel kernel: ata6.01: status: { DF DRQ }
Oct 17 21:18:25 gargamel kernel: ata6.01: error: { IDNF ABRT }
Oct 17 21:18:25 gargamel kernel: ata6.01: cmd 60/80:38:3f:67:cc/00:00:2b:00:00/40 tag 7 ncq 65536 in
Oct 17 21:18:25 gargamel kernel:          res 3c/36:00:00:00:00/00:00:00:70:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:25 gargamel kernel: ata6.01: status: { DF DRQ }
Oct 17 21:18:25 gargamel kernel: ata6.01: error: { IDNF ABRT }
Oct 17 21:18:25 gargamel kernel: ata6.01: cmd 60/10:58:bf:67:cc/00:00:2b:00:00/40 tag 11 ncq 8192 in
Oct 17 21:18:25 gargamel kernel:          res 3c/36:00:00:00:00/00:00:00:b0:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:25 gargamel kernel: ata6.01: status: { DF DRQ }
Oct 17 21:18:25 gargamel kernel: ata6.01: error: { IDNF ABRT }
Oct 17 21:18:26 gargamel kernel: ata6.02: exception Emask 0x1 SAct 0x1100 SErr 0x0 action 0x6 frozen
Oct 17 21:18:26 gargamel kernel: ata6.02: irq_stat 0x02060002, device error via SDB FIS
Oct 17 21:18:26 gargamel kernel: ata6.02: cmd 60/70:40:cf:66:cc/00:00:2b:00:00/40 tag 8 ncq 57344 in
Oct 17 21:18:26 gargamel kernel:          res 3c/36:00:00:00:00/00:00:80:80:3c/00 Emask 0x3 (HSM violation)
Oct 17 21:18:26 gargamel kernel: ata6.02: status: { DF DRQ }
Oct 17 21:18:26 gargamel kernel: ata6.02: error: { IDNF ABRT }
Oct 17 21:18:26 gargamel kernel: ata6.02: cmd 60/80:60:3f:67:cc/00:00:2b:00:00/40 tag 12 ncq 65536 in
Oct 17 21:18:26 gargamel kernel:          res 60/80:60:3f:67:cc/00:00:2b:00:00/40 Emask 0x10 (ATA bus error)
Oct 17 21:18:26 gargamel kernel: ata6.02: status: { DRDY DF }
Oct 17 21:18:26 gargamel kernel: ata6.02: error: { ICRC }
Oct 17 21:18:26 gargamel kernel: ata6.03: exception Emask 0x100 SAct 0x2000 SErr 0x0 action 0x6 frozen
Oct 17 21:18:26 gargamel kernel: ata6.03: cmd 60/80:68:bf:67:cc/00:00:2b:00:00/40 tag 13 ncq 65536 in
Oct 17 21:18:26 gargamel kernel:          res 3c/36:00:00:00:00/00:00:c0:d0:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:26 gargamel kernel: ata6.03: status: { DF DRQ }
Oct 17 21:18:26 gargamel kernel: ata6.03: error: { IDNF ABRT }
Oct 17 21:18:26 gargamel kernel: ata6.04: exception Emask 0x100 SAct 0x40 SErr 0x0 action 0x6 frozen
Oct 17 21:18:26 gargamel kernel: ata6.04: cmd 60/70:30:4f:67:cc/00:00:2b:00:00/40 tag 6 ncq 57344 in
Oct 17 21:18:26 gargamel kernel:          res 3c/36:00:00:00:00/00:00:40:60:3c/00 Emask 0x2 (HSM violation)
Oct 17 21:18:26 gargamel kernel: ata6.04: status: { DF DRQ }
Oct 17 21:18:26 gargamel kernel: ata6.04: error: { IDNF ABRT }
Oct 17 21:18:26 gargamel kernel: ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Oct 17 21:18:26 gargamel kernel: ata6.15: hard resetting link
Oct 17 21:18:26 gargamel kernel: ata6: controller in dubious state, performing PORT_RST
Oct 17 21:18:28 gargamel kernel: ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct 17 21:18:28 gargamel kernel: ata6.00: hard resetting link
Oct 17 21:18:28 gargamel kernel: ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Oct 17 21:18:28 gargamel kernel: ata6.01: hard resetting link
Oct 17 21:18:28 gargamel kernel: ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:28 gargamel kernel: ata6.02: hard resetting link
Oct 17 21:18:29 gargamel kernel: ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:29 gargamel kernel: ata6.03: hard resetting link
Oct 17 21:18:29 gargamel kernel: ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:29 gargamel kernel: ata6.04: hard resetting link
Oct 17 21:18:29 gargamel kernel: ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:29 gargamel kernel: ata6.05: hard resetting link
Oct 17 21:18:30 gargamel kernel: ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Oct 17 21:18:30 gargamel kernel: ata6.00: configured for UDMA/100
Oct 17 21:18:35 gargamel kernel: ata6.01: qc timeout (cmd 0xec)
Oct 17 21:18:35 gargamel kernel: ata6.01: failed to IDENTIFY (I/O error, err_mask=0x5)
Oct 17 21:18:35 gargamel kernel: ata6.01: revalidation failed (errno=-5)
Oct 17 21:18:35 gargamel kernel: ata6.15: hard resetting link
Oct 17 21:18:37 gargamel kernel: ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct 17 21:18:37 gargamel kernel: ata6.00: hard resetting link
Oct 17 21:18:37 gargamel kernel: ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Oct 17 21:18:37 gargamel kernel: ata6.01: hard resetting link
Oct 17 21:18:37 gargamel kernel: ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:37 gargamel kernel: ata6.02: hard resetting link
Oct 17 21:18:38 gargamel kernel: ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:38 gargamel kernel: ata6.03: hard resetting link
Oct 17 21:18:38 gargamel kernel: ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:38 gargamel kernel: ata6.04: hard resetting link
Oct 17 21:18:38 gargamel kernel: ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:38 gargamel kernel: ata6.05: hard resetting link
Oct 17 21:18:39 gargamel kernel: ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Oct 17 21:18:39 gargamel kernel: ata6.00: configured for UDMA/100
Oct 17 21:18:49 gargamel kernel: ata6.01: qc timeout (cmd 0xec)
Oct 17 21:18:49 gargamel kernel: ata6.01: failed to IDENTIFY (I/O error, err_mask=0x5)
Oct 17 21:18:49 gargamel kernel: ata6.01: revalidation failed (errno=-5)
Oct 17 21:18:49 gargamel kernel: ata6.15: hard resetting link
Oct 17 21:18:51 gargamel kernel: ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct 17 21:18:51 gargamel kernel: ata6.00: hard resetting link
Oct 17 21:18:51 gargamel kernel: ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Oct 17 21:18:51 gargamel kernel: ata6.01: hard resetting link
Oct 17 21:18:51 gargamel kernel: ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:51 gargamel kernel: ata6.02: hard resetting link
Oct 17 21:18:52 gargamel kernel: ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:52 gargamel kernel: ata6.03: hard resetting link
Oct 17 21:18:52 gargamel kernel: ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:52 gargamel kernel: ata6.04: hard resetting link
Oct 17 21:18:52 gargamel kernel: ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:18:52 gargamel kernel: ata6.05: hard resetting link
Oct 17 21:18:53 gargamel kernel: ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Oct 17 21:18:53 gargamel kernel: ata6.00: configured for UDMA/100
Oct 17 21:19:23 gargamel kernel: ata6.01: qc timeout (cmd 0xec)
Oct 17 21:19:23 gargamel kernel: ata6.01: failed to IDENTIFY (I/O error, err_mask=0x5)
Oct 17 21:19:23 gargamel kernel: ata6.01: revalidation failed (errno=-5)
Oct 17 21:19:23 gargamel kernel: ata6.01: failed to recover link after 3 tries, disabling
Oct 17 21:19:23 gargamel kernel: ata6.01: disabled
Oct 17 21:19:23 gargamel kernel: ata6.15: hard resetting link
Oct 17 21:19:25 gargamel kernel: ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Oct 17 21:19:25 gargamel kernel: ata6.00: hard resetting link
Oct 17 21:19:25 gargamel kernel: ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Oct 17 21:19:25 gargamel kernel: ata6.02: hard resetting link
Oct 17 21:19:26 gargamel kernel: ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:19:26 gargamel kernel: ata6.03: hard resetting link
Oct 17 21:19:26 gargamel kernel: ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:19:26 gargamel kernel: ata6.04: hard resetting link
Oct 17 21:19:26 gargamel kernel: ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 17 21:19:26 gargamel kernel: ata6.05: hard resetting link
Oct 17 21:19:27 gargamel kernel: ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Oct 17 21:19:27 gargamel kernel: ata6.00: configured for UDMA/100
Oct 17 21:19:27 gargamel kernel: ata6.02: configured for UDMA/100
Oct 17 21:19:27 gargamel kernel: ata6.03: configured for UDMA/100
Oct 17 21:19:27 gargamel kernel: ata6.04: configured for UDMA/100
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Unhandled sense code
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Sense Key : Hardware Error [current] [descriptor]
Oct 17 21:19:27 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Oct 17 21:19:27 gargamel kernel:         72 04 00 00 00 00 00 0c 00 0a 80 00 00 00 3c 00 
Oct 17 21:19:27 gargamel kernel:         00 00 00 00 
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Add. Sense: No additional sense information
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdi, sector 734815951
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: rejecting I/O to offline device
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Unhandled error code
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdi, sector 734816207
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Unhandled sense code
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Sense Key : Hardware Error [current] [descriptor]
Oct 17 21:19:27 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Oct 17 21:19:27 gargamel kernel:         72 04 00 00 00 00 00 0c 00 0a 80 00 00 00 3c 20 
Oct 17 21:19:27 gargamel kernel:         00 00 00 00 
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Add. Sense: No additional sense information
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdi, sector 734815935
Oct 17 21:19:27 gargamel kernel: sd 6:0:0:0: [sdh] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Oct 17 21:19:27 gargamel kernel: sd 6:0:0:0: [sdh] Sense Key : Aborted Command [current] [descriptor]
Oct 17 21:19:27 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Oct 17 21:19:27 gargamel kernel:         72 0b 14 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Oct 17 21:19:27 gargamel kernel:         2b cc 68 3f 
Oct 17 21:19:27 gargamel kernel: sd 6:0:0:0: [sdh] Add. Sense: Recorded entity not found
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdh, sector 734816319
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Unhandled sense code
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: rejecting I/O to offline device
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Sense Key : Hardware Error [current] [descriptor]
Oct 17 21:19:27 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Oct 17 21:19:27 gargamel kernel:         72 04 00 00 00 00 00 0c 00 0a 80 00 00 00 3c 70 
Oct 17 21:19:27 gargamel kernel:         00 00 00 00 
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Add. Sense: No additional sense information
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdi, sector 734816063
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Unhandled sense code
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Sense Key : Hardware Error [current] [descriptor]
Oct 17 21:19:27 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Oct 17 21:19:27 gargamel kernel:         72 04 00 00 00 00 00 0c 00 0a 80 00 00 00 3c b0 
Oct 17 21:19:27 gargamel kernel:         00 00 00 00 
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Add. Sense: No additional sense information
Oct 17 21:19:27 gargamel kernel: end_request: I/O error, dev sdi, sector 734816191
Oct 17 21:19:27 gargamel kernel: ata6: EH complete
Oct 17 21:19:27 gargamel kernel: ata6.01: detaching (SCSI 6:1:0:0)
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Synchronizing SCSI cache
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Stopping disk
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] START_STOP FAILED
Oct 17 21:19:27 gargamel kernel: sd 6:1:0:0: [sdi] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Oct 17 21:19:27 gargamel kernel: raid5: Disk failure on sdi1, disabling device.
Oct 17 21:19:27 gargamel kernel: raid5: Operation continuing on 4 devices.
Oct 17 21:19:27 gargamel kernel: raid5: Disk failure on sdh1, disabling device.
Oct 17 21:19:27 gargamel kernel: raid5: Operation continuing on 3 devices.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
