From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream-fixes] sata_nv: rename nv_nf2_hardreset()
Date: Mon, 26 Jan 2009 06:40:09 -0500
Message-ID: <497DA119.4020404@garzik.org>
References: <497BCD92.2050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55171 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbZAZLkN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:40:13 -0500
In-Reply-To: <497BCD92.2050707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>, gpanco@tiscali.it

Tejun Heo wrote:
> nv_nf2_hardreset() will be used by other flavors too.  Rename it to
> nv_noclassify_hardreset().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/sata_nv.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

applied 1-2


