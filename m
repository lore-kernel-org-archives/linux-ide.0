From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: only enable the first port on apple macbook
 pro
Date: Fri, 23 Nov 2007 20:22:04 -0500
Message-ID: <47477CBC.8050501@garzik.org>
References: <20071119041459.GA30919@htj.mynetwork.cxm> <20071119041600.GB30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38295 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbXKXBWG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:22:06 -0500
In-Reply-To: <20071119041600.GB30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, tr@tng.de

Tejun Heo wrote:
> From: Thomas Rohwer <tr@tng.de>
> 
> ICH8M on apple macbook pro occasionally locks up completely during PCS
> initialization if ports other than the first one are enabled.  Add a
> separate controller ID and only enable the first port.
> 
> tj: commit description added and patch updated to fit with the
>     previous controller ID update.
> 
> Signed-off-by: Thomas Rohwer <tr@tng.de>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> applied to #tj-upstream-fixes

ACK


