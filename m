From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Wed, 3 Feb 2010 17:46:20 +0000
Message-ID: <20100203174620.0fba7837@lxorguk.ukuu.org.uk>
References: <1265151518.2800.715.camel@mulgrave.site>
	<20100202150537.0f6a01c0.akpm@linux-foundation.org>
	<4B68B1E0.4090004@pobox.com>
	<20100202.152140.216335166.davem@davemloft.net>
	<1265153568.2800.815.camel@mulgrave.site>
	<1265192325.1970.28.camel@pc1117.cambridge.arm.com>
	<1265215254.2873.201.camel@mulgrave.site>
	<4B69ABCA.1030507@pobox.com>
	<20100203090631.44753f3b.akpm@linux-foundation.org>
	<4B69AF42.5050508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50213 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932783Ab0BCRrl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:47:41 -0500
In-Reply-To: <4B69AF42.5050508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, James Bottomley <James.Bottomley@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, David Miller <davem@davemloft.net>, jeff@garzik.org, linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org

And indeed there was a patch I proposed in 2008 for this bounce
buffer latency: See the archive

Date: Fri, 29 Feb 2008 13:51:06 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, jeff@garzik.org
Subject: [RFC PATCH] libata: PIO via bounce buffer

although it doesn't deal with the dcache coherency issue and seems to
need a little tweaking to apply due to other changes

Alan
