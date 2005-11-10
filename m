From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: AHCI and VT8251
Date: Thu, 10 Nov 2005 18:47:08 -0500
Message-ID: <4373DBFC.5050208@pobox.com>
References: <1131592459.30236.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15236 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751198AbVKJXrN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2005 18:47:13 -0500
In-Reply-To: <1131592459.30236.30.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Joyce <joyce@webcreations.ca>
Cc: linux-ide@vger.kernel.org

Andrew Joyce wrote:
> I am trying to get a system using a VIA VT8251 chipset up and running.
> The chip claims to comply to the AHCI standard so, much like a previous
> poster, I added the PCI ID of the controller into the AHCI driver,
> compiled the 2.6.14 kernel and crossed my fingers.  I met with the same
> problems as were found earlier.  I am fairly certain this is an issue
> with the kernel driver and the new VT8251 chipset.  As far as I can tell
> this is the first board the chip is shipping in and the board has only
> been on the market for about a month at this stage.
> 
> I am presently unsure how to proceed in order to diagnose or address
> this problem.  My experience with kernel hacking is pretty limited but I
> would be willing to help out by testing whatever I can and I am happy to
> do some legwork and research to get this going.  Would anyone be
> interested in helping me address this problem?
> 
> I have attached the relevant portions of kernel messages below.

Does disabling PCI MSI fix things?

	Jeff



