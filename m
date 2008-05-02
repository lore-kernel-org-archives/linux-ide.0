From: Mark Lord <liml@rtr.ca>
Subject: Re: dvd writing problem
Date: Fri, 02 May 2008 08:52:25 -0400
Message-ID: <481B0E89.9090407@rtr.ca>
References: <200805011135.38556.gene.heskett@gmail.com> <20080501224233.c3e11762.akpm@linux-foundation.org> <200805020821.44932.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4292 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760627AbYEBMw0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 08:52:26 -0400
In-Reply-To: <200805020821.44932.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Gene Heskett wrote:
..
>>> 7. disc is a +RW disc, so it should be re-writable.  Pick a different .iso
>>> and start k3b again using it.  K3b goes through the motions, but 2 or 3
>>> seconds after the real write starts with perhaps 30 megabytes *supposedly*
>>> written, k3b gets a write error and the burn bails out, ejecting the disc
>>> as it does.
..

For this part, did you *erase* the disc before attempting to rewrite?
This is necessary, and there's a checkbox somewhere in K3B to have it
do so automatically.

The rest of the report (no verify after write, and system lockups)
looks much more serious.  I cannot help with those, but others here
probably can.  It's just a matter of somebody else following your
recipe to repeat it, and then instrumenting libata/scsi to see
where the faults lie.

Cheers
