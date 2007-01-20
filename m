From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix handling of port actions in per-dev action
 mask
Date: Fri, 19 Jan 2007 19:22:56 -0500
Message-ID: <45B160E0.3030905@pobox.com>
References: <20070118082218.GR10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53813 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932795AbXATAW7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:22:59 -0500
In-Reply-To: <20070118082218.GR10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata EH ignores port-wide actions in per-dev action mask.  However,
> device resume requests EH_SOFTRESET using per-dev action mask.  Under
> certain circumstances, this results in not resetting frozen port after
> resuming which causes failure of all commands.
> 
> This patch allows port-wide actions to be requested in per-dev action
> mask.  Before EH recovery starts, port-wide actions will be collected.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> After being tested, this one should go into -stable too.

applied to #upstream-fixes


