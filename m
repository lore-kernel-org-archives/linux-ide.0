From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Thu, 21 May 2009 09:44:05 -0400
Message-ID: <4A155AA5.3080704@rtr.ca>
References: <20090520065942.GD11363@kernel.dk>	 <20090520070038.GE11363@kernel.dk>	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>	 <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>	 <1242845440.2881.74.camel@localhost.localdomain>	 <4A1452E9.7000204@garzik.org> <4A145458.5080302@garzik.org> <e7510f760905201242s3cb84154m6e9a5795fd2357c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33366 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbZEUNoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 May 2009 09:44:06 -0400
In-Reply-To: <e7510f760905201242s3cb84154m6e9a5795fd2357c5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Jeff Garzik <jeff@garzik.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Gwendal Grignou wrote:
> Jeff, you're right, I made some mistakes:
> - Reading SiI3132 doc again, it only supports 32 command per port, so
> the tags must be share among all the drives behind the same port.
> But other chipset does support up to 128 commands per port.
> - Jens' patch is working when all disks support NCQ. Only when we have
> a mix of drives with or without NCQ we have a problem.
..

Along those lines, the newer Marvell chipsets support up to 128 commands
per host port.

I seem to recall that the Pacific Digital Qstor chip
can manage an insane number of commands -- something like
32 per device per PM port [eg. (15 * 32) in total per host port].

Seems to be a widespread kind of thing for non-legacy chipsets.
Someday we really ought to beef up libata to allow host-chipset queuing
of non-NCQ commands, too.

Cheers 
