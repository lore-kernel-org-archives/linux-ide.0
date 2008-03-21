From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Fri, 21 Mar 2008 09:18:19 +0900
Message-ID: <47E2FECB.3080602@gmail.com>
References: <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <20080318045316.GA3959@denix.org> <47DF63C1.5090205@gmail.com> <20080320223736.GA19940@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:5424 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYCUAS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 20:18:26 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1356670wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 17:18:25 -0700 (PDT)
In-Reply-To: <20080320223736.GA19940@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Mark Lord <liml@rtr.ca>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Hello,

Denys Dmytriyenko wrote:
> Thanks for the info. As Gabor suggested, I watched UDMA_CRC_Error_Count and it 
> slowly grows only on this particular drive. And here is another recent 
> exception for the same drive, which is somewhat strange looking:
> 
> Mar 19 22:24:29 [kernel] ata3.00: exception Emask 0x40 SAct 0x3f SErr 0x0 action 0x6 frozen
> Mar 19 22:24:29 [kernel] ata3.00: irq_stat 0x00060002, PRB not on qword boundary

Oh... That means the data structure fed to the controller by the driver
is misaligned which AFAIK can NOT happen.  All PRBs are allocated during
controller initialization and they're properly aligned.  It could be
that the drive is telling weird things to the controller and got it
confused.

> Mar 19 22:24:31 [kernel] ata3: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x2
> Mar 19 22:24:31 [kernel] ata3: irq_stat 0x00060002, protocol mismatch

This is controller complaining that what the drive is saying is gibberish.

> Any ieas what this might be? I'll definitely try to replace the cable and see 
> what happens.

What happens if you connect the drive to different port on the
controller?  Do errors follow the drive?

> BTW, issuing "smartctl -a" on a drive in standby, throws this exception:
> 
> Mar 20 18:16:53 [kernel] ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> Mar 20 18:16:53 [kernel] ata10.00: cmd b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
> Mar 20 18:16:53 [kernel]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 20 18:16:53 [kernel] ata10: soft resetting port
> Mar 20 18:16:54 [kernel] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> Mar 20 18:16:54 [kernel] ata10.00: configured for UDMA/100
> Mar 20 18:16:54 [kernel] ata10: EH complete
> Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] 976773168 512-byte hardware sectors (500108 MB)
> Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write Protect is off
> Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
> Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Which kernel version and how did you put the drive into sleep?

-- 
tejun
