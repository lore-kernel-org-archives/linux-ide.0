From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Wed, 13 Feb 2008 11:24:34 -0500
Message-ID: <47B319C2.5030002@rtr.ca>
References: <47A3375F.80101@gmail.com> <47B2368D.9080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2679 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbYBMQYg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 11:24:36 -0500
In-Reply-To: <47B2368D.9080408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> This patch implements libata.force module parameter which can
> selectively override ATA port, link and device configurations
> including cable type, SATA PHY SPD limit, transfer mode and NCQ.
...
> +	libata.force=	[LIBATA] Force configurations.  The format is comma
> +			separated list of "[ID:]VAL" where ID is
> +			PORT[:DEVICE].  PORT and DEVICE are decimal numbers
> +			matching port, link or device.  Basically, it matches
..

Mmm.. not a NAK, but is there also a way to set/change these on the fly?

I ask because, on my 4-core test system here, libata enumerates
the ports differently depending upon whether I boot with a 32-bit
kernel or a 64-bit kernel.

Major PITA, that, and it's just the kind of thing that spoils
fixed "PORT:DEVICE" module parameters, too.

Now mind you, it's more likely the PCI layer that does the reverse
order thing, but the end result is that my drives/ports are numbered
differently depending upon which kernel I happen to boot with.

??
