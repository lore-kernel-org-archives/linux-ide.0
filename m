From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 8 Sep 2007 11:19:17 -0600
Message-ID: <20070908171917.GC6809@parisc-linux.org>
References: <20070906210505.GF27404@parisc-linux.org> <46E258F3.20805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:41398 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbXIHRTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:19:18 -0400
Content-Disposition: inline
In-Reply-To: <46E258F3.20805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, Sep 08, 2007 at 05:10:27PM +0900, Tejun Heo wrote:
> I think it's generally okay although it would need to spend quite some
> time in -mm and we'll need to exclude several drivers which require
> host-wide silence for mode programming (the current code is buggy but
> sequential probing hides it pretty well) till host-wide exclusion is
> implemented.

Can you tell me a bit more about these drivers?  Would it be possible to
convert them to one host/many channels, which would give us the exclusion
we want?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
