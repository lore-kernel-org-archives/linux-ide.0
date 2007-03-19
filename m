From: Mark Lord <liml@rtr.ca>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Mon, 19 Mar 2007 11:25:23 -0400
Message-ID: <45FEAB63.70307@rtr.ca>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com> <45FAB418.2070402@rtr.ca> <45FAD204.2060700@tw.ibm.com> <45FB095F.1020009@rtr.ca> <45FB5E50.4030006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1914 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030186AbXCSPZZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 11:25:25 -0400
In-Reply-To: <45FB5E50.4030006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Albert Lee wrote:
> Mark Lord wrote:
>..
>> I patched the above in, and it was NEVER hit.
> 
> Do you mean no "wait for DRQ" messages at all?
> Is the HSM violation still seen?

The code you sent me to patch in was never hit.
The "wait for DRQ" message therefore never gets output.
The exact same set of HSM violation messages still appear.

Of course this makes perfect sense -- the HSM messages
are not being generated in response to any command,
but rather in response to ejecting a disk -- which I think
causes the drive to generate an unsolicited event.

Cheers
