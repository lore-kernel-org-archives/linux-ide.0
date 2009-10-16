From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix internal command failure
 handling
Date: Fri, 16 Oct 2009 06:27:15 -0400
Message-ID: <4AD84A83.5010601@garzik.org>
References: <4AD7EFF3.1000902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44585 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbZJPK1z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2009 06:27:55 -0400
In-Reply-To: <4AD7EFF3.1000902@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ethan <ethanhsiao@jmicron.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10/16/2009 12:00 AM, Tejun Heo wrote:
> When an internal command fails, it should be failed directly without
> invoking EH.  In the original implemetation, this was accomplished by
> letting internal command bypass failure handling in ata_qc_complete().
> However, later changes added post-successful-completion handling to
> that code path and the success path is no longer adequate as internal
> command failure path.  One of the visible problems is that internal
> command failure due to timeout or other freeze conditions would
> spuriously trigger WARN_ON_ONCE() in the success path.
>
> This patch updates failure path such that internal command failure
> handling is contained there.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-core.c |   12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

applied -- thanks for fixing!!


