From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Sat, 14 Mar 2009 01:51:55 +0100
Message-ID: <20090314005155.GJ7787@nuty.nwl.cc>
References: <49AD2ADA.5030109@gmail.com> <49AFC43A.3040206@garzik.org> <20090306164318.GF23767@nuty.nwl.cc> <200903131541.46648.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:56395 "EHLO orbit.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759606AbZCNAvb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Mar 2009 20:51:31 -0400
Content-Disposition: inline
In-Reply-To: <200903131541.46648.florian@openwrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, Roel Kluin <roel.kluin@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi,

On Fri, Mar 13, 2009 at 03:41:43PM +0100, Florian Fainelli wrote:
> I agree with this proposal, abusing the ret value is not that good. What about the patch below :

That's exactly what I meant. Thanks for preparing the patch!

Greetings, Phil
