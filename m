From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Maxtor 6B250S0/BANC1B70 hangs with NCQ
Date: Fri, 30 Mar 2007 16:40:03 +0900
Message-ID: <460CBED3.2050305@gmail.com>
References: <20070330072757.GC6246@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:27076 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbXC3HkJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Mar 2007 03:40:09 -0400
Received: by wr-out-0506.google.com with SMTP id 76so534653wra
        for <linux-ide@vger.kernel.org>; Fri, 30 Mar 2007 00:40:09 -0700 (PDT)
In-Reply-To: <20070330072757.GC6246@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

Jens Axboe wrote:
> Hi,
> 
> I've seen this several times on this drive, completely reproducible.
> Once it has hung, power needs to be cut from the drive to recover it, a
> simple reboot is not enough. So I'd suggest disabling NCQ on this
> driver.
> 
> Error log attached.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
