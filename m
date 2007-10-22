From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 14:37:08 -0400
Message-ID: <471CEDD4.5040201@garzik.org>
References: <471C6C44.2030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38567 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbXJVShM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 14:37:12 -0400
In-Reply-To: <471C6C44.2030607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> Hello, all.
> 
> There was a bug report involving ATA tape drive STT3401A and the drive
> also sets DRQ with device error and works correctly if the check is
> ignored.  I saw patch implementing needed horkage.  What's the plan
> here?  Blacklist all tape drives or individual ones as they come up?

I should dig out the SATA (yes, really) tape drive somebody sent me.

	Jeff



