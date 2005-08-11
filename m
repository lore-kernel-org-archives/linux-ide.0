From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 00/07] sil24: misc fixes
Date: Thu, 11 Aug 2005 15:21:47 -0400
Message-ID: <42FBA54B.8030602@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:61607 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932399AbVHKTVw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:21:52 -0400
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

Tejun Heo wrote:
>  Hello, Jeff & Carlos.
> 
>  These patches are misc fixes suggested by Jeff for rewritten sil24
> driver.  The follwing issues are not fixed in this patchset.  I need
> more info to work on these.
> 
>  * Device signature access on reset.
>  * How to discern completion interrupts from error ones.
>  * 64bit activation
>  * Removal of PORT_RST in sil24_init_one().
> 
> [ Start of patch descriptions ]

Just sent review comments on this patchset.  I'll now delete it from my 
inbox, and wait for the next iteration.

	Jeff



