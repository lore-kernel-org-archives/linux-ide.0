From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 11:23:29 -0500
Message-ID: <475D6801.5060905@rtr.ca>
References: <4750A523.7010501@clear.net.nz> <20071201001740.7ffce6f6@the-village.bc.nu> <4750CFB7.7040400@rtr.ca> <475CE7A5.3060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3180 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbXLJQXa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 11:23:30 -0500
In-Reply-To: <475CE7A5.3060608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>..
> Mark, how is marvell PMP support going?
..

It will be good once it happens -- the newer 6042/7042 chips support
full FIS-based switching, as well as command-based switching,
with large queues and all of the trimmings.

Currently stuck in legalese, though.

Cheers


