From: Tejun Heo <tj@kernel.org>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 16:45:27 +0900
Message-ID: <4B137817.2090106@kernel.org>
References: <1259547765.2076.48.camel@pasglop> <4B1373BE.3000709@kernel.org> <1259566343.14613.0.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42965 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbZK3HpZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 02:45:25 -0500
In-Reply-To: <1259566343.14613.0.camel@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11/30/2009 04:32 PM, Shaohua Li wrote:
> yes, looks reasonable though spec doesn't mention such case.

Freezing being a software thing, I think that's understandable.  Can
you please post a patch to change that?

Thanks.

-- 
tejun
