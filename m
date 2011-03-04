From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Power off empty ports
Date: Fri, 4 Mar 2011 19:38:36 +0100
Message-ID: <20110304183836.GZ20499@htj.dyndns.org>
References: <20110304090644.GC20499@htj.dyndns.org>
 <1299263051-3739-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60089 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759923Ab1CDSin (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 13:38:43 -0500
Received: by bwz15 with SMTP id 15so2299212bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 10:38:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299263051-3739-1-git-send-email-kristen@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Mar 04, 2011 at 10:24:11AM -0800, Kristen Carlson Accardi wrote:
>  	case ATA_LPM_MIN_POWER:
> -		/* no restrictions on LPM transitions */
> -		scontrol &= ~(0x3 << 8);
> +		if (ata_link_nr_enabled(link) > 0)
> +			/* no restrictions on LPM transitions */
> +			scontrol &= ~(0x3 << 8);
> +		else {
> +			/* empty port, power off */
> +			scontrol &= ~0xf;
> +			scontrol |= (0x1 << 2);
> +		}

Why not just do the following?

	scontrol &= ~(0x3 << 8);
	/* if empty, power off */
	if (!ata_link_nr_enabled(link)) {
		scontrol &= ~0xf;
		scontrol |= 0x1 << 2;
	}

Also, can you please provide some details on on which hardware you
tested the change and how much power it actually saved?

Thanks.

-- 
tejun
