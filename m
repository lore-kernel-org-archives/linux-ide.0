From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 08 Sep 2008 14:44:57 -0400
Message-ID: <48C572A9.2070009@rtr.ca>
References: <12207863853449-git-send-email-saeed@marvell.com> <48C52B53.3030302@rtr.ca> <200809081616.03266.elendil@planet.nl> <200809081625.31131.elendil@planet.nl> <48C54238.9050106@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55051 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbYIHSo7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 14:44:59 -0400
In-Reply-To: <48C54238.9050106@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: Frans Pop <elendil@planet.nl>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

Simon Farnsworth wrote:
>..
> Setting queue_depth to 1 is not disabling NCQ; it's NCQ enabled, no more
> than one command outstanding at a time. A queue depth of 0 disables NCQ
> completely.
..

Unfortunately, in the libata implementation, a queue depth of 1
actually *does* disable NCQ.  I wish it didn't (for easier testing
of features), but it does. 

Cheers
