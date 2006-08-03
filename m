From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Thu, 03 Aug 2006 09:26:02 +0200
Message-ID: <1154589962.25611.102.camel@acme>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>
	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>
	 <1154502301.5691.23.camel@acme>  <44D0522E.6030905@gmail.com>
	 <1154529340.25611.75.camel@acme>  <44D0BE99.8010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.209.160.46] ([62.209.160.46]:6103 "EHLO stockholm.opq.se")
	by vger.kernel.org with ESMTP id S932358AbWHCH0I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Aug 2006 03:26:08 -0400
In-Reply-To: <44D0BE99.8010809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


If I switch two disks around and do a scan, nothing changes. I need
to delete the disks and then scan to have the change noted. Is this
expected behavior?

Does this mean I must delete a disk with a command when it it removed?
This is problematic in that I do not know which disk may have been
removed!
The old /proc/scsi interface would allow you to update the idea of whic=
h
things are attached without knowing which they were and (key point)
without
messing up a device that is unchanged and mounted.

Is this possible with libata?

I know you want logs. But I really feel that if the intended use is
unclear,
I can waste lots of time here sending in logs when trying to do things
that the driver does not intend I do. Step 1 must surely be to tell the
driver's expectations/limits first.

If I remove or insert a disk, there is nothing at all added to the
kernel log. There only seems to be activity when I echo something to
a file in /sys.

If I remove disks (but run no commands on the computer) and then do a
scan, I get this in the log:

Aug  3 08:16:43 aies1 kernel: ata1.00: qc timeout (cmd 0xec)
Aug  3 08:16:43 aies1 kernel: ata1.00: failed to IDENTIFY (I/O error,
err_mask=3D0                           x4)
Aug  3 08:16:43 aies1 kernel: ata1.00: revalidation failed (errno=3D-5)
Aug  3 08:16:43 aies1 kernel: ata1: failed to recover some devices,
retrying in                            5 secs
Aug  3 08:16:45 aies1 kernel: ata2.00: qc timeout (cmd 0xec)
Aug  3 08:16:45 aies1 kernel: ata2.00: failed to IDENTIFY (I/O error,
err_mask=3D0                           x4)
Aug  3 08:16:45 aies1 kernel: ata2.00: revalidation failed (errno=3D-5)
Aug  3 08:16:45 aies1 kernel: ata2: failed to recover some devices,
retrying in                            5 secs
Aug  3 08:16:55 aies1 kernel: ata1: port is slow to respond, please be
patient
Aug  3 08:16:57 aies1 kernel: ata2: port is slow to respond, please be
patient
Aug  3 08:17:18 aies1 kernel: ata1: port failed to respond (30 secs)
Aug  3 08:17:18 aies1 kernel: ata1: soft resetting port
Aug  3 08:17:20 aies1 kernel: ata2: port failed to respond (30 secs)
Aug  3 08:17:20 aies1 kernel: ata2: soft resetting port
Aug  3 08:17:25 aies1 kernel: ata1: port is slow to respond, please be
patient
Aug  3 08:17:27 aies1 kernel: ata2: port is slow to respond, please be
patient
Aug  3 08:17:48 aies1 kernel: ata1: port failed to respond (30 secs)
Aug  3 08:17:48 aies1 kernel: ATA: abnormal status 0xD0 on port 0x30EF
Aug  3 08:17:48 aies1 kernel: ATA: abnormal status 0xD0 on port 0x30EF
Aug  3 08:17:48 aies1 kernel: ATA: abnormal status 0xD0 on port 0x30EF
Aug  3 08:17:48 aies1 kernel: ATA: abnormal status 0xD0 on port 0x30EF


--=20
Roger Oberholtzer

OPQ Systems AB
Ramb=C3=B6ll Sverige AB
Kapellgr=C3=A4nd 7
P.O. Box 4205
SE-102 65 Stockholm, Sweden

Tel: Int +46 8-615 60 20
=46ax: Int +46 8-31 42 23

