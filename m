From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/12] libata: implement EH fast drain
Date: Tue, 03 Jul 2007 10:37:34 -0400
Message-ID: <468A5F2E.9020002@garzik.org>
References: <1183283618296-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60585 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbXGCOhh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:37:37 -0400
In-Reply-To: <1183283618296-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> In most cases, when EH is scheduled, all in-flight commands are
> aborted causing EH to kick in immediately.  However, in some cases
> (especially with PMP), it's unclear which commands are affected by the
> error condition and although aborting all in-flight commands work, it
> isn't optimal and may cause unnecessary disruption.  On the other
> hand, waiting for in-flight commands to drain themselves can take up
> to 30seconds.
> 
> This patch implements EH fast drain to handle such situations.  It
> gives in-flight commands some time to finish up but doesn't wait for
> too long.  After EH is scheduled, fast drain timer is started and if
> no other completion occurs in ATA_EH_FASTDRAIN_INTERVAL all in-flight
> commands are aborted.  If any completion occurred in the interval, the
> port is given another interval to finish up itself.
> 
> Currently ATA_EH_FASTDRAIN_INTERVAL is 3 secs which should be enough
> for finishing up most commands.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

what type of errors are we talking about?  device errors can be handled 
on a more granular basis than other errors.


