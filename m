From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: kill the infamous abnormal status
 message
Date: Wed, 27 Jun 2007 02:45:09 -0400
Message-ID: <46820775.8030204@garzik.org>
References: <467FB589.2060900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37951 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761047AbXF0GpL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:11 -0400
In-Reply-To: <467FB589.2060900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> The infamous abnormal status message triggers on not so abnormal cases
> including empty port and even when it's being triggered on actual
> errors the info it provides is redundant and out of context - higher
> level functions will print the info in better safe later anyway.
> 
> Also, by being triggered all the time, it leads people to think that
> the abnormality is somehow related to all ATA and system problems
> they're experiencing and gives owners of healthy systems unfounded
> doubts about the integrity of the universe.  Make it a DPRINTK and
> save the universe.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  include/linux/libata.h |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

applied


