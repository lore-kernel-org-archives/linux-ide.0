From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Thu, 15 Jan 2009 14:48:38 +0900
Message-ID: <496ECE36.6010706@kernel.org>
References: <20090107141536.231980@gmx.net> <20090107142351.79749c05@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38160 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbZAOFsy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 00:48:54 -0500
In-Reply-To: <20090107142351.79749c05@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Moritz Rigler <moritz1234567@gmx.de>, linux-ide@vger.kernel.org

Hello, Alan, Moritz.

Alan Cox wrote:
>> The problem appears at least on two models (Sony Vaio FW and Sony
>> Vaio VGN-NS11S). So I really don't agree with you "one report, from
>> one user, with one configuration, on one controller, using one
>> firmware set" statement, Alan.
> Thanks - yours was the only one I had seen references too. I don't
> spend my days reading the Ubuntu forums.
> 
>> (where issues like this have not been fixed yet).
> 
> Its probably a better idea to buy a computer that appears to work in the
> way it is expected yes. However there is more to making a good quality
> OS than running around flapping at every warped piece of hardware we
> meet. It would be good if this works but it would also be good to know
> therefore why it happens to work in Vista - are the delays longer, are
> they clearing some other undefined command bits that the spec says don't
> matter etc.
> 
> Simply saying 'oh it didn't work lets just pretend we don't care' isn't
> always a good idea, particuarly when the worst case failure for it on
> other devices where it indicates a real failing might be corruption of
> user data.
>
> Yes - I'd like it to just work, but I'd like it to just work without
> breaking anything else, without adding device specific special cases and
> ideally in a way that makes other stuff that is similarly odd just work
> too.

Then, how do you suggest proceeding on it?  Without a bus tracer, we
can't easily tell what Windows is doing and on native SATA skipping
SETXFER isn't likely to cause any serious problem.  It's basically
noop.

If you're worried about the match being triggered on unaffected
configurations, how about doing a DMI & device ID match, so we flip
the stupid quirk only on the stupid machine?  It's not like we're
adding a lot of complexities and it's not likely that someone would
invest the time and resource to root-cause problem this specific
unless it begins to appear on other places.  So, let's get the thing
working and if similar problems creep up on other machines, deal with
them then.

Thanks.

-- 
tejun
