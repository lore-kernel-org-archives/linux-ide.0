From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 13 Oct 2008 15:56:56 +0900
Message-ID: <48F2F138.6020103@kernel.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45734 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbYJMG67 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 02:58:59 -0400
In-Reply-To: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>, "Steven A. Falco" <sfalco@harris.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Anton Vorontsov wrote:
> When no irq specified the pata_of_platform fills the irq_res with -1,
> which is wrong to do for two reasons:
> 
> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>    is unsigned type, the check will be true for `-1'.
> 
> Reported-by: Steven A. Falco <sfalco@harris.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

applied to #tj-upstream (will soon be sent upstream)

-- 
tejun
