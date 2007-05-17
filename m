From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Wed, 16 May 2007 21:16:05 -0400
Message-ID: <464BACD5.3030003@gentoo.org>
References: <46492931.4080700@gentoo.org> <46496D47.9010504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp141.iad.emailsrvr.com ([207.97.245.141]:51854 "EHLO
	smtp141.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbXEQBRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 21:17:10 -0400
In-Reply-To: <46496D47.9010504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

Thanks for the fast response and action.

Tejun Heo wrote:
> it.  I'll come up with a patch, please wait a bit before releasing the
> update.

The patch has been merged into libata-dev.git so I'd like to revisit 
this topic now.

Am I right in saying, to fix 2.6.21, the following patches are needed, 
and no others, in this order:

sd: fix return value of sd_sync_cache()
3721050afc6cb6ddf6de0f782e2054ebcc225e9b
(not sure if this one is required?)

[SCSI] sd: implement START/STOP management
3c94c5a2fb43a654e777f509d5032b0db8ed09f

libata: reimplement suspend/resume support using sdev->manage_start_stop
9666f4009c22f6520ac3fb8a19c9e32ab973e828

libata: implement libata.spindown_compat
920a4b1038e442700a1cfac77ea7e20bd615a2c3

libata: fix shutdown warning message printing
da071b42f73dabbd0daf7ea4c3ff157d53b00648

libata: track spindown status and skip spindown_compat if possible
13b8d09f5de0aaa3153bbccc98baf247387823dc


Additionally, no userspace modifications are needed, at least while 
Gentoo's shutdown/halt programs are not attempting to spin down libata 
disks?

I note that the patch titled "SCSI: kill sht->suspend/resume" (not 
included in the above tree) is not yet merged into Linus' tree. Am I 
right in saying it's not required for the disk spindown stuff to work 
properly?

Thanks!
Daniel
