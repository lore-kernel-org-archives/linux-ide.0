From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 12:52:34 -0500
Message-ID: <4B69B7E2.4070808@pobox.com>
References: <1265151518.2800.715.camel@mulgrave.site>	<20100202150537.0f6a01c0.akpm@linux-foundation.org>	<4B68B1E0.4090004@pobox.com>	<20100202.152140.216335166.davem@davemloft.net>	<1265153568.2800.815.camel@mulgrave.site>	<1265192325.1970.28.camel@pc1117.cambridge.arm.com>	<1265215254.2873.201.camel@mulgrave.site>	<4B69ABCA.1030507@pobox.com>	<20100203090631.44753f3b.akpm@linux-foundation.org>	<4B69AF42.5050508@pobox.com> <20100203174620.0fba7837@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:57505 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab0BCRwi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:52:38 -0500
Received: by ywh36 with SMTP id 36so1507112ywh.15
        for <linux-ide@vger.kernel.org>; Wed, 03 Feb 2010 09:52:37 -0800 (PST)
In-Reply-To: <20100203174620.0fba7837@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, James Bottomley <James.Bottomley@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On 02/03/2010 12:46 PM, Alan Cox wrote:
> And indeed there was a patch I proposed in 2008 for this bounce
> buffer latency: See the archive
>
> Date: Fri, 29 Feb 2008 13:51:06 +0000
> From: Alan Cox<alan@lxorguk.ukuu.org.uk>
> To: linux-ide@vger.kernel.org, jeff@garzik.org
> Subject: [RFC PATCH] libata: PIO via bounce buffer
>
> although it doesn't deal with the dcache coherency issue and seems to
> need a little tweaking to apply due to other changes

Yeah, I definitely liked the idea.  I wonder if we could do the 
allocation during port_start rather than at the time of bounce?  One 
maximally-sized buffer per device should not be too punishing on the 
system, IMO.

In any case, it is a nice approach to pursue.

	Jeff



