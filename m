From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA Sil680 Command Timeout on ARM XScale
Date: Tue, 13 Mar 2007 19:39:57 +0000
Message-ID: <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>
References: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37710 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932081AbXCMSgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 14:36:42 -0400
In-Reply-To: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

> above 1.5.   Two timers are used to track command timeout in our test
> software.  The one in the user space is set to 6 seconds using alarm()
> call while the one in the kernel (scsi timer) is set to 5 seconds.
> These timeout values are probably too low to be realistic,  but the
> issue here is not about the timeout itself but to understand why it is

A lot of drive commands seem to be set up on a seven second worst case

> always user space timer expired before kernel timer.   Since kernel
> timer uses jiffies to track time, does this imply a kernel bug where
> the time interrupts were lost or delay somehow?  Do you know any know
> problems related to command timeout in PATA Sil680?

Alarm() is also handled by the same jiffies logic, so I suspect a bug in
your test environment ?

