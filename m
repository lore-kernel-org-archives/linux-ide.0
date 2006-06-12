From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: update device hotplug handling
Date: Mon, 12 Jun 2006 02:08:05 -0400
Message-ID: <448D04C5.9030603@pobox.com>
References: <20060612051822.GE9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10630 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750854AbWFLGII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 02:08:08 -0400
In-Reply-To: <20060612051822.GE9166@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some flavors of 3112 cannot mask SATA_IRQ reliably and ends up
> scheduling hotplug event during hardreset.

Can you give more detail?  This sounds like a software bug?  I don't see 
SError clearing the pre-patched code path, the lack of which may create 
the conditions you describe.

	Jeff


