From: Mark Lord <liml@rtr.ca>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Thu, 12 Feb 2009 11:10:59 -0500
Message-ID: <49944A13.3050105@rtr.ca>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca>	<20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>	<49934B20.4060206@rtr.ca>	<49934D24.1050204@garzik.org>	<49935157.6020002@rtr.ca> <20090211175409.4fb27541@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46780 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690AbZBLQLB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Feb 2009 11:11:01 -0500
In-Reply-To: <20090211175409.4fb27541@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Chuck Ebbert wrote:
> On Wed, 11 Feb 2009 17:29:43 -0500
> Mark Lord <liml@rtr.ca> wrote:
> 
>>> Unless this has changed in the past year, the worst case for SATA cache 
>>> flush can definitely exceed 30 seconds...  it is unbounded as defined in 
>>> the spec, and unbounded in practice as well.
>> ..
>>
>> But I don't think we've yet seen a proven case of it taking too long
>> for the current libata timeouts.  Unless it's happening now.
>> T'would be good to find out..  Chuck?
> 
> How do I change the timeout?
..

Heh.. actually, I'm not entirely sure myself.
This stuff bounces between the block, scsi, and ata layers,
and I think it's set before it gets to libata.

Tejun?
