From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix spurious WARN_ON_ONCE() on port freeze
Date: Thu, 17 Sep 2009 16:49:45 -0400
Message-ID: <4AB2A0E9.3080009@pobox.com>
References: <4AB20537.4080903@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50784 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbZIQUtr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:49:47 -0400
In-Reply-To: <4AB20537.4080903@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, stable@kernel.org

On 09/17/2009 05:45 AM, Tejun Heo wrote:
> Commit 54c38444fad6a99b4b19512f8f0055d69115e69e makes libata abort qcs
> after the port is frozen.  This is necessary to guarantee that TF
> registers are accessed after the DMA engine is shutdown after an
> error.  However, this triggers WARN_ON_ONCE() check in
> ata_qc_complete() spuriously.  Move WARN_ON_ONCE() downwards such that
> failing commands while frozen doesn't trigger it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: stable<stable@kernel.org>
> ---
>   drivers/ata/libata-core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied


