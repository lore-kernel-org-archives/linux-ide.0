From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 16:56:14 +0900
Message-ID: <4794501E.90306@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org> <20080115113552.75731bf8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758785AbYAUH4q@vger.kernel.org>
In-Reply-To: <20080115113552.75731bf8@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>>> [ 9031.028000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
>>> frozen
>>> [ 9031.028000] ata1.00: cmd c8/00:08:90:ca:ce/00:00:00:00:00/e0 tag 0 cdb 0x0 
>>> data 4096 in
>>> [ 9031.028000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 
>>> (timeout)
> 
> We got bored of waiting for the drive to respond to our request. I still
> think we have the timeouts too short or are accounting queue time
> somewhere we shouldn't as there a few other examples where we don't allow
> long enough for a drive to retry out and fail with a media error on a bad
> sector.

Hmm.. That's not what I hear from Mark and vendor contacts.  They say
30secs is more than enough.  I actually am thinking about reducing it to
15secs (not for FLUSH of course) as many SFF controllers report
transmission failure as timeouts.  Of course, if we're ticking the timer
while the command is not in flight, that's a bug.  If there are cases
where 30 secs isn't enough, can you please point me to those reports?

Thanks.

-- 
tejun
