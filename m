From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 0/2] libata: switch to block layer tagging
Date: Wed, 20 May 2009 09:57:53 +0200
Message-ID: <20090520075753.GK11363@kernel.dk>
References: <20090520065942.GD11363@kernel.dk> <4A13B6F3.2000001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:44665 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbZETH5w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:57:52 -0400
Content-Disposition: inline
In-Reply-To: <4A13B6F3.2000001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

On Wed, May 20 2009, Jeff Garzik wrote:
> Jens Axboe wrote:
>> Hi,
>>
>> This patchset switches libata to block layer tagging. It gets rid of yet
>> another O(N) command loop.
>>
>>  block/blk-tag.c           |   99 +++++++++++++++++++++++++++-----------
>>  drivers/ata/libata-core.c |   94 ++++++++++--------------------------
>>  drivers/ata/libata-scsi.c |   23 ++++++++
>>  drivers/ata/libata.h      |   19 ++++++-
>>  include/linux/blkdev.h    |    3 +
>>  include/linux/libata.h    |    1  6 files changed, 139 insertions(+), 
>> 100 deletions(-)
>
> Will take a look post-sleep...  mainly it's a question of possibly  

:-)

> interfering with SCSI's use of block layer tagging.  Though for the  
> moment I will simply assume you verified that ;)

Certainly, the patch has been used and sitting in my ssd branch for
months now. It essentially just tells SCSI to enable the block layer
tagging for libata devices with ncq. Then libata gets block layer tagged
requests automatically, and it can simply reuse the assigned tag
internally as well.

That part is trivial. The nasty bit is when libata makes up its own tag
for internal issue, that is what patch #2 covers.

-- 
Jens Axboe

