From: Mark Lord <liml@rtr.ca>
Subject: Re: HighPoint RocketRAID 2320
Date: Wed, 05 Aug 2009 18:35:19 -0400
Message-ID: <4A7A0927.9090507@rtr.ca>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to> <4A7821AF.9010609@kernel.org> <20090804174852.GH13863@dsg.to> <4A78FE5A.1080203@rtr.ca> <4A790008.3020601@rtr.ca> <4A790352.6080804@kernel.org> <20090805210154.GJ13863@dsg.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:42506 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbZHEWfU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Aug 2009 18:35:20 -0400
In-Reply-To: <20090805210154.GJ13863@dsg.to>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

The sata_mv driver does not use interrupts for PIO,
which is why it's working (slowly) when you disable DMA.

The original problem remains.. interrupts are not getting
back to the CPU from the 6081 chip.  Dunno why.

I'm on holiday right now.  :)
