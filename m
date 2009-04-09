From: Tejun Heo <tj@kernel.org>
Subject: Re: Bug 453808 - qc timeout probing TEAC DV-28E-V CD/DVD drive on
 SATA/PATA bridge
Date: Thu, 09 Apr 2009 11:24:42 -0700
Message-ID: <49DE3D6A.1070601@kernel.org>
References: <5F516AEA4F45A442880A3EC2002FBDC563A4309148@GVW1096EXB.americas.hpqcorp.net> <200904031601.22088.bzolnier@gmail.com> <5F516AEA4F45A442880A3EC2002FBDC563A4309149@GVW1096EXB.americas.hpqcorp.net> <200904031815.29407.bzolnier@gmail.com> <5F516AEA4F45A442880A3EC2002FBDC563A430914A@GVW1096EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57603 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbZDISYO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 14:24:14 -0400
In-Reply-To: <5F516AEA4F45A442880A3EC2002FBDC563A430914A@GVW1096EXB.americas.hpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Courtney-Bakke, Julia (ISS H/W EPR)" <julia.courtney-bakke@hp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Hello,

Courtney-Bakke, Julia (ISS H/W EPR) wrote:
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

Which kernel version is it?  I don't think it's a recent one.  The
atapi dma filter wouldn't let data 8 in command to use DMA.  Can you
please give a shot at 2.6.29 and see whether it makes any difference?

> Do you know whether increasing ata_probe_timeout actually helped the problem?
> I edited /sys/module/libata/ata_probe_timeout and changed its value 
> from 30000 to 100000  -qc timeouts still occur. Did I implement the workaround correctly?

ata_probe_timeout probably won't work around anything.

Thanks.

-- 
tejun
