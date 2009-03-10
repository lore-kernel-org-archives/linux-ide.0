From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to enable quirk for SOC
Date: Tue, 10 Mar 2009 17:47:07 +0100
Message-ID: <200903101747.09276.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl> <49B6820C.1010206@rtr.ca> <20090310162803.GA9120@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:50306 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756928AbZCJQrN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 12:47:13 -0400
In-Reply-To: <20090310162803.GA9120@deprecation.cyrius.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Mark Lord <liml@rtr.ca>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Tuesday 10 March 2009, Martin Michlmayr wrote:
> * Mark Lord <liml@rtr.ca> [2009-03-10 11:06]:
> > Saeed said the original patch should apply "for all devices besides
> > to the SOC", which I think means all GenIIe chip variants.
>
> Unfortunately, we're seeing the problem with the SoC...

AIUI the SoC _is_ a GenIIe chip variant. Mark is asking me to extend the 
code to the PCI-based GenIIe chips.
