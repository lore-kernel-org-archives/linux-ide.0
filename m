From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/13] ahci: fix err_mask setting in ahci_host_intr
Date: Thu, 26 Jan 2006 22:36:38 -0500
Message-ID: <43D99546.4020805@pobox.com>
References: <11379893761644-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:61625 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932404AbWA0Dgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 22:36:41 -0500
In-Reply-To: <11379893761644-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> In ahci_host_intr err_mask is determined from IRQ status but never
> used.  This patch sets qc->err_mask to the determined err_mask.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 4-8


