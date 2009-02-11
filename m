From: Mark Lord <liml@rtr.ca>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 17:29:43 -0500
Message-ID: <49935157.6020002@rtr.ca>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca> <49934D24.1050204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39577 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921AbZBKW3q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 17:29:46 -0500
In-Reply-To: <49934D24.1050204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> I wonder if it's just a case of too short a timeout on the cache flushes?
> 
> The answer in general to this question has always been "yes".....
> 
> Unless this has changed in the past year, the worst case for SATA cache 
> flush can definitely exceed 30 seconds...  it is unbounded as defined in 
> the spec, and unbounded in practice as well.
..

But I don't think we've yet seen a proven case of it taking too long
for the current libata timeouts.  Unless it's happening now.
T'would be good to find out..  Chuck?
