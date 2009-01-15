From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v1] pata_via.c:  Patch the behavior of via chipsets.
Date: Thu, 15 Jan 2009 23:56:27 +0900
Message-ID: <496F4E9B.6040909@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56D@exchtp03.taipei.via.com.tw>	<496F402A.2090704@kernel.org> <20090115141457.334e36dc@lxorguk.ukuu.org.uk> <496F4E40.1020402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51354 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192AbZAOO4o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 09:56:44 -0500
In-Reply-To: <496F4E40.1020402@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: JosephChan@via.com.tw, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

Tejun Heo wrote:
> Alan Cox wrote:
>>> Can you please add comments to explain it?  Also, it would be nice if
>>> you do ap->ctl = ap->last_ctl and turn off ATA_TFLAG_DEVICE to avoid
>>> loading them yet again.
>> I don't think you can turn off ATA_TFLAG_DEVICE, you have no guarantee it
>> won't be referred to again anywhere else in the stack - tf->flags isn't
>> owned by the driver so its asking for trouble to do that.
> 
> The original code copied tf to tmp_tf and turned it off there.  New code
> can do about the same thing.

But then again, maybe it's just better to open code it at this point.

-- 
tejun
