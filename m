From: Mark Lord <liml@rtr.ca>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Tue, 10 Feb 2009 23:08:40 -0500
Message-ID: <49924F48.4000009@rtr.ca>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com> <49922A2D.508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56089 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbZBKEIn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 23:08:43 -0500
In-Reply-To: <49922A2D.508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Chuck Ebbert wrote:
>> If I use an ext3 filesystem with noatime I never see problems, but if I use XFS
>> with barriers and atime enabled, I keep getting this:
>>
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata1.00: status: { DRDY }
>> ata1: hard resetting link
>> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata1.00: configured for UDMA/133
>> end_request: I/O error, dev sda, sector 13851948
> 
> ext3 doesn't use barrier by default.  Timing out on FLUSH_CACHE is a
> pretty good sign that something is wrong with the disk.  Can you
> please post the output of "smartctl -a /dev/sda"?
..

I missed the start of this thread,
but want to point out that something similar was observed here
with a pair of Hitachi 750GB drives (RAID0) and XFS and FLUSH_CACHE.

If I let hddtemp or smartctl run periodically during heavy writes,
one (or both?) of the drives would eventually have issues and require
a reset.  Problem was never resolved (I simply got rid of the periodic
hddtemp and smartctl invocations instead).

-ml


