From: Tejun Heo <tj@kernel.org>
Subject: Re: failures due to "libata: disable forced PORTS_IMPL for >= AHCI
 1.3 patch"
Date: Thu, 24 Mar 2016 15:14:10 -0400
Message-ID: <20160324191410.GA7822@mtj.duckdns.org>
References: <56F2C60A.5070504@linaro.org>
 <CAKgsxVQ8HQKNWYNBr3FtKS=iyn838UW6TG5NDeacAg7ZKEx_gA@mail.gmail.com>
 <56F2E931.7010805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35821 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbcCXTON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2016 15:14:13 -0400
Received: by mail-yw0-f181.google.com with SMTP id g127so71285120ywf.2
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2016 12:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56F2E931.7010805@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Justin Maggard <jmaggard10@gmail.com>, linux-ide@vger.kernel.org, hdegoede@redhat.com, mikpelinux@gmail.com

Hello,

On Wed, Mar 23, 2016 at 07:06:25PM +0000, Srinivas Kandagatla wrote:
> >A generic dt binding is probably a better way forward.  The Annapurna
> >Alpine platform seems to have the same issue.
> 
> +1 for generic bindings.
> 
> I suspected that other platforms would also hit the same issue.

I can change the code so that PORTS_IMPL workaround is applied
automatically for all platform drivers as a stop-gap.  Do we need
that or can we push dt based solution quickly enough?

Thanks.

-- 
tejun
