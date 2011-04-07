From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Thu, 7 Apr 2011 12:03:00 -0700
Message-ID: <20110407190300.GA8841@mtj.dyndns.org>
References: <201104071854.10911.morpheus.ibis@gmail.com>
 <201104071908.10852.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60049 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab1DGTDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2011 15:03:07 -0400
Received: by vws1 with SMTP id 1so2167005vws.19
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2011 12:03:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104071908.10852.morpheus.ibis@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Herrmann <morpheus.ibis@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, Apr 07, 2011 at 07:08:10PM +0200, Pavel Herrmann wrote:
> +	} else if (vendor == 0x1095 && devid == 0x4726) {
> +		/* chip found in Thermaltake BlackX Duet */
> +		ata_for_each_link(link, ap, EDGE) {
> +			/* Use same quirks as sil chips	to make it work */
> +			link->flags |= ATA_LFLAG_NO_LPM |
> +				       ATA_LFLAG_NO_SRST |
> +				       ATA_LFLAG_ASSUME_ATA;
> +		}

I'm confused.  Against which version is the patch generated?  Upstream
already has quirks for 4726.

Thakns.

-- 
tejun
