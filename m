From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: SATA_DWC COMPILE_TEST is nasty horrid stuff (was "GIT PULL]
 libata changes for v3.20-rc1")
Date: Wed, 11 Feb 2015 13:53:21 +0200
Message-ID: <1423655601.31903.499.camel@linux.intel.com>
References: <CA+55aFwwp3xEgjk3Qo_CHLKLXA6hOtqSaLwCPJzj34f5AHKRhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44925 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbbBKLxY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2015 06:53:24 -0500
In-Reply-To: <CA+55aFwwp3xEgjk3Qo_CHLKLXA6hOtqSaLwCPJzj34f5AHKRhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>

On Tue, 2015-02-10 at 17:44 -0800, Linus Torvalds wrote:

[]

> You guys can try again when the driver has actually been cleaned up
> and might compile cleanly. Right now it's just nasty, and looking at
> the code I think that the thing is fundamentally wrong and cannot work
> outside of its original environment (ppc 460ex, apparently) anyway.

Sorry, that was my idea to get it compile tested since I'm trying to
clean up this piece of code that produces nasty warnings.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

