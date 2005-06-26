From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: lengthen COMMRESET delay
Date: Sun, 26 Jun 2005 13:19:39 -0400
Message-ID: <42BEE3AB.2010601@pobox.com>
References: <20050626142719.GA24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:1484 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261471AbVFZRTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:19:44 -0400
In-Reply-To: <20050626142719.GA24968@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This is the first patch of a series of updates to the ncq head of
> libata-dev-2.6 tree.  The first six patches (including this one) are
> independent misc updates/fixes, so I'm posting each of those patches
> as a separate mail.  After the six patches, a patchset consisted of 8
> patches follows which moves most of NCQ completion/error-handling to
> libata-core layer and implements proper error-handling.
> 
>  This patch lengthens the delay between DET setting and clearing for
> COMMRESET from 400us to 1ms.  I couldn't find any requiremen regarding
> the duration of COMMRESET in SATA I/II specs but AHCI-1.1 10.4.2
> states that it should be at least 1ms.
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK (i.e. I will apply this patch)


