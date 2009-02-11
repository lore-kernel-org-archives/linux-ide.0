From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 17:11:48 -0500
Message-ID: <49934D24.1050204@garzik.org>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43894 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758643AbZBKWMB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 17:12:01 -0500
In-Reply-To: <49934B20.4060206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Chuck Ebbert <cebbert@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> I wonder if it's just a case of too short a timeout on the cache flushes?

The answer in general to this question has always been "yes".....

Unless this has changed in the past year, the worst case for SATA cache 
flush can definitely exceed 30 seconds...  it is unbounded as defined in 
the spec, and unbounded in practice as well.

Of course, users' patience is not unbounded :)

	Jeff



