From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/10] libata: fix sata_link_hardreset() @online out parameter
 handling
Date: Mon, 19 May 2008 17:53:09 -0400
Message-ID: <4831F6C5.2090208@garzik.org>
References: <12111273141039-git-send-email-htejun@gmail.com> <12111273153728-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35933 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756818AbYESVxL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 17:53:11 -0400
In-Reply-To: <12111273153728-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> The @online out parameter is supposed to set to true iff link is
> online and reset succeeded as advertised in the function description
> and callers are coded expecting that.  However, sata_link_reset()
> didn't behave this way on device readiness test failure.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

applied 1-10


