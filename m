From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sil24: add constants
Date: Wed, 16 Nov 2005 12:37:29 -0500
Message-ID: <437B6E59.7000304@pobox.com>
References: <20051116075649.GA22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37813 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030185AbVKPRhd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 12:37:33 -0500
In-Reply-To: <20051116075649.GA22807@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> +	SGE_DRD			= (1 << 29), /* discard data read (/dev/null)
> +						data address ignored */


BTW, I'm wondering if sil24 can implement ATAPI padding using this.

I'm willing to bet some other hardware will allow us to simply append a 
static S/G descriptor, pointing to zeroed memory, whose length is <4 bytes.

In both cases, we could avoid all the nasty pad handling code.

	Jeff


