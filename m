From: Brad Campbell <brad@wasp.net.au>
Subject: Re: problem with pata_hpt37x ...
Date: Thu, 04 Jan 2007 20:09:56 +0400
Message-ID: <459D26D4.3010601@wasp.net.au>
References: <20070102070144.GA11270@MAIL.13thfloor.at> <20070102145855.170c03e2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:34424 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965005AbXADQPp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Jan 2007 11:15:45 -0500
In-Reply-To: <20070102145855.170c03e2@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>

Alan wrote:
> On Tue, 2 Jan 2007 08:01:45 +0100
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> 
>> if you are interested in investigating this, please
>> let me know what kind of data you would like to see
>> and/or what kind of tests would be appreciated.
> 
> I reviewed the 374 code a bit further to see what might be causing this
> and found the slave channel end of DMA handling was using the wrong port
> I think.

This now passes all my stress tests Alan. No more "Interrupt disabled" or dmesg storms.
I put the HPT Rocketraid 1540 (HPT374) back in a box and connected 4 200GB ata drives to it using 
SATA-PATA bridgeboards as before. It looks to be rock solid now.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
