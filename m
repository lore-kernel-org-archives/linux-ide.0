From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 13:59:27 +0900
Message-ID: <47BE56AF.1080808@gmail.com>
References: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:25984 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYBVE7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 23:59:34 -0500
Received: by py-out-1112.google.com with SMTP id u52so525100pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 20:59:34 -0800 (PST)
In-Reply-To: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Su, Henry" <Henry.Su@amd.com>

Huang, Shane wrote:
> Jeff:
> 
> SB700 SATA controller can support 64 bit DMA, the previous commit
> badc2341579511a247f5993865aa68379e283c5c was added with
> careless reference to SB600, which should be modified by this patch.
> 
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

Shane, it still wraps.  Just give up outlook and use thunderbird +
toggle wordwrap + external editor or mutt/pine.

-- 
tejun
