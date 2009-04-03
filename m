From: "Courtney-Bakke, Julia (ISS H/W EPR)" <julia.courtney-bakke@hp.com>
Subject: RE: Bug 453808 - qc timeout probing TEAC DV-28E-V CD/DVD drive on
 SATA/PATA bridge
Date: Fri, 3 Apr 2009 20:07:51 +0000
Message-ID: <5F516AEA4F45A442880A3EC2002FBDC563A430914A@GVW1096EXB.americas.hpqcorp.net>
References: <5F516AEA4F45A442880A3EC2002FBDC563A4309148@GVW1096EXB.americas.hpqcorp.net>
 <200904031601.22088.bzolnier@gmail.com>
 <5F516AEA4F45A442880A3EC2002FBDC563A4309149@GVW1096EXB.americas.hpqcorp.net>
 <200904031815.29407.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:23628 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186AbZDCUJd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 16:09:33 -0400
In-Reply-To: <200904031815.29407.bzolnier@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

 Jeff,
I'm a hardware engineer at Hewlett-Packard. Some of our hardware customers are experiencing the qc-timeout documented in 
https://bugzilla.redhat.com/show_bug.cgi?id=453808

Specifically the issue is described as follows:
From: Mohamed 
Sent: Tuesday, February 10, 2009 4:24 PM
To: guild-test(mailer list); ipc-platform-team(mailer list)
Subject: 7828H4 Kernel message

Hi,
I see the following messages continuously appear on the 7828H4 server console. This server is running with Guild TT 11 - Build 10 and performing the CUCMBE load test. 

Feb 10 16:45:59 cores1 kern 4 kernel: ata3.00: qc timeout (cmd 0xa0)
Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: (BMDMA stat 0x25)
Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x25 data 8 in
Feb 10 16:45:59 cores1 kern 4 kernel:          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
Feb 10 16:46:06 cores1 kern 4 kernel: ata3: port is slow to respond, please be patient (Status 0xd0)
Feb 10 16:46:29 cores1 kern 3 kernel: ata3: port failed to respond (30 secs, Status 0xd0)
Feb 10 16:46:29 cores1 kern 6 kernel: ata3: soft resetting port
Feb 10 16:46:29 cores1 kern 6 kernel: ata3.00: configured for UDMA/33
Feb 10 16:46:29 cores1 kern 6 kernel: ata3: EH complete
These messages are recorded at /var/log/active/syslog/messages. Is this a known issue ?

 

Do you know whether increasing ata_probe_timeout actually helped the problem?
I edited /sys/module/libata/ata_probe_timeout and changed its value 
from 30000 to 100000  -qc timeouts still occur. Did I implement the workaround correctly?
 
Thanks,
Julia courtney-Bakke
Hardware Engineer
Industry Standard Servers
Hewlett-Packard
 

 

 

 

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Friday, April 03, 2009 11:15 AM
To: Courtney-Bakke, Julia (ISS H/W EPR)
Subject: Re: Bug 453808 - qc timeout probing TEAC DV-28E-V CD/DVD drive on SATA/PATA bridge


For libata issues please contact libata Maintainer:

	Jeff Garzik <jgarzik@pobox.com>

also if possible try to use linux-ide@vger.kernel.org mailing list instead of private mails for discussing Linux ATA issues.

On Friday 03 April 2009, Courtney-Bakke, Julia (ISS H/W EPR) wrote:
> Actually ... This is the bug I had a question about.
> 
> Bug 453808 - qc timeout probing TEAC DV-28E-V CD/DVD drive on 
> SATA/PATA bridge
> 
> Do you know whether increasing ata_probe_timeout actually helped the 
> problem.
> 
> I edited /sys/module/libata/ata_probe_timeout and changed its value 
> from 30000 to 100000
> 
> -qc timeouts still occur
> 
> Did I implement the workaround correctly?
> 
> Thanks,
> Julia courtney-Bakke
> Hardware epr
> 
> 
> 
> -----Original Message-----
> From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com]
> Sent: Friday, April 03, 2009 9:01 AM
> To: Courtney-Bakke, Julia (ISS H/W EPR)
> Subject: Re: Bug 10887 - Kernel report fake device busy intermittently
> 
> 
> Hi,
> 
> On Friday 03 April 2009, Courtney-Bakke, Julia (ISS H/W EPR) wrote:
> > Hello,
> > I work in engineering for Hewlett Packard.  We have customers in the field that are experiencing Bug 10887 - Kernel report fake device busy intermittently.
> > 
> > Is the only workaround to patch and recompile kernel?
> 
> As a workaround you may try to fix your user-space to not access /proc/ide/hd*/identify (if this is acceptable).
> 
> Unfortunately to fully fix the issue revised kernel is needed.
> 
> Thanks,
> Bart
> 

