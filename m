From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: jmb361 has only one port
Date: Wed, 18 Jun 2008 20:28:31 -0400
Message-ID: <4859A82F.9010706@garzik.org>
References: <48573396.9050308@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40143 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571AbYFSA2f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 20:28:35 -0400
In-Reply-To: <48573396.9050308@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, gajo01@gmail.com

Tejun Heo wrote:
> JMB361 has only one port but reports it has two causing longish probe
> failure on the second one.  Quirk it.
> 
> Reported by Gajo Petrovic in bz 10911.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Gajo Petrovic <gajo01@gmail.com>
> ---
> Another hardware-specific workaround for #upstream-fixes.
> 
>  drivers/ata/ahci.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

applied


