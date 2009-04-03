From: David Milburn <dmilburn@redhat.com>
Subject: Re: Bug 453808 - qc timeout probing TEAC DV-28E-V CD/DVD drive on
 SATA/PATA bridge
Date: Fri, 03 Apr 2009 18:02:35 -0500
Message-ID: <49D6958B.2060601@redhat.com>
References: <5F516AEA4F45A442880A3EC2002FBDC563A4309148@GVW1096EXB.americas.hpqcorp.net> <200904031601.22088.bzolnier@gmail.com> <5F516AEA4F45A442880A3EC2002FBDC563A4309149@GVW1096EXB.americas.hpqcorp.net> <200904031815.29407.bzolnier@gmail.com> <5F516AEA4F45A442880A3EC2002FBDC563A430914A@GVW1096EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55941 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757315AbZDCXCZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Apr 2009 19:02:25 -0400
In-Reply-To: <5F516AEA4F45A442880A3EC2002FBDC563A430914A@GVW1096EXB.americas.hpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Courtney-Bakke, Julia (ISS H/W EPR)" <julia.courtney-bakke@hp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Hello Julia,

Courtney-Bakke, Julia (ISS H/W EPR) wrote:
>  Jeff,
> I'm a hardware engineer at Hewlett-Packard. Some of our hardware customers are experiencing the qc-timeout documented in 
> https://bugzilla.redhat.com/show_bug.cgi?id=453808
> 
> Specifically the issue is described as follows:
> From: Mohamed 
> Sent: Tuesday, February 10, 2009 4:24 PM
> To: guild-test(mailer list); ipc-platform-team(mailer list)
> Subject: 7828H4 Kernel message
> 
> Hi,
> I see the following messages continuously appear on the 7828H4 server console. This server is running with Guild TT 11 - Build 10 and performing the CUCMBE load test. 
> 
> Feb 10 16:45:59 cores1 kern 4 kernel: ata3.00: qc timeout (cmd 0xa0)
> Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: (BMDMA stat 0x25)
> Feb 10 16:45:59 cores1 kern 3 kernel: ata3.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x25 data 8 in
> Feb 10 16:45:59 cores1 kern 4 kernel:          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
> Feb 10 16:46:06 cores1 kern 4 kernel: ata3: port is slow to respond, please be patient (Status 0xd0)
> Feb 10 16:46:29 cores1 kern 3 kernel: ata3: port failed to respond (30 secs, Status 0xd0)
> Feb 10 16:46:29 cores1 kern 6 kernel: ata3: soft resetting port
> Feb 10 16:46:29 cores1 kern 6 kernel: ata3.00: configured for UDMA/33
> Feb 10 16:46:29 cores1 kern 6 kernel: ata3: EH complete
> These messages are recorded at /var/log/active/syslog/messages. Is this a known issue ?
> 
>  
> 
> Do you know whether increasing ata_probe_timeout actually helped the problem?
> I edited /sys/module/libata/ata_probe_timeout and changed its value 
> from 30000 to 100000  -qc timeouts still occur. Did I implement the workaround correctly?
>  

Increasing ata_probe_timeout won't help this problem, and it is reproducible
on a hp dl320g5p running 2.6.29

ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATAPI: DV-28E-V, C.AB, max UDMA/33
ata4.00: configured for UDMA/33
isa bounce pool size: 16 pages
scsi 3:0:0:0: CD-ROM            TEAC     DV-28E-V         C.AB PQ: 0 ANSI: 5
   .
   .
ata4.00: qc timeout (cmd 0xa0)
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata4.00: status: { DRDY ERR }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/33
ata4: EH complete
  .
  .

Some other information passed on to me (mentioning for this
list), experimentally putting a delay in between ata_dev_read_id()
and ata_dev_set_xfermode(), actually right before issuing  the
set features command prevented the timeout.

David

