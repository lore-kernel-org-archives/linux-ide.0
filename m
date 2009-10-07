From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] two ide fixes for -rc4
Date: Wed, 07 Oct 2009 04:06:56 -0700 (PDT)
Message-ID: <20091007.040656.62828073.davem@davemloft.net>
References: <alpine.LFD.2.01.0910061534040.3432@localhost.localdomain>
	<200910070246.05283.bzolnier@gmail.com>
	<20091007033005.GE21612@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757631AbZJGLHE@vger.kernel.org>
In-Reply-To: <20091007033005.GE21612@spacedout.fries.net>
Sender: linux-kernel-owner@vger.kernel.org
To: david@fries.net
Cc: bzolnier@gmail.com, torvalds@linux-foundation.org, joao.ramos@inov.pt, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: David Fries <david@fries.net>
Date: Tue, 6 Oct 2009 22:30:06 -0500

> On Wed, Oct 07, 2009 at 02:46:05AM +0200, Bartlomiej Zolnierkiewicz wrote:
>> The corrected version below, David please try it instead:
>> 
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Subject: [PATCH take 2] sis5513: fix PIO setup for ATAPI devices
> 
> 2.6.31 plus this patch fixed the hang on IDE initialization with the
> SIS5513.
> 
> That's with my testing mode, I'm rebuilding a kernel and will try some
> benchmarks tomorrow.  I've been testing by hibernating to disk,
> booting the test kernel with a bad root and resume partition (so if it
> worked it wouldn't modify the suspended image), then rebooting to
> resume from disk with the good kernel.  That let me more quickly
> bisect and test kernels, I just haven't ran this kernel much past the
> initialization is all.

All applied, thanks everyone.
