From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Wed, 23 Nov 2005 16:40:12 -0500
Message-ID: <4384E1BC.4090708@pobox.com>
References: <437D2DED.5030602@pobox.com> <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de> <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de> <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59781 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932546AbVKWVkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 16:40:15 -0500
In-Reply-To: <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> 1. several badblocks tests finished fine; the speed is also fine (about 
> 50Mbytes/s both read and write as reported by both iostat during 
> badblocks and bonnie++ on an ext2 FS).

cool


> 2. I know that we are not yet talking about hotplugging, but this is 
> what happens if you do it (unplug) :-)

expected (unfortunately...)

	Jeff


