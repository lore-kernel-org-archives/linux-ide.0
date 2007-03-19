From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 16:46:40 -0400
Message-ID: <45FEF6B0.6020502@garzik.org>
References: <20070319075321.444c241e@freebird> <45FEA5D1.20101@pobox.com> <20070319131608.6d93fbf4@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56389 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbXCSUqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 16:46:42 -0400
In-Reply-To: <20070319131608.6d93fbf4@freekitty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> On Mon, 19 Mar 2007 11:01:37 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Stephen Hemminger wrote:
>>> This is a new drive, so I suspect some driver incompatibility between the
>>> driver (AHCI) and the hard drive (WD Raptor 10K 74G).
>> Driver incompatibilities between the driver (LLDD or libata-core) and a 
>> hard drive are extremely rare.
>>
>> The most common problem on modern SATA drives is drive firmware bugs, at 
>> the moment.
>>
> 
> I moved the drive to another machine with ICH7 and it seems to work fine
> there. Strange?

Does dmesg reflect any difference in AHCI version or PHY speed, on 
either machine?  Did you use the same cables in both tests?

AHCI version ("0001.0100" == AHCI 1.1):
...
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
...

PHY configuration and speed:
...
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
...

SATA headers (ports) on the motherboard and SATA cables are known to be 
weak links in the chain, commonly.

Regards,

	Jeff


