From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: don't check n_sectors during
 revalidation if zero
Date: Thu, 23 Aug 2007 05:34:19 -0400
Message-ID: <46CD549B.5030200@garzik.org>
References: <20070817094651.GJ21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59625 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762285AbXHWJeX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:34:23 -0400
In-Reply-To: <20070817094651.GJ21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> If the initial configuration fails early, n_sectors is left at zero.
> Checking against it during revalidation makes retried configuration
> fail due to n_sectors mismatch.  Ignore zero n_sectors during
> revalidation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied


