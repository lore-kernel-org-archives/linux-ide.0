From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Wed, 7 Jan 2009 14:23:51 +0000
Message-ID: <20090107142351.79749c05@lxorguk.ukuu.org.uk>
References: <20090107141536.231980@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54239 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758135AbZAGOXd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 09:23:33 -0500
In-Reply-To: <20090107141536.231980@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Rigler <moritz1234567@gmx.de>
Cc: linux-ide@vger.kernel.org

> The problem appears at least on two models (Sony Vaio FW and Sony Vaio VGN-NS11S). So I really don't agree with you "one report, from one user, with one configuration, on one controller, using one firmware set" statement, Alan.

Thanks - yours was the only one I had seen references too. I don't spend
my days reading the Ubuntu forums.

> (where issues like this have not been fixed yet).

Its probably a better idea to buy a computer that appears to work in the
way it is expected yes. However there is more to making a good quality
OS than running around flapping at every warped piece of hardware we
meet. It would be good if this works but it would also be good to know
therefore why it happens to work in Vista - are the delays longer, are
they clearing some other undefined command bits that the spec says don't
matter etc.

Simply saying 'oh it didn't work lets just pretend we don't care' isn't
always a good idea, particuarly when the worst case failure for it on
other devices where it indicates a real failing might be corruption of
user data.

Yes - I'd like it to just work, but I'd like it to just work without
breaking anything else, without adding device specific special cases and
ideally in a way that makes other stuff that is similarly odd just work
too.

Alan
