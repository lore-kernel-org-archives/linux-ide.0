From: Jan Gutter <jangutter@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 17 Jan 2007 15:25:16 +0200
Message-ID: <1169040316.16103.18.camel@laundromat.jangutter.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>
	 <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com>
	 <200701160958.33561.matthew4196@gmail.com>  <45AC933B.1000201@gmail.com>
	 <1168947105.14636.11.camel@laundromat.jangutter.com>
	 <45ACBA1F.6030007@gmail.com>
	 <1168955594.14636.19.camel@laundromat.jangutter.com>
	 <45ADB011.6000906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:40556 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXAQNZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 08:25:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1985000uga
        for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 05:25:50 -0800 (PST)
In-Reply-To: <45ADB011.6000906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Stapleton <matthew4196@gmail.com>, linux-ide@vger.kernel.org

On Wed, 2007-01-17 at 14:11 +0900, Tejun Heo wrote:

> That's READ TOC.  Does the problem happen if you boot into single mode
> (no hald)?  Can you access cd/dvd in single mode?

OK, here's what I found out:

1) It's definitely hald that triggers the bug. Booting into a runlevel
without a lot of services, and running compiles for almost 5 hours
didn't show any negative symptoms. I did some small measure of cd
access : mount/ls/unmount, and they also worked fine.

2) After googling for "TS-L632D" and "ac00" I found that there's a
firmware update available for the drive. Google for TS-L632D and ac01 to
find it: http://www.toshibaer.com/firmware/index.php?path=TS-L632D/

3) As I was typing this email, the problem re-occured (with the newer
firmware):

ata1.01:exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01:cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0 in
        res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port

I have found a few URLS of forums and bugreports where the users claim
that keeping a CD in sometimes works, or booting off a CD, etc. The DVD
seems to zap the controller good when it does hit, though... TS-L632D
ac01 seems to be the correct incantation for Google.

If it's a firmware bug and implementing a workaround in hald helps it,
would other userspace apps (k3b, cdrecord, etc.) also be affected?

JAn

