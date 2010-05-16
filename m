From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/8] SCSI: implement sd_unlock_native_capacity()
Date: Sun, 16 May 2010 00:18:04 -0700 (PDT)
Message-ID: <20100516.001804.26961702.davem@davemloft.net>
References: <1273946974-29131-1-git-send-email-tj@kernel.org>
	<1273946974-29131-7-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53540
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753166Ab0EPHRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 May 2010 03:17:55 -0400
In-Reply-To: <1273946974-29131-7-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-scsi@vger.kernel.org, James.Bottomley@suse.de, linux-kernel@vger.kernel.org, ben@decadent.org.uk, bzolnier@gmail.com

From: Tejun Heo <tj@kernel.org>
Date: Sat, 15 May 2010 20:09:32 +0200

> Implement sd_unlock_native_capacity() method which calls into
> hostt->unlock_native_capacity() if implemented.  This will be invoked
> by block layer if partitions extend beyond the end of the device and
> can be used to implement, for example, on-demand ATA host protected
> area unlocking.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
