From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] fix BUG with IDE taskfile ioctl and cfq
Date: Tue, 06 Apr 2010 16:45:11 -0700 (PDT)
Message-ID: <20100406.164511.24613147.davem@davemloft.net>
References: <Pine.LNX.4.64.1004061924430.27367@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34384
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080Ab0DFXpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 19:45:08 -0400
In-Reply-To: <Pine.LNX.4.64.1004061924430.27367@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: linux-ide@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 6 Apr 2010 19:29:57 -0400 (EDT)

> Fix IDE taskfile with cfq scheduler
> 
> When ide taskfile access is being used (for example with hdparm --security
> commands) and cfq scheduler is selected, the scheduler crashes on BUG in
> cfq_put_request.
> 
> The reason is that the cfq scheduler is tracking counts of read and write
> requests separately; the ide-taskfile subsystem allocates a read request and
> then flips the flag to make it a write request. The counters in cfq will
> mismatch.
> 
> This patch changes ide-taskfile to allocate the READ or WRITE request as
> required and don't change the flag later.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Applied and queued up for -stable, thanks again Mikulas.
