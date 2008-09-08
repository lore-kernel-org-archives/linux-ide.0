From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 08 Sep 2008 09:40:35 -0400
Message-ID: <48C52B53.3030302@rtr.ca>
References: <12207863853449-git-send-email-saeed@marvell.com> <200809080232.23834.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53582 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbYIHNkh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 09:40:37 -0400
In-Reply-To: <200809080232.23834.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

Frans Pop wrote:
..
> So, IMO it is an improvement, but it is definitely not a fix for the 
> regression.
..

With a new copy of hdparm, use "hdparm -Q1 /dev/sd?"

Does that fix your "regression" ?
