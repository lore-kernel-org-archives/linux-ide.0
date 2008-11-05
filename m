From: "kyle" <kylewong@southa.com>
Subject: Re: trouble with seagate 1.5TB - 2.6.27.4
Date: Wed, 5 Nov 2008 13:47:06 +0800
Message-ID: <009c01c93f09$efc54bf0$b902a8c0@kyle>
References: <000901c93b0a$774ff3d0$b902a8c0@kyle> <491124AC.2030406@daa.com.au> <491129D5.2070009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.southa.com ([125.215.237.177]:43871 "HELO southa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884AbYKEFQR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 00:16:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, James Andrewartha <jamesa@daa.com.au>
Cc: linux-ide@vger.kernel.org


----- Original Message ----- 
From: "Mark Lord" <liml@rtr.ca>
To: "James Andrewartha" <jamesa@daa.com.au>
Cc: "kyle" <kylewong@southa.com>; <linux-ide@vger.kernel.org>
Sent: Wednesday, November 05, 2008 1:06 PM
Subject: Re: trouble with seagate 1.5TB - 2.6.27.4


> James Andrewartha wrote:
> > kyle wrote:
> >> Please cc me if possible.
> >>
> >> I just built a new server with some seagate 1.5TB harddisks with
mirrored
> >> /boot and root partition , The system sometime degrade the root
partition
> >> with error message as follow, this happened 4 times within 2 days.
> >
> > It appears that model of drive is broken:
> >
http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2390
> > http://www.techreport.com/discussions.x/15837
> > Apparently disabling the write cache is a workaround.
> >..
>
> Heh, I wonder if there's been some firmware spying between Seagate and
Hitachi..
> because my two Hitachi 750GB drives can be made to have the same problem.
>
> Triggers quite reliably (perhaps 1/5 attempts?) by running "hddtemp"
> (to read drive temperature) during heavy I/O.  Bingo.
>
> I imagine the smartmontools would have a similar effect.
>
> Cheers
>

Now I have to rebuild the raid everyday since every morning when I check out
the mirrored root partition, one of the drives (not always the same) fails
with the mentioned error. Strange the the 6x1.5TB raid 0 storage partition
even down because of this.

Kyle


