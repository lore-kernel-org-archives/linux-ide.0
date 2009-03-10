From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to	enable
 quirk for SOC
Date: Tue, 10 Mar 2009 12:40:47 -0400
Message-ID: <49B6980F.8050408@rtr.ca>
References: <200808261124.39282.elendil@planet.nl> <497B2C60.60608@rtr.ca> <200902240933.45874.elendil@planet.nl> <200903101236.30216.elendil@planet.nl> <49B6820C.1010206@rtr.ca> <20090310162803.GA9120@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46530 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410AbZCJQkv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 12:40:51 -0400
In-Reply-To: <20090310162803.GA9120@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Frans Pop <elendil@planet.nl>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Martin Michlmayr wrote:
> * Mark Lord <liml@rtr.ca> [2009-03-10 11:06]:
>> Saeed said the original patch should apply "for all devices besides
>> to the SOC", which I think means all GenIIe chip variants.
> 
> Unfortunately, we're seeing the problem with the SoC...
..

That's fine, it will still fix that, as well as the other chips.

