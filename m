From: Mark Lord <liml@rtr.ca>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Thu, 12 Feb 2009 11:13:29 -0500
Message-ID: <49944AA9.8040308@rtr.ca>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca>	<20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>	<49934B20.4060206@rtr.ca>	<49934D24.1050204@garzik.org>	<49935157.6020002@rtr.ca> <20090211175409.4fb27541@dhcp-100-2-144.bos.redhat.com> <49944A13.3050105@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55589 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbZBLQNb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Feb 2009 11:13:31 -0500
In-Reply-To: <49944A13.3050105@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Chuck Ebbert wrote:
>
>> How do I change the timeout?
> ..
> 
> Heh.. actually, I'm not entirely sure myself.
> This stuff bounces between the block, scsi, and ata layers,
> and I think it's set before it gets to libata.
..

Mmm.. I think it is the SD_TIMEOUT value, defined in drivers/scsi/sd.h
which currently uses (30 * HZ) as the timeout for most things,
including for cache flushes.

Try changing it to (180 * HZ) just for fun.

Cheers
