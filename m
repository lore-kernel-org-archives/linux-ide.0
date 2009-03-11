From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Wed, 11 Mar 2009 14:08:34 +0100
Message-ID: <200903111408.37298.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <200903110815.52650.elendil@planet.nl> <49B7B2C9.10203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:59765 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753201AbZCKNIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 09:08:40 -0400
In-Reply-To: <49B7B2C9.10203@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Wednesday 11 March 2009, Mark Lord wrote:
> > +static const struct mv_hw_ops mv6xxx_iie_ops = {
> > +	.inherits		= &mv6xxx_ops,
> > +	.enable_led_blink	= mv_iie_enable_led_blink,
> > +};
> > +
>
> I'm afraid I just don't understand the purpose of "inherits" above.
> This field appears to never be referenced anywhere.

Fun, as it's also used in mv6_ops and mv_iie_ops. That's where I copied it 
from. I really don't have anywhere near the C fu to think up such 
constructs all by myself :-D

What it does (I've been assuming) is include any ops defined in the struct 
that is being referred to. So mv6xxx_iie_ops gets all the ops defined for 
mv6xxx_ops plus mv_iie_enable_led_blink.

> (or did I miss an update to the C programming language at some point? 
> :)
>

You're still way ahead of me.
