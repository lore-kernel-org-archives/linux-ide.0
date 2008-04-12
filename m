From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: make EH fail gracefully if no reset
 method is available
Date: Sat, 12 Apr 2008 01:18:15 -0400
Message-ID: <48004617.9030808@garzik.org>
References: <47A040E2.1050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37484 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbYDLFSS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 01:18:18 -0400
In-Reply-To: <47A040E2.1050801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> When no reset method is available, libata currently oopses.  Although
> the condition can't happen unless there's a bug in a low level driver,
> oopsing isn't the best way to report the error condition.  Complain,
> dump stack and fail reset instead.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patch is on top of
> 
> upstream (a984f58dd97f22f5113700322fed311a0ee29947)
> + prefer-hardreset patchset
>   http://thread.gmane.org/gmane.linux.ide/27447
> 
>  drivers/ata/libata-eh.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

applied


