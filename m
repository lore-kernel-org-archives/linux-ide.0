From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: use 0x80 as wait stat value instead of 0xff
Date: Fri, 26 Jan 2007 17:28:33 -0500
Message-ID: <45BA8091.1080509@pobox.com>
References: <20070126063720.GG8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49010 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbXAZW2f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 17:28:35 -0500
In-Reply-To: <20070126063720.GG8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Before hardreset, ahci initialized stat part of received FIS area to
> 0xff to wait for the first D2H Reg FIS which would change the value to
> device ready state.  This used to work but now libata considers status
> value of 0xff as device not present making this wait prone to failure.
> 
> This patch makes ahci use 0x80 for the wait stat value instead of
> 0xff to fix the above problem.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  drivers/ata/ahci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For the future, please make sure to include the "---" terminator prior 
to the diffstat, otherwise it will get copied into the kernel changelog.

	Jeff



