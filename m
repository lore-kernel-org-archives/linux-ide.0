From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.17-rc6] sata_mv: grab host lock inside eng_timeout
Date: Sun, 11 Jun 2006 23:06:07 -0400
Message-ID: <448CDA1F.7080605@garzik.org>
References: <200606071253.29745.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8686 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbWFLDGJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:06:09 -0400
In-Reply-To: <200606071253.29745.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>

Mark Lord wrote:
> Bug fix:  mv_eng_timeout() calls mv_err_intr() without first grabbing the host lock,
> which can lead to all sorts of interesting scenarios.
> 
> This whole error-handling portion of sata_mv is nasty (and will get fixed for
> the new EH stuff), but for now this patch will help keep it on life-support.
> 
> Signed-off-by:  Mark Lord <liml@rtr.ca>

applied


