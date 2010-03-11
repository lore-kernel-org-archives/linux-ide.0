From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 11:26:32 -0500
Message-ID: <201003111126.32882.gene.heskett@verizon.net>
References: <4B947393.2050002@kernel.org> <201003112035.26743.knikanth@suse.de>
 <20100311152551.GG1497@thunk.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:37615 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0CKQ0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 11:26:49 -0500
In-reply-to: <20100311152551.GG1497@thunk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tytso@mit.edu, Nikanth Karthikesan <knikanth@suse.de>, James Bottomley <James.Bottomley@suse.de>, Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@v>

On Thursday 11 March 2010, tytso@mit.edu wrote:
>On Thu, Mar 11, 2010 at 08:35:26PM +0530, Nikanth Karthikesan wrote:
>> The real problem, here is just that partitioning-tools should create
>> partitions that can work with both XP as well as Windows7. May be distro
>> installers, should ask the user which compatibility he needs.
>
>4k aligned sectors will *work* with Windows XP, will it not?  It's
>just simply a matter of Windows XP, being really ancient, doesn't
>create properly alligned partitions by default.
>
>And how often are we going to see Windows XP systems with these new 4k
>physical sector drives anyway, where the first OS to touch the
>partition is Windows XP?  And in the case where this does happy, the
>resulting partition will be result in terribly performance for Windows
>XP as well as Linux.
>
>What's the specific scenario which you are trying to solve, and how
>likely is it to occur in real life?

And potentially one more question from a list lurker, Ted.  Where are the 
tools that allow us to check and/or adjust that?  I ask since I have 3 of 
these terrabyte drives in this box now and have no clue how to either check 
to see if we're off, or how to fix it if it is.  And I have called my self 
following this discussion without noting if the tools have been specifically 
named.

Thanks

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

Authors are easy to get on with -- if you're fond of children.
		-- Michael Joseph, "Observer"
