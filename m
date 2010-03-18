From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/3] ahci: clean up board IDs
Date: Thu, 18 Mar 2010 09:02:15 +0900
Message-ID: <4BA16D87.8040601@kernel.org>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org> <4BA11518.30500@garzik.org> <4BA15EA8.8000707@kernel.org> <4BA15FE8.9010609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53812 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab0CRACZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Mar 2010 20:02:25 -0400
In-Reply-To: <4BA15FE8.9010609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

On 03/18/2010 08:04 AM, Jeff Garzik wrote:
> What does it fix, specifically?  AFAICS, the patch changes the AHCI
> state from
> 
>     no FPDMA AA for all NVIDIA
> 
> to
> 
>     some FPDMA AA for NVIDIA
> 
> thus the current state of the code is not broken and in need of fixing,
> but merely overly conservative.  Am I missing something?

No, you're not.  I was confusing #3 contained the fix for bko#15471
when it was actually in #1.  Will refresh the patches for #upstream.

Thanks.

-- 
tejun
