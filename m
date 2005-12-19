From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/14] ahci: separate out ahci_cmd_prep()
Date: Mon, 19 Dec 2005 00:34:52 -0500
Message-ID: <43A6467C.9030604@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218135020.GM31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17029 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030280AbVLSFez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:34:55 -0500
In-Reply-To: <20051218135020.GM31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out achi_cmd_prep() from ahci_qc_prep().  This is preparation
> for adding softreset method.

ditto, this should be one of the first few patches in the patch order, 
since it is "easy to apply."  Applying this sort of patch is fine for 
me, since it doesn't harm the upstream driver, and it reduces the diff 
between upstream and whatever out-of-tree stuff you are working on.

	Jeff



