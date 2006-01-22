From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/12] libata: ignore normal qc completion during EH
Date: Sun, 22 Jan 2006 04:53:45 -0500
Message-ID: <43D35629.8030409@pobox.com>
References: <11379167111733-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:30182 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932329AbWAVJxx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:53:53 -0500
In-Reply-To: <11379167111733-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Don't let interrupt handler and pio task complete qc's while EH is in
> progress.  This makes sure that qc's don't go away underneath EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I haven't done an in-depth analysis, but this feels like the wrong 
approach:  you've still got drivers writing to qc->err_mask, and 
potentially other struct members.

The better solution is most likely to examine the interrupt handling 
paths of each driver...

	Jeff


