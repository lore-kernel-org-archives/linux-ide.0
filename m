From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: fix loop with last port
Date: Mon, 11 Feb 2008 14:31:11 -0500
Message-ID: <47B0A27F.90401@garzik.org>
References: <200802071506.17459.yinghai.lu@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55279 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634AbYBKTbO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:31:14 -0500
In-Reply-To: <200802071506.17459.yinghai.lu@sun.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yinghai Lu <Yinghai.Lu@Sun.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Saeed Bishara <saeed@marvell.com>

Yinghai Lu wrote:
> [PATCH] sata_mv: fix loop with last port
> 
> commit f351b2d638c3cb0b95adde3549b7bfaf3f991dfa
>         sata_mv: Support SoC controllers
> 
> cause panic:
[...]
> last_port already include port0 base.
> this patch change use last_port directly, and move pp assignment later.
> 
> Signed-off-by: Yinghai Lu <yinghai.lu@sun.com>

applied

Please don't repeat the email subject line in the email body, as that 
causes it to be duplicated in the permanent kernel changelog.

