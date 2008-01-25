From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 15/14] sata_mv NCQ support
Date: Fri, 25 Jan 2008 09:08:21 +0900
Message-ID: <47992875.4040503@gmail.com>
References: <4798FB68.70400@rtr.ca> <4799277F.8020300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:45640 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYAYAI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 19:08:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so451921rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 16:08:26 -0800 (PST)
In-Reply-To: <4799277F.8020300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Add missing qc_defer op.
> 
> This is necessary now that we support NCQ in the driver.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
