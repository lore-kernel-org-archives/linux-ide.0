From: Jeff Garzik <jeff@garzik.org>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Fri, 22 Feb 2008 21:59:26 -0500
Message-ID: <47BF8C0E.2080908@garzik.org>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BF8859.4000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33111 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792AbYBWC7a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 21:59:30 -0500
In-Reply-To: <47BF8859.4000505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Tejun Heo wrote:
> Yeah, this is an interesting problem.  There are basically multiple sets
> of TF registers and the SFF way of assuming single set doesn't really
> work well and I don't really think adding ->pmp_read/write is the
> correct long term solution to the problem.  We need to confine direct TF
> register accesses to SFF layer only as controllers which don't implement
> SFF interface may or may not emulate TF registers and even when they do,
> it sometimes can't really match the SFF behavior.

Strongly agreed.


> I wish things are a bit clearer now.  I think the problem here is that
> we're assuming SFF TF access on controllers which aren't really SFF.
> For sil24 and ahci, the driver emulates it and it isn't too difficult.
> The picture gets more interesting for sata_mv as its hardware interface
> much closer to SFF than sil24 or ahci and TF registers matter much more.
>  For ahci and sil24, LLD can just fool libata core layer which assumes
> ubiquitous TF access.  TF registers don't really matter to controller
> operation anyway and feeding bogus values work well.  For sata_mv, it's
> different.  Those registers are integral part of controller operation
> and sata_mv can't really tolerate core layer stepping in w/o notifying LLD.

I would definitely like to move away from the model where non-SFF 
drivers have to emulate SFF in any way.

Re-reviewing the code, I don't see a lot of TF accesses outside of 
SFF-specific code, so we are already in pretty good shape.

I think the picture gets more complicated with sata_mv and similar 
drivers (soon sata_svw, too), because they use the SFF code but only for 
certain TF protocols.  The emulation question is not as clear, with 
those drivers.

	Jeff


