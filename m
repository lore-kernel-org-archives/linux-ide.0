From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sun, 24 Feb 2008 23:46:09 -0500
Message-ID: <47C24811.4010502@pobox.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com> <47C1194D.7080601@pobox.com> <47C24560.4030608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47701 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbYBYEqR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 23:46:17 -0500
In-Reply-To: <47C24560.4030608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Yeah, exactly.  I think what needs to be done is to separate out SFF
>>> assumptions from core layer, factor out SFF-proper helpers and use them
>>> to implement LLDs for quasi-SFF controllers.
>>
>>
>> Thinking long term, I continue to hope that SFF support can eventually 
>> be separate into a sub-API, allowing people to disable (at compile 
>> time) SFF support completely if they don't need it.
> ..
> 
> I can think of a few more pressing things to disable before that.
> 
> Like ACPI and PMP.  Modularizing those (or more crudely de-selecting them
> at build time) would save a lot of memory on small embedded boxes.

Sure.  Make these options dependent on CONFIG_EMBEDDED, and go to town 
from there...

	Jeff



