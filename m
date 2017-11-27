From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: sata_down_spd_limit should return if driver has
 not recorded sstatus speed
Date: Mon, 27 Nov 2017 11:19:48 -0800
Message-ID: <20171127191948.GH983427@devbig577.frc2.facebook.com>
References: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:38680 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdK0TTv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2017 14:19:51 -0500
Received: by mail-qk0-f170.google.com with SMTP id a142so33917938qkb.5
        for <linux-ide@vger.kernel.org>; Mon, 27 Nov 2017 11:19:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello, David.

On Tue, Nov 14, 2017 at 04:17:25PM -0600, David Milburn wrote:
> During hotplug, it is possible for 6Gbps link speed to
> be limited all the way down to 1.5 Gbps which may lead
> to a slower link speed when drive is re-connected.

Can you please explain the scenario with more details?

>  	/* Mask off all speeds higher than or equal to the current
> -	 * one.  Force 1.5Gbps if current SPD is not available.
> +	 * one. At this point if current SPD is not available and we
> +	 * previously recorded the link speed from the Status register,
> +	 * the driver has already masked off the highest bit so mask
> +	 * should already be set to 1 or 0. Otherwise, we should
> +	 * not force 1.5Gbps on a link where we have not previously 
> +	 * recorded speed from Status register, just return in this case.
>  	 */
>  	if (spd > 1)
>  		mask &= (1 << (spd - 1)) - 1;
>  	else
> -		mask &= 1;
> +		return -EINVAL;

I get that the current behavior might not be ideal in certain
scenarios but the above seems weird, especially given the we have
link->sata_spd for cases where we can't access the spd value.

Thanks.

-- 
tejun
