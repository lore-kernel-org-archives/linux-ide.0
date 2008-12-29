From: <linux-ide@momail.e4ward.com>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Mon, 29 Dec 2008 22:32:56 +0100
Message-ID: <1230586376.11130.46.camel@Thutmosis>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>
	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>
	 <49505500.8080409@kernel.org> <1230126055.6430.17.camel@Thutmosis>
	 <495886E7.7050204@kernel.org>
Reply-To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CD5-gz3q-4@reply.e4ward.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4ward.com ([70.85.31.73]:59810 "EHLO e4ward.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbYL2WYn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 17:24:43 -0500
Received: from localhost ([127.0.0.1])
	by e4ward.com with smtp (Exim 4.63)
	id 1LHPjM-00044a-RL
	for linux-ide@vger.kernel.org; Mon, 29 Dec 2008 16:32:57 -0500
In-Reply-To: <495886E7.7050204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Am Montag, den 29.12.2008, 17:14 +0900 schrieb
linux-ide@vger.kernel.org:

> ...
> > * When booting with a CD that doesn't work after an 'empty boot', I get
> > similar errors as before (and like the last pair of lines above), but
> > the CD can be read. When I insert another CD that didn't work after an
> > empty boot afterwards, it still doesn't work.
> 
> Those errors shouldn't have much to do with how the transport is
> configured.  These are the drive failing to read the media and these
> errors can be quite indetermininstic, so it's possible that the
> pattern really isn't a pattern but then again the drive doesn't seem
> to have much problem being peculiar.  Can you please test more times
> and verify the pattern?

I have randomly tested a few CDs and DVDs since my last post, and there
were none that didn't work (after an "empty boot"). Since I found all
those that did not work before at my parents' there is a chance that
those CDs were not in the best of states. I will be far from a computer
during the next couple of days. But afterwards I plan to do some more
systematic tests, and I will also attempt to burn a CD and a DVD. 
> 
> As the behavior is so peculiar, one thing I'm worried about is whether
> the problem is common to the model or is specific to the drive.  If
> the former, it should go into mainline.  Do you happen to know anyone
> who has the same model?
The basic problem seems to be common to the model (or at least to more
than just my drive) since there are several posts by other people:
http://ubuntuforums.org/showthread.php?t=986871
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/299865
None of them has a solution or workaround. I think I had found more
reports before this thread started to dominate the search engine results
on the issue. As far as I see your patch skips setxfer only after a
failed first try. That should prevent it from affecting drives that
don't show the problem.

Happy New Year,

Moritz




