From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ata_eh_suspend() return value
Date: Sat, 27 Jan 2007 03:22:48 -0500
Message-ID: <45BB0BD8.3020408@pobox.com>
References: <20070126111025.GH8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51885 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbXA0IWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Jan 2007 03:22:51 -0500
In-Reply-To: <20070126111025.GH8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_eh_suspend() was returning 0 regardless of failure.  This bug has
> potential to lose data on suspend.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this one is definitely for 2.6.20.  Thanks.

applied


