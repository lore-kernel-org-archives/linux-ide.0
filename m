From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: ck804 has borked hardreset too
Date: Mon, 02 Feb 2009 23:04:59 -0500
Message-ID: <4987C26B.9050802@garzik.org>
References: <4985014F.7070607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39874 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbZBCEFF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:05:05 -0500
In-Reply-To: <4985014F.7070607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> While playing with nvraid, I found out that rmmoding and insmoding
> often trigger hardreset failure on the first port (the second one was
> always okay).  Seriously, how diverse can you get with hardreset
> behaviors?  Anyways, make ck804 use noclassify variant too.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Robert, ISTR that a user was reporting probing problem on ck804, I
> think the user could have been seeing this.  The behavior on my
> motherboard is very curious.  The problem is always with the first
> port.  If booted from cdrom, it always fails.  If booted from
> harddrive, the initial probing works fine but from the second time on,
> it fails.  Argh...
> 
>  drivers/ata/sata_nv.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

applied


