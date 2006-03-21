From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Some sata_mv error messages
Date: Tue, 21 Mar 2006 14:37:13 -0500
Message-ID: <442055E9.4010708@pobox.com>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca> <44205513.8030109@poolshark.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4013 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965059AbWCUThS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:37:18 -0500
In-Reply-To: <44205513.8030109@poolshark.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denis Leroy <denis@poolshark.org>
Cc: Mark Lord <liml@rtr.ca>, sander@humilis.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Denis Leroy wrote:
> This is great news. Is there any relationship between the development of
> this driver and the one maintained by Marvell that's available from
> their web site ? Their latest version (3.6.1) is released under the GPL,
> and is a very solid driver based our experience with it over the past
> few years, though it's targeted at older versions of the linux kernel
> and needs some porting to 2.6.16 (and contains redundant stuff like its
> own scsi-ata layer).

There is a we-use-that-driver-as-documentation-sometimes relationship.

It's quite un-Linux for a Linux driver, and others have reported that 
sata_mv in its current state is more stable for them than the Marvell 
behemoth GPL driver.

	Jeff


