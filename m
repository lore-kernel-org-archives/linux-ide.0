From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 06 Feb 2007 09:42:20 -0500
Message-ID: <45C893CC.4030408@rtr.ca>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4768 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbXBFOmW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 09:42:22 -0500
In-Reply-To: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: linux-ide@vger.kernel.org

Bob Stewart wrote:
>
> Is there an easy way to tell whether the command was sent as 
> LBA48, say, in the driver's bmdma_start function or even in the 
> hardreset function after the fact?

The best thing would be to have libata log the ATA opcode,
if it doesn't already do that.
