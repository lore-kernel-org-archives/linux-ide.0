From: Tejun Heo <htejun@gmail.com>
Subject: Re: Spurious completions during NCQ
Date: Thu, 06 Mar 2008 14:56:27 +0900
Message-ID: <47CF878B.8090101@gmail.com>
References: <20080215134658.GB27745@vlad.carfax.org.uk> <47B6EE53.1070101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:8260 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYCFF4j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 00:56:39 -0500
Received: by rn-out-0910.google.com with SMTP id v46so751702rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 21:56:39 -0800 (PST)
In-Reply-To: <47B6EE53.1070101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun, have the spurious completion fixes been backported
> to 2.6.23 / 2.6.22 yet ?  Those kernels will be in common use
> for some time to come, and this fix is more or less essential.

Not that I know of.  I'm prepping patches now.

Thanks.

-- 
tejun
