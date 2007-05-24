From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Fri, 25 May 2007 08:52:15 +1000
Message-ID: <1180047136.32247.1073.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
	 <1179960518.32247.948.camel@localhost.localdomain>
	 <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com>
	 <20070524093316.GB10777@devserv.devel.redhat.com>
	 <4655611E.6050805@garzik.org>
	 <1180001330.32247.1058.camel@localhost.localdomain>
	 <4655FBF5.5080707@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48934 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbXEXWw2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 18:52:28 -0400
In-Reply-To: <4655FBF5.5080707@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 2007-05-24 at 16:56 -0400, Mark Lord wrote:
> Benjamin Herrenschmidt wrote:
> >
> > The only thing that I'm wondering about a bit is that ata_pause so far
> > uses read of altstatus which _is_ a taskfile register. It's my
> > understanding that we should avoid doing so in that case.
> 
> Technically, altstatus is in the control block rather than the command block,
> so it doesn't really always behave the same as the regular "taskfile" regs.

So would altstatus be good enough to flush SRST toggles as well or do
you expect problems ?

Ben.


