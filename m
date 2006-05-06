From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Problem with disk
Date: Sat, 6 May 2006 14:34:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca>
References: <445CE823.2040203@emc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:50863 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1751081AbWEFSeO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 14:34:14 -0400
In-Reply-To: <445CE823.2040203@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: David.Ronis@McGill.CA, linux-ide@vger.kernel.org

> do on a regular basis) that running with barriers over power fail 
> testing gets you a solid recovery. Running with write cache on and no 
> barriers gets you file system corruption.

in short "barriers work".  never doubted!

> As I said before, the data you 
> just wrote (or the file system wrote for you) most recently is the same 
> data that you stand to lose on a powerloss.

obviously.
so the question is whether the cache still has dirty writeback when the power
drops due to normal poweroff.  I'd consider it a bug in the laptop bios to
let this happen, but that's not going to make the affected user happy...

> If there is a hole in the sequence, dropping to standby could be the 
> source of issues...

I guess it's a matter of how byzantine the bugs are you want to consider.
for mass-produced devices, I'm reluctant to assume the disk vendor has 
forgotten to _ever_ flush writeback data, for instance.  and don't forget
that a bogus drive that entirely forgets writeback may also not really
turn off write caching when you tell it to!

I assume that the disk will indeed do writeback if left idle for a little
while.  on machines where this is a  real problem, I would start out by
waving relevant chickens like the following to give the best chance of
shutting down cleanly: 
	sync
	blockdev --flushbufs
	hdparm -W 0
	sleep 2
	hdparm -y
	sleep 5
	halt -hp

rather than _always_ suffering the penalty of disabled write cache, 
especially on a single slow laptop drive...

