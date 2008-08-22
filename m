From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: sis controllers actually can do
 PMP
Date: Fri, 22 Aug 2008 02:20:36 -0400
Message-ID: <48AE5AB4.9030708@garzik.org>
References: <4892884F.5000805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37298 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYHVGUj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:20:39 -0400
In-Reply-To: <4892884F.5000805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, piterpunk@slackware.com

Tejun Heo wrote:
> SIS controllers were blacklisted for PMP as enabling it made device
> detection fail whether the device was PMP or not - the natural
> conclusion was the controller chokes on SRST w/ pmp==15.  However, it
> turned out that the controller just didn't like issuing SRST after
> hardreset w/o clearing SError first.  Interestingly, the SRST itself
> succeeds but the following commands fail.
> 
> If SError is cleared between hardreset and SRST, which is the default
> behavior now, everything works fine and SIS controllers work with PMPs
> happily.
> 
> Remove PMP blacklisting for SIS AHCIs.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Piter PUNK <piterpunk@slackware.com>
> ---
>  drivers/ata/ahci.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

applied


