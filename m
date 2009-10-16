From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: make sure link is brough up
 online when skipping hardreset
Date: Fri, 16 Oct 2009 06:26:46 -0400
Message-ID: <4AD84A66.9010106@garzik.org>
References: <4AD534F4.7000306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44569 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbZJPK1Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2009 06:27:24 -0400
In-Reply-To: <4AD534F4.7000306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, frodone@gmail.com

On 10/13/2009 10:18 PM, Tejun Heo wrote:
> prereset doesn't bring link online if hardreset is about to happen and
> nv_hardreset() may skip if conditions are not right so softreset may
> be entered with non-working link status if the system firmware didn't
> bring it up before entering OS code which can happen during resume.
> This patch makes nv_hardreset() to bring up the link if it's skipping
> reset.
>
> This bug was reported by frodone@gmail.com in the following bug entry.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=14329
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: frodone@gmail.com
> Cc: stable@kernel.org
> ---
>   drivers/ata/sata_nv.c |   18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)

applied -- man, what a pain this chip is


