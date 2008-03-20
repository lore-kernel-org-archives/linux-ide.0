From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Thu, 20 Mar 2008 18:37:36 -0400
Message-ID: <20080320223736.GA19940@denix.org>
References: <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com>
 <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com>
 <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca>
 <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com>
 <20080318045316.GA3959@denix.org> <47DF63C1.5090205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:44811 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbYCTWhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 18:37:42 -0400
Received: from gandalf.denix.org ([71.126.191.34])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JY100127W6OA8V1@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Thu, 20 Mar 2008 17:37:37 -0500 (CDT)
In-reply-to: <47DF63C1.5090205@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Hi,

On Tue, Mar 18, 2008 at 03:40:01PM +0900, Tejun Heo wrote:
> > Error 42 occurred at disk power-on lifetime: 3444 hours (143 days + 12 hours)
> >   When the command that caused the error occurred, the device was in an unknown state.
> > 
> >   After command completion occurred, registers were:
> >   ER ST SC SN CL CH DH
> >   -- -- -- -- -- -- --
> >   84 41 28 ff 46 5a 40
> > 
> >   Commands leading to the command that caused the error were:
> >   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
> >   -- -- -- -- -- -- -- --  ----------------  --------------------
> >   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
> >   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
> >   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
> >   60 10 20 2f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
> >   60 08 18 1f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
> 
> Error 42 occurred about 21days ago.  Unless your clock is off, I don't
> think this is what you've seen but the error is UNC (uncorrectable media
> error), so it does mean that your drive has some bad sectors which can
> explain the device error you saw.
> 
> > Error 41 occurred at disk power-on lifetime: 3405 hours (141 days + 21 hours)
> >   When the command that caused the error occurred, the device was in an unknown state.
> > 
> >   After command completion occurred, registers were:
> >   ER ST SC SN CL CH DH
> >   -- -- -- -- -- -- --
> >   00 41 01 10 00 00 a0  Error:
> > 
> >   Commands leading to the command that caused the error were:
> >   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
> >   -- -- -- -- -- -- -- --  ----------------  --------------------
> >   2f 00 01 10 00 00 a0 00      12:51:00.112  READ LOG EXT
> >   60 20 20 7f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
> >   60 08 18 6f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
> >   60 30 10 9f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
> >   60 08 08 5f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
> 
> Hmm.. this one less clear.  Maybe the device wasn't expecting READ LOG
> EXT as it was still in NCQ command phase and got surprised?
> 
> Currently you're the first and only one to report illegal qc_active
> transition problem.  I'd like to know what precedes the error which
> isn't exactly easy in retrospect.  For now, please keep an eye on those
> errors and report if you can see any pattern.  And just in case, can you
> get 2.6.24 on the machine and see anything changes?

Thanks for the info. As Gabor suggested, I watched UDMA_CRC_Error_Count and it 
slowly grows only on this particular drive. And here is another recent 
exception for the same drive, which is somewhat strange looking:

Mar 19 22:24:29 [kernel] ata3.00: exception Emask 0x40 SAct 0x3f SErr 0x0 action 0x6 frozen
Mar 19 22:24:29 [kernel] ata3.00: irq_stat 0x00060002, PRB not on qword boundary
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/08:00:27:32:f3/00:00:2c:00:00/40 tag 0 cdb 0x0 data 4096 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/08:08:6f:32:f3/00:00:2c:00:00/40 tag 1 cdb 0x0 data 4096 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/08:10:67:32:f3/00:00:2c:00:00/40 tag 2 cdb 0x0 data 4096 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/08:18:37:32:f3/00:00:2c:00:00/40 tag 3 cdb 0x0 data 4096 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/08:20:47:32:f3/00:00:2c:00:00/40 tag 4 cdb 0x0 data 4096 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3.00: cmd 60/10:28:77:32:f3/00:00:2c:00:00/40 tag 5 cdb 0x0 data 8192 in
Mar 19 22:24:29 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
Mar 19 22:24:29 [kernel] ata3: hard resetting port
Mar 19 22:24:31 [kernel] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 19 22:24:31 [kernel] ata3.00: configured for UDMA/100
Mar 19 22:24:31 [kernel] ata3: EH pending after completion, repeating EH (cnt=4)
Mar 19 22:24:31 [kernel] ata3: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x2
Mar 19 22:24:31 [kernel] ata3: irq_stat 0x00060002, protocol mismatch
Mar 19 22:24:31 [kernel] ata3: soft resetting port
Mar 19 22:24:31 [kernel] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 19 22:24:31 [kernel] ata3.00: configured for UDMA/100
Mar 19 22:24:31 [kernel] ata3: EH complete
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Write Protect is off
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Write Protect is off
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Mar 19 22:24:31 [kernel] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Any ieas what this might be? I'll definitely try to replace the cable and see 
what happens.

BTW, issuing "smartctl -a" on a drive in standby, throws this exception:

Mar 20 18:16:53 [kernel] ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Mar 20 18:16:53 [kernel] ata10.00: cmd b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
Mar 20 18:16:53 [kernel]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Mar 20 18:16:53 [kernel] ata10: soft resetting port
Mar 20 18:16:54 [kernel] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 20 18:16:54 [kernel] ata10.00: configured for UDMA/100
Mar 20 18:16:54 [kernel] ata10: EH complete
Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] 976773168 512-byte hardware sectors (500108 MB)
Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write Protect is off
Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
Mar 20 18:16:54 [kernel] sd 9:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

-- 
Denys
