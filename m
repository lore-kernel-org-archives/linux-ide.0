From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Mon, 30 May 2005 14:48:03 -0400
Message-ID: <429B5FE3.8070908@pobox.com>
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261691AbVE3SsO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2005 14:48:14 -0400
In-Reply-To: <429B5A94.6010301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Erik Slagter <erik@slagter.name>, Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Erik Slagter wrote:>
> 
>> Still I'd like to run in ACHI mode ;-)
> 
> 
> Me too!  But from reading the ICH6 Intel docs,
> it seems that AHCI mode is only for true SATA drives.

Correct.  AHCI mode absolutely requires SATA, because it only supports 
the native SATA "FIS" packets.

As much as I would like, one cannot use AHCI to talk to any PATA device[1].

	Jeff



[1] unless it's PATA bridged over SATA, the exception case that turns 
any PATA device into a SATA device.
