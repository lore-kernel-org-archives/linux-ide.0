From: Mark Lord <liml@rtr.ca>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 17:03:12 -0500
Message-ID: <49934B20.4060206@rtr.ca>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:54677 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289AbZBKWDP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 17:03:15 -0500
In-Reply-To: <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Chuck Ebbert wrote:
> On Tue, 10 Feb 2009 23:08:40 -0500
> Mark Lord <liml@rtr.ca> wrote:
> 
>> If I let hddtemp or smartctl run periodically during heavy writes,
>> one (or both?) of the drives would eventually have issues and require
>> a reset.  Problem was never resolved (I simply got rid of the periodic
>> hddtemp and smartctl invocations instead).
>>
> 
> smartd is disabled and I don't even have hddtemp installed, so I don't
> think they could be causing this.
..

I didn't figure they were the cause, just a possible trigger
for some other rare issue.

I wonder if it's just a case of too short a timeout on the cache flushes?
