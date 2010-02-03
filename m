From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 03 Feb 2010 12:54:32 -0500
Message-ID: <4B69B858.3070907@pobox.com>
References: <1265151518.2800.715.camel@mulgrave.site>	 <20100202150537.0f6a01c0.akpm@linux-foundation.org>	 <4B68B1E0.4090004@pobox.com>	 <20100202.152140.216335166.davem@davemloft.net>	 <1265153568.2800.815.camel@mulgrave.site>	 <1265192325.1970.28.camel@pc1117.cambridge.arm.com>	 <1265215254.2873.201.camel@mulgrave.site>	<4B69ABCA.1030507@pobox.com>	 <20100203090631.44753f3b.akpm@linux-foundation.org>	 <4B69AF42.5050508@pobox.com> <1265219390.1970.84.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:51132 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768Ab0BCRye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:54:34 -0500
Received: by gxk24 with SMTP id 24so2064094gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Feb 2010 09:54:33 -0800 (PST)
In-Reply-To: <1265219390.1970.84.camel@pc1117.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, James Bottomley <James.Bottomley@suse.de>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

On 02/03/2010 12:49 PM, Catalin Marinas wrote:
> No, it doesn't. If the page isn't a highmem one, the kunmap doesn't do
> anything to the caches (and I also have highmem disabled). My logic was
> based on a statement in cachetlb.txt that flush_dcache_page() should be
> called if the kernel writes to a page cache page, hence the patch (as it
> was pointed out, the first call to flush_dcache_page() isn't needed).

Well, if those are the API rules, libata certainly must follow them...

	Jeff


