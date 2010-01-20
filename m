From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
 	write
Date: Wed, 20 Jan 2010 15:55:05 +0900
Message-ID: <4B56A8C9.2000807@gmail.com>
References: <20100116235653.898098245@gmail.com>	 <20100116235851.884756038@gmail.com> <4B5678E2.2050709@gmail.com> <7eb6a4d81001192244k19d28805p9cb4eaec7eed9366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:32973 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab0ATGtA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 01:49:00 -0500
In-Reply-To: <7eb6a4d81001192244k19d28805p9cb4eaec7eed9366@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com

Hello,

On 01/20/2010 03:44 PM, Bart Hartgers wrote:
> Yes, you're right. I'll drop the printk_once and send another patch
> for inclusion. However, for testing I found it very useful to make
> sure that I got the right module loaded. So I figured it could be
> helpful for the interpretation of success/failure reports.

Oh yeah, for testing, having it there is a good idea.

> Assuming that this patch works for other people as well, what is
> prefered: resending both patches or just to make a new #2/2 (the
> vt6420 one)?

I think just re-doing the second patch should be enough.

Thanks.

-- 
tejun
