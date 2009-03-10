From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to
	enable quirk for SOC
Date: Tue, 10 Mar 2009 17:28:03 +0100
Message-ID: <20090310162803.GA9120@deprecation.cyrius.com>
References: <200808261124.39282.elendil@planet.nl> <497B2C60.60608@rtr.ca> <200902240933.45874.elendil@planet.nl> <200903101236.30216.elendil@planet.nl> <49B6820C.1010206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:52218 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZCJQ2R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 12:28:17 -0400
Content-Disposition: inline
In-Reply-To: <49B6820C.1010206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Frans Pop <elendil@planet.nl>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

* Mark Lord <liml@rtr.ca> [2009-03-10 11:06]:
> Saeed said the original patch should apply "for all devices besides
> to the SOC", which I think means all GenIIe chip variants.

Unfortunately, we're seeing the problem with the SoC...
-- 
Martin Michlmayr
http://www.cyrius.com/
