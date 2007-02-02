From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: Initialize nbytes for internal sg commands
Date: Fri, 02 Feb 2007 11:54:13 -0500
Message-ID: <45C36CB5.50704@garzik.org>
References: <1170178343430-patch-mail.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49896 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945972AbXBBQyQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:54:16 -0500
In-Reply-To: <1170178343430-patch-mail.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: linux-ide@vger.kernel.org, brazilnut@linux.vnet.ibm.com

Brian King wrote:
> Some LLDDs, like ipr, use nbytes and pad_len to determine
> the total data transfer length of a command. Make sure
> nbytes gets initialized for internally generated commands.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
> Jeff,
> 
> This bug is already fixed in #upstream, with Tejun's patch,
> which does away with nsect, but it is still broken in 2.6.20.
> This is a resend of my original, 1 line patch. If this doesn't
> make 2.6.20, it might be a candidate for -stable, since without
> it, libata is not able to find SATA devices attached with ipr.
> 
> Thanks,
> 
> Brian
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

applied


