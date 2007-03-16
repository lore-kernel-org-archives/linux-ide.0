From: Mark Lord <liml@rtr.ca>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Fri, 16 Mar 2007 11:13:28 -0400
Message-ID: <45FAB418.2070402@rtr.ca>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020701060105080407080701"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1075 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965370AbXCPPNb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:13:31 -0400
In-Reply-To: <45FAAA22.7060000@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701060105080407080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:
> Could you please apply the attached debugging patch for 
> clue about what caused the HSM violation, thanks.

I had to edit the patch to get it to apply on 2.6.21-rc3-git9,
but here (attached) is the output from syslog.

zip_insert.txt :: response to inserting a disc into the drive.
zip_button.txt :: response to pressing the eject button.
zip_eject.txt  :: response to using "eject /dev/sdc".

Enjoy!


--------------020701060105080407080701
Content-Type: text/plain;
 name="zip_button.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip_button.txt"

11:08:57: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
11:08:57:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
11:08:57: ata4: soft resetting port
11:08:57: ATA: abnormal status 0x7F on port 0x00010177
11:08:57: ATA: abnormal status 0x7F on port 0x00010177
11:08:58: ata4.00: configured for PIO2
11:08:58: ata4: EH complete
11:08:58: .<3>ata port 1: protocol 6 task_state 4

--------------020701060105080407080701
Content-Type: text/plain;
 name="zip_eject.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip_eject.txt"

11:09:55: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
11:09:55:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
11:09:55: ata4: soft resetting port
11:09:55: ATA: abnormal status 0x7F on port 0x00010177
11:09:55: ATA: abnormal status 0x7F on port 0x00010177
11:09:56: ata4.00: configured for PIO2
11:09:56: ata4: EH complete
11:09:56: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
11:09:57: .<3>ata port 1: protocol 6 task_state 4

--------------020701060105080407080701
Content-Type: text/plain;
 name="zip_insert.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip_insert.txt"

11:07:19: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
11:07:19:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
11:07:19: ata4: soft resetting port
11:07:19: ATA: abnormal status 0x7F on port 0x00010177
11:07:19: ATA: abnormal status 0x7F on port 0x00010177
11:07:19: ata4.00: configured for PIO2
11:07:19: ata4: EH complete
11:07:20: sdc: Spinning up disk...<3>ata port 1: protocol 6 task_state 4
11:07:20:          res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
11:07:20: ata4: soft resetting port
11:07:20: ATA: abnormal status 0x7F on port 0x00010177
11:07:20: ATA: abnormal status 0x7F on port 0x00010177
11:07:21: .<6>ata4.00: configured for PIO2
11:07:21: ata4: EH complete
11:07:21: ready
11:07:21: SCSI device sdc: 196608 512-byte hdwr sectors (101 MB)
11:07:21: sdc: Write Protect is off
11:07:21: sdc: cache data unavailable
11:07:21: SCSI device sdc: 196608 512-byte hdwr sectors (101 MB)
11:07:21: sdc: Write Protect is off
11:07:21: sdc: cache data unavailable
11:07:21:  sdc:<3>ata port 1: protocol 5 task_state 4
11:07:21:  sdc4
11:07:22: .<3>ata port 1: protocol 6 task_state 4
11:07:22: ready
11:07:22: SCSI device sdc: 196608 512-byte hdwr sectors (101 MB)
11:07:22: sdc: Write Protect is off
11:07:22: sdc: cache data unavailable
11:07:22: SCSI device sdc: 196608 512-byte hdwr sectors (101 MB)
11:07:22: sdc: Write Protect is off
11:07:22: sdc: cache data unavailable

--------------020701060105080407080701--
