From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/3] ahci: clean up board IDs
Date: Thu, 18 Mar 2010 07:58:48 +0900
Message-ID: <4BA15EA8.8000707@kernel.org>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org> <4BA11518.30500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51101 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab0CQW7A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Mar 2010 18:59:00 -0400
In-Reply-To: <4BA11518.30500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

Hello,

On 03/18/2010 02:44 AM, Jeff Garzik wrote:
> It actually makes merging a lot more difficult, considering that libahci
> -- which includes large amounts of ahci code movement -- was committed
> to #upstream a week before this patch was posted.
> 
> Because of libahci changes, I think patch #2 (this patch) and patch #3
> are more appropriate for #upstream.
> 
> The "(pdev->vendor != PCI_VENDOR_ID_NVIDIA)" may be overly broad, but
> it's not wrong for 2.6.34, IMO.

Hmmm... the actual fix is in #3.  I'll prep separate patches for
upstream and upstream-fixes.

Thanks.

-- 
tejun
