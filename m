From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.25-rc6-git6: Reported regressions from 2.6.24
Date: Fri, 21 Mar 2008 22:52:13 -0400
Message-ID: <47E4745D.3090902@garzik.org>
References: <200803220259.48534.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50276 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126AbYCVCwS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Mar 2008 22:52:18 -0400
In-Reply-To: <200803220259.48534.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Su, Henry" <Henry.Su@amd.com>, "Cai, Crane" <Crane.Cai@amd.com>, Shane Huang <Shane.Huang@amd.com>

Rafael J. Wysocki wrote:
> Unresolved regressions
> ----------------------
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=9412
> Subject		: Since commit 'x86: enable iommu_merge by default' (948062683004d13ca21c8c05ac052d387978a449) 2.6 is no go on SB600 AHCI
> Submitter	: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
> Date		: 2007-11-19 14:43 (124 days old)


This one seems to imply that the workaround approved by AMD/ATI didn't 
work...

(AMD folks CC'd...)

	Jeff


