From: Dan <metalifloyd@gmail.com>
Subject: Re: PROBLEM: SATA AHCI driver significant throughput loss in 2.6.22-rc5-g75154f40-dirty
Date: Sun, 1 Jul 2007 12:56:36 -0400
Message-ID: <439fa30707010956h1c467e28xc9eff37ebec523ad@mail.gmail.com>
References: <439fa30706262117u2d5553dfp8395c6ca41574a8c@mail.gmail.com>
	 <20070630005747.9bc9ba40.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:62302 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbXGAQ4h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 12:56:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1292539wxd
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 09:56:37 -0700 (PDT)
In-Reply-To: <20070630005747.9bc9ba40.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Are you able (as a matter of some urgency) to run a git bisection
> search to identify the offending commit?

For some reason I am no longer able to reproduce the problem. I've
tried several versions including the one I reported and I just can't
reproduce the problem. I accidentally overwrote the original kernel
that had the problem. The weird thing is even when I reset the git
tree to 2.6.22-rc5-g75154f40 and build it, the error is gone.

I've tested with the latest git and all seems well so far. I'll keep a
close eye out and will try to run bisect to find the problem. Sorry, I
should have done that in the first place (Didn't know about it).


-Dan
