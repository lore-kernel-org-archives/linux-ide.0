From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 16:56:21 -0400
Message-ID: <4655FBF5.5080707@rtr.ca>
References: <20070515061239.611A2DDEE9@ozlabs.org>	 <1179209697.32247.153.camel@localhost.localdomain>	 <20070523144217.5abd9fdf@the-village.bc.nu>	 <1179960518.32247.948.camel@localhost.localdomain>	 <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com>	 <20070524093316.GB10777@devserv.devel.redhat.com>	 <4655611E.6050805@garzik.org> <1180001330.32247.1058.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1768 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbXEXU4X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 16:56:23 -0400
In-Reply-To: <1180001330.32247.1058.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
>
> The only thing that I'm wondering about a bit is that ata_pause so far
> uses read of altstatus which _is_ a taskfile register. It's my
> understanding that we should avoid doing so in that case.

Technically, altstatus is in the control block rather than the command block,
so it doesn't really always behave the same as the regular "taskfile" regs.

Cheers
