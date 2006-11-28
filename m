From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: don't schedule EH on wcache on/off if old EH
Date: Tue, 28 Nov 2006 03:45:44 -0500
Message-ID: <456BF738.5060606@pobox.com>
References: <20061122033943.GV2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19842 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935696AbWK1Ipq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 03:45:46 -0500
In-Reply-To: <20061122033943.GV2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Do not schedule EH for revalidation on wcache on/off if old EH.  Old
> EH cannot handle it and will result in WARN_ON()'s and oops.
> 
> This closes bug #7412.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this one should go into #upstream-fixes too.

applied to #upstream-fixes


