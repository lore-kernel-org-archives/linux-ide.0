From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Wed, 26 Jan 2011 10:00:57 +0000
Message-ID: <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk> <20110124170432.GH27510@htj.dyndns.org> <4D3EA771.3070206@mrc-lmb.cam.ac.uk> <20110125105049.GQ27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:40513 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab1AZKBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2011 05:01:00 -0500
In-Reply-To: <20110125105049.GQ27510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> (please always reply-to-all)

OK :)

> Yes, that definitely would be a good idea.  The first thing I would
> try is disabling the VIA FIFO workaround completely and see whether
> that makes any difference.

Just a quick progress note. I'm most familiar with Suse and not familiar
with kernel builds so last night I installed the pre-built
Kernel:/HEAD/11.2 kernel from the opensuse build service. It's 2.6.37.

It appeared to run without problem* so it seems that whatever fixed my
issue was at least not specific to the Knoppix kernel. FWIW, I've put
the dmesg at:

http://pastebin.com/bWUNr8Ve

It was late so all I did was copy a 1.7 GB file to and from the new disk
on the VT6241A controller. No errors were logged. Incidentally, what's
the best way of testing for this type of reliability?

Tonight I plan to compile that kernel, which should confirm that I
understand how to do it, and then I'll disable the VIA FIFO workaround
as you suggest and see what happens.

Cheers, Dave

* PS There was one oddity, which was that Evolution crashed at around
the same moment as I was mounting a logical volume from the new disk. I
didn't investigate and it restarted OK.
