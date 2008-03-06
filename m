From: Tejun Heo <htejun@gmail.com>
Subject: Re: Spurious completions during NCQ
Date: Thu, 06 Mar 2008 15:05:01 +0900
Message-ID: <47CF898D.8060902@gmail.com>
References: <20080215134658.GB27745@vlad.carfax.org.uk> <47B6EE53.1070101@rtr.ca> <47CF878B.8090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:24910 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYCFGFJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 01:05:09 -0500
Received: by rn-out-0910.google.com with SMTP id v46so755616rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 22:05:08 -0800 (PST)
In-Reply-To: <47CF878B.8090101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun, have the spurious completion fixes been backported
>> to 2.6.23 / 2.6.22 yet ?  Those kernels will be in common use
>> for some time to come, and this fix is more or less essential.
> 
> Not that I know of.  I'm prepping patches now.
> 

Oh... it already happened in 2.6.22.15 and 2.6.23.10.  Nice.

-- 
tejun
