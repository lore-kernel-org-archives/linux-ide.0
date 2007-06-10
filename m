From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] remove unused variable in pata_isapnp
Date: Sat, 09 Jun 2007 22:41:43 -0400
Message-ID: <466B64E7.9060306@garzik.org>
References: <20070605223329.5bdce4f0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35815 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbXFJClr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:41:47 -0400
In-Reply-To: <20070605223329.5bdce4f0.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-ide@vger.kernel.org

Yoichi Yuasa wrote:
> Hi,
> 
> This patch has removed unused variable in pata_ispnp.
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

applied

For the future, please put anything that should not be copied into the 
permanent kernel changelog following a "---" separator, as described in 
Documentation/SubmittingPatches.  "Hi," and "Yoichi" had to be 
hand-edited out of your patch, before it was merged via automatic patch 
application scripts.


