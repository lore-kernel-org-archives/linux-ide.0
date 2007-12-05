From: "sam song" <sam_song@usish.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Wed, 5 Dec 2007 10:39:52 +0800
Message-ID: <000001c836e8$1ef1ba10$6539a8c0@usish.com.cn>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com> <002d01c83615$79261090$6539a8c0@usish.com.cn> <4754B995.4010800@gmail.com> <47560245.70306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usish.com ([210.5.144.203]:59063 "EHLO sr3.usish.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXLECkB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 21:40:01 -0500
In-Reply-To: <47560245.70306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> Tejun Heo wrote:
> > sam song wrote:
> > =>> Hmmm... It's timeout.  How long does the command take?  It's a bit
weird
> >>> because 36000s but the reported command duration is 136s.  How long
did
> >>> the command take actually?
> >> The command did actually take 136minutes25seconds. I set the timeout in
app
> >> as 36000seconds(10-hour).

Ummm, sorry, I made a false info. Later I FOUND that the timeout value was
1000 * 36000s
in app and the command could execute 136m. Once I changed back using 36000s,
the command could only take 27m.

> > Right, 136m.  I wonder whether it's hitting some hard timeout limit in
> > the kernel.  Hmmmm... Does the attached patch fix your problem?
> 
> Ping.  Did it work?

Sorry for keep you waiting. The test took so much time:-)

It did fix my problem. It took about 4-hour to zero the whole 1TB SATA disk
as required pattern. I also confirmed the result on LSI HBA SAS 1068E and
got succeed. Here was the whole debug process.

Tue Dec  4 14:42:42 CST 2007
[USI]: ata pass through(16) cdb: 85 0b 06 00 41 00 00 00 00 00 00 00 00 e0
fd 00
 [<unknown opcode>: 85 0b 06 00 41 00 00 00 00 00 00 00 00 e0 fd 00 ]
  scsi_status=0x0, host_status=0x0, driver_status=0x0
  info=0x0  duration=14272004 milliseconds
  status=0x0
Tue Dec  4 18:40:34 CST 2007
[USI] : Time to Perform Zero Disk on /dev/sdb was 237m52secs

No kernel message output during the executing.

Still one puzzle to consult with you. As you mentioned, the ATA Pass Thru in
SELS10 2.6.16.21-0.8 is "broken". So what is the workable vanilla kernel
besides 2.6.23.X? I
need to have more choice on distribution. For example 2.6.18.X vanilla
kernel with your patch can work?

Highly appreciate your kind help,

Sam Song


