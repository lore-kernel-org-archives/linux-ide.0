From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/14] ahci: convert to new reset mechanism
Date: Mon, 19 Dec 2005 00:33:54 -0500
Message-ID: <43A64642.7010502@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218134924.GL31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15237 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030273AbVLSFd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:33:57 -0500
In-Reply-To: <20051218134924.GL31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert ahci ->phy_reset to ->hard_reset.  The original ->phy_reset
> simply called __sata_phy_reset() to perform reset; however, AHCI spec
> mandates to turn off START bit during reset.  New ->hard_reset method
> properly follows AHCI reset procedure.

If you feel AHCI deviates from spec, it sounds like this fix should be 
separated out into a new patch?

	Jeff



