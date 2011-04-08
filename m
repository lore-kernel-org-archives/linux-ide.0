From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Fri, 8 Apr 2011 08:59:18 -0700
Message-ID: <20110408155918.GA3871@mtj.dyndns.org>
References: <201104071854.10911.morpheus.ibis@gmail.com>
 <201104072140.59548.morpheus.ibis@gmail.com>
 <4D9E9605.7030304@garzik.org>
 <201104081005.37191.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38283 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1DHP7Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 11:59:24 -0400
Received: by vxi39 with SMTP id 39so2815296vxi.19
        for <linux-ide@vger.kernel.org>; Fri, 08 Apr 2011 08:59:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104081005.37191.morpheus.ibis@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Herrmann <morpheus.ibis@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hey,

On Fri, Apr 08, 2011 at 10:05:37AM +0200, Pavel Herrmann wrote:
> +	} else if (vendor == 0x197b && devid == 0x2352) {
> +		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
> +		ata_for_each_link(link, ap, EDGE) {
> +			/* Use same quirks as sil chips	to make it work,
> +			 * not everything might be necessary though
> +			 */
> +			link->flags |= ATA_LFLAG_NO_LPM |
> +				       ATA_LFLAG_NO_SRST |
> +				       ATA_LFLAG_ASSUME_ATA;
> +		}

Can you please do the followings?

* Post dmesg w/o the patch.

* Try different combinations of the flags and see which ones are
  essential.

Thanks.

-- 
tejun
