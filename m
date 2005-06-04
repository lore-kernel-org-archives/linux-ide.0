From: Greg Stark <gsstark@mit.edu>
Subject: Re: [SATA] libata-dev queue updated
Date: 04 Jun 2005 15:15:24 -0400
Message-ID: <87psv2j5mb.fsf@stark.xeocode.com>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
	<42A1FB91.5060702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stark.xeocode.com ([216.58.44.227]:33725 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261423AbVFDTPs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Jun 2005 15:15:48 -0400
In-Reply-To: <42A1FB91.5060702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Greg Stark <gsstark@mit.edu>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>


Jeff Garzik <jgarzik@pobox.com> writes:

> All my development is in public; all the data is there for anyone who wishes to
> use it.

That is cool. And it's nice that there seems to have been an upsurge in the
quantity of communication from you and other libata developers on this list
too.

I expect if git catches on then it would be about as effective as most
projects which publish their CVS tree and expect people to be able to do
checkouts from there. Currently, though, approximately nobody has git tools or
any idea how to use it.


So my question is, if I did tackle this riddle trail and figured out how to
fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
just start working? Or would it just confuse the SMART tools until they're
updated? Or would it just crash my machine?


-- 
greg

