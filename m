From: "sam song" <sam_song@usish.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Tue, 4 Dec 2007 09:32:00 +0800
Message-ID: <002d01c83615$79261090$6539a8c0@usish.com.cn>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usish.com ([210.5.144.203]:50826 "EHLO sr3.usish.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbXLDBcG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 20:32:06 -0500
In-Reply-To: <4754A368.70806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> sam song wrote:
> >  [USI]: ata pass through(16) cdb: 85 0b 06 00 41 00 00 00 00 00 00 00 00
e0
> > fd 00
> >  [<unknown opcode>: 85 0b 06 00 41 00 00 00 00 00 00 00 00 e0 fd 00 ]
> >   scsi_status=0x2, host_status=0x0, driver_status=0x8
> >   info=0x1  duration=8184280 milliseconds
> [--snip--]
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata2.00: cmd fd/41:00:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data
33280 out
> >          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> > ata2: port is slow to respond, please be patient (Status 0xd0)
> > ata2: device not ready (errno=-16), forcing hardreset
> > ata2: soft resetting port
> > ata2.00: configured for UDMA/133
> > ata2: EH complete
> > sd 2:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
> > sd 2:0:0:0: [sdb] Write Protect is off
> > sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> > sd 2:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
> 
> Hmmm... It's timeout.  How long does the command take?  It's a bit weird
> because 36000s but the reported command duration is 136s.  How long did
> the command take actually?

The command did actually take 136minutes25seconds. I set the timeout in app
as 36000seconds(10-hour). 

Thanks so much,

Sam Song

