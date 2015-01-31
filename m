From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 02/15] sata_svw: remove the dependency on PPC_OF
Date: Sat, 31 Jan 2015 10:43:57 -0500
Message-ID: <20150131154357.GA3088@htj.dyndns.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-3-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:46660 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbAaPoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2015 10:44:00 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so23930231qac.3
        for <linux-ide@vger.kernel.org>; Sat, 31 Jan 2015 07:43:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422712065-9403-3-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>

On Sat, Jan 31, 2015 at 09:47:32PM +0800, Kevin Hao wrote:
> The OF functionality has moved to a common place and be used by many
> archs. So we don't need to include the ppc arch specific header files
> and depend on PPC_OF option any more. This is a preparation for
> killing PPC_OF.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please route as you see fit.

Thanks.

-- 
tejun
