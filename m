From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
Date: Fri, 03 Mar 2006 09:26:35 -0500
Message-ID: <4408521B.9000905@rtr.ca>
References: <4407AB1D.2080506@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:18412 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751180AbWCCO0m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 09:26:42 -0500
In-Reply-To: <4407AB1D.2080506@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
> 
> Changes:
> Recognize ATA_CMD_WRITE_MULTI_FUA_EXT as r/w multiple commands.

This one will require exhaustive testing on various controllers.
There are quite a few PIO boards with FIFOs that "recognize"
opcodes for READs and WRITEs.  And practically all of them predate
any concept of FUA commands.

Very VERY risky.
