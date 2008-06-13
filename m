From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SB600 SATA controller PMP support
Date: Fri, 13 Jun 2008 02:42:39 -0400
Message-ID: <485216DF.7050309@pobox.com>
References: <1213084324.5808.6.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40294 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbYFMGmp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 02:42:45 -0400
In-Reply-To: <1213084324.5808.6.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> Hi Tejun and Jeff,
> 
> Tejun wrote:
>> I think it's in the right direction.  Just a few nits...
> 
> I modified the SATA PMP patch with your nice suggestions,
> please check the updated one below.
> 
> Thanks
> Shane
> 
> ====== CUT HERE =====
> There is one bug in ATI SATA PMP of SB600 and SB700 old revision, which leads
> to soft reset failure. This patch can fix the bug.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Acked-by: Tejun Heo <htejun@gmail.com>

applied


