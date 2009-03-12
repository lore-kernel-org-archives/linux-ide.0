From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Thu, 12 Mar 2009 12:40:51 +0100
Message-ID: <200903121240.55194.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <200903111408.37298.elendil@planet.nl> <49B7C782.9070004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:62462 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755919AbZCLLk7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 07:40:59 -0400
In-Reply-To: <49B7C782.9070004@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Wednesday 11 March 2009, Mark Lord wrote:
> Frans Pop wrote:
> > On Wednesday 11 March 2009, Mark Lord wrote:
> >> I'm afraid I just don't understand the purpose of "inherits" above.
> >> This field appears to never be referenced anywhere.
> >
> > What it does (I've been assuming) is include any ops defined in the
> > struct that is being referred to. So mv6xxx_iie_ops gets all the ops
> > defined for mv6xxx_ops plus mv_iie_enable_led_blink.
>
> Except it is not a C-language feature, but rather a simple/clever
> implementation for those specific data structures, as can be seen
> in libata-core.c :: ata_finalize_port_ops().
>
> So, skip that.

Oops. So I implemented part of what's needed, but not all. Well, that just 
proves my level of C knowledge. Should have just copied the set of ops 
instead of trying to do it clean :-/

> So enough: we'll just do this the original way, for SOC only.
> All of the SOC chips that I know about appear to have the correct bits
> in the same places, so perhaps that's what Saeed's cryptic commment was
> about.

OK. Fine by me. It can always be extended if the need for that is proven.

> Can you test this there and confirm that it still works for you?
> Please try switching NCQ on/off etc.. just to make sure.

The LED behavior is correct with NCQ enabled: slow blink.
But if I disable NCQ blink mode is not turned off, the led continues the 
slow blinking. So it looks as if just calling mv_soc_led_blink_disable in 
mv_edma_cfg is not sufficient.

> After I hear back, I'll submit this for #upstream.

Thanks Mark.
