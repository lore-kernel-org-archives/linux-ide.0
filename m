From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Fri, 25 May 2007 07:32:27 -0400
Message-ID: <4656C94B.1090606@rtr.ca>
References: <20070515061239.611A2DDEE9@ozlabs.org>	 <1179209697.32247.153.camel@localhost.localdomain>	 <20070523144217.5abd9fdf@the-village.bc.nu>	 <1179960518.32247.948.camel@localhost.localdomain>	 <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com>	 <20070524093316.GB10777@devserv.devel.redhat.com>	 <4655611E.6050805@garzik.org>	 <1180001330.32247.1058.camel@localhost.localdomain>	 <4655FBF5.5080707@rtr.ca> <1180047136.32247.1073.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3326 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXEYLca (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 07:32:30 -0400
In-Reply-To: <1180047136.32247.1073.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-05-24 at 16:56 -0400, Mark Lord wrote:
>> Benjamin Herrenschmidt wrote:
>>> The only thing that I'm wondering about a bit is that ata_pause so far
>>> uses read of altstatus which _is_ a taskfile register. It's my
>>> understanding that we should avoid doing so in that case.
>> Technically, altstatus is in the control block rather than the command block,
>> so it doesn't really always behave the same as the regular "taskfile" regs.
> 
> So would altstatus be good enough to flush SRST toggles as well or do
> you expect problems ?

Dunno, really.  If one didn't have a known better idea, then it's worth trying.
