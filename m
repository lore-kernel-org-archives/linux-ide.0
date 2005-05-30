From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Mon, 30 May 2005 14:51:59 -0400
Message-ID: <429B60CF.5060204@pobox.com>
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca> <429B5CD3.7080106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46315 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261255AbVE3SwL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2005 14:52:11 -0400
In-Reply-To: <429B5CD3.7080106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Michael Thonke wrote:
> The new ones are real SATA drives. But some PATA devices and controllers
> support TCQ.

TCQ is a poorly designed feature, and so, will only be supported on a 
very few, special host controllers.

For most people, even if they down a drive with legacy TCQ, queueing 
will -never- be supported.  For more details read 
http://linux.yyz.us/sata/software-status.html#tcq

	Jeff


