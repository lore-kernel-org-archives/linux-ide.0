From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on Gateway SJM11-YK
Date: Thu, 25 Mar 2010 08:38:06 +0900
Message-ID: <4BAAA25E.9050701@kernel.org>
References: <1267941081.3382.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46669 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab0CYHON (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:14:13 -0400
In-Reply-To: <1267941081.3382.16.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd Merrill <turmlos@comcast.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 03/07/2010 02:51 PM, Todd Merrill wrote:
> ahci: Enable SB600 64bit DMA on Gateway SJM11-YK
> 
> The SJM11-YK motherboard, found in Gateway LT31 series netbooks, can
> also support 64bit DMA. Tested with the earliest and latest known BIOS
> versions.
> 
> Applies to kernel 2.6.33.
> 
> Signed-off-by: Todd Merrill <turmlos@comcast.net>

Looks good to me but can you please detail how you tested it?

Thanks.

-- 
tejun
