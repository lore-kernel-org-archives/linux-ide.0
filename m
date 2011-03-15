From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 2/2] dts: Update sata controller compatible for p1022ds board
Date: Tue, 15 Mar 2011 10:39:54 -0500
Message-ID: <D20B8B05-5AF1-4410-BA2D-A93B7C0ACD78@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com> <1295428050-21934-2-git-send-email-B33228@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:15003
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab1COPkC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 11:40:02 -0400
In-Reply-To: <1295428050-21934-2-git-send-email-B33228@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xulei <B33228@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, jgarzik@pobox.com


On Jan 19, 2011, at 3:07 AM, Xulei wrote:

> Update p1022 sata compatible to "fsl,p1022-sata", "fsl,pq-sata-v2".
> p1022ds sata controller is v2 version comparing previous FSL sata
> controller, for example, mpc8536.
> 
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k

