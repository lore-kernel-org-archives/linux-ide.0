From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] [libata/BF54x]: Fix bug - Implement bfin ata interrupt
 handler to avoid "irq 68 nobody cared" (v2)
Date: Tue, 29 Apr 2008 02:18:44 -0400
Message-ID: <4816BDC4.7050805@pobox.com>
References: <1209115165-24995-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51629 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbYD2GSw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:52 -0400
In-Reply-To: <1209115165-24995-1-git-send-email-cooloney@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

Bryan Wu wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Return IRQ_HANDLED when bfin ata device is busy.
> http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3513
> 
> v1-v2:
>  - fold api breakage fixing patch together.
>  - mark 'static', not 'inline'.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  drivers/ata/pata_bf54x.c |  124 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 120 insertions(+), 4 deletions(-)

applied


