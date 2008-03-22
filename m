From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.25-rc6-git6: Reported regressions from 2.6.24
Date: Sat, 22 Mar 2008 12:11:44 +0100
Message-ID: <20080322111144.GB13264@elte.hu>
References: <200803220259.48534.rjw@sisk.pl> <47E4745D.3090902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:33395 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbYCVLMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Mar 2008 07:12:13 -0400
Content-Disposition: inline
In-Reply-To: <47E4745D.3090902@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Su, Henry" <Henry.Su@amd.com>, "Cai, Crane" <Crane.Cai@amd.com>, Shane Huang <Shane.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>


* Jeff Garzik <jeff@garzik.org> wrote:

>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=9412
>> Subject		: Since commit 'x86: enable iommu_merge by default' (948062683004d13ca21c8c05ac052d387978a449) 2.6 is no go on SB600 AHCI
>> Submitter	: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
>> Date		: 2007-11-19 14:43 (124 days old)
>
> This one seems to imply that the workaround approved by AMD/ATI didn't 
> work...
>
> (AMD folks CC'd...)

note, the 'Subject' is wrong, we resolved the original regression on 
2007-11-26, 7 days after it was reported. This is about a bug with 
similar symptoms, reopened 10 days ago. Jeff, could you please change 
the bugzilla entry so that it reflects that it's an SB600 problem?

	Ingo
