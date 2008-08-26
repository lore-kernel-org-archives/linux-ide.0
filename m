From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv (NOT!)
Date: Tue, 26 Aug 2008 09:46:22 -0400
Message-ID: <48B4092E.3050907@rtr.ca>
References: <48A0C170.2000803@verizon.net> <48A307D3.2000905@rtr.ca> <48ABA997.1050109@verizon.net> <48ADE68D.20705@rtr.ca> <48AE4BCE.8090401@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46377 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757544AbYHZNqY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 09:46:24 -0400
In-Reply-To: <48AE4BCE.8090401@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Steven Gill <smgill75@verizon.net>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>>
>> Yeah, it looks to me as if libata still has DVD burner issues.
>> I used my SATA DVDRW drive to burn a Suse DVD the other day,
>> and the same drive refused to read the burnt disc without first 
>> rebooting.
>>
>> linux-2.6.25.6
>>
>> Disc was fine, though.  Single-layer.
> 
> Do you get error messages as well?  Of what kind?
..

There have been so many broken things in so many parts of the kernel of late,
that I'm just way too far behind in diagnosing/fixing them.   Or reporting them,
since many developers have stated they would rather not see a bug report
without a bisect.

But here's all that was in the logs for this particular bug.
These messages appeared when trying to read the freshly burned DVD,
both before and after eject/reinsert.  A reboot cured it:

[ 8209.473181] attempt to access beyond end of device
[ 8209.473189] sr0: rw=0, want=68, limit=4
[ 8209.487646] attempt to access beyond end of device
[ 8209.487655] sr0: rw=0, want=5480256, limit=4
[ 8209.487664] attempt to access beyond end of device
[ 8209.487668] sr0: rw=0, want=5479232, limit=4
[ 8209.487681] attempt to access beyond end of device
[ 8209.487685] sr0: rw=0, want=5479008, limit=4
[ 8209.487694] attempt to access beyond end of device
[ 8209.487700] sr0: rw=0, want=5480248, limit=4
[ 8209.487714] attempt to access beyond end of device
[ 8209.487719] sr0: rw=0, want=5479224, limit=4
[ 8209.487728] attempt to access beyond end of device
[ 8209.487733] sr0: rw=0, want=5479000, limit=4
[ 8209.487742] attempt to access beyond end of device
[ 8209.487747] sr0: rw=0, want=5479656, limit=4
[ 8209.487757] attempt to access beyond end of device
[ 8209.487762] sr0: rw=0, want=5478632, limit=4
[ 8209.487771] attempt to access beyond end of device
[ 8209.487776] sr0: rw=0, want=5478408, limit=4
[ 8209.487784] attempt to access beyond end of device
[ 8209.487789] sr0: rw=0, want=5479648, limit=4
[ 8209.487797] attempt to access beyond end of device
[ 8209.487802] sr0: rw=0, want=5478624, limit=4
[ 8209.487811] attempt to access beyond end of device
[ 8209.487816] sr0: rw=0, want=5478400, limit=4
[ 8209.487829] attempt to access beyond end of device
[ 8209.487833] sr0: rw=0, want=4496644, limit=4
[ 8209.487843] attempt to access beyond end of device
[ 8209.487848] sr0: rw=0, want=4495620, limit=4
[ 8209.487857] attempt to access beyond end of device
[ 8209.487862] sr0: rw=0, want=4495396, limit=4
[ 8209.487870] attempt to access beyond end of device
[ 8209.487875] sr0: rw=0, want=4496636, limit=4
[ 8209.487883] attempt to access beyond end of device
[ 8209.487888] sr0: rw=0, want=4495612, limit=4
[ 8209.487896] attempt to access beyond end of device
[ 8209.487901] sr0: rw=0, want=4495388, limit=4
[ 8209.487910] attempt to access beyond end of device
[ 8209.487915] sr0: rw=0, want=4496044, limit=4
[ 8209.487924] attempt to access beyond end of device
[ 8209.487929] sr0: rw=0, want=4495020, limit=4
[ 8209.487938] attempt to access beyond end of device
[ 8209.487942] sr0: rw=0, want=4494796, limit=4
[ 8209.487951] attempt to access beyond end of device
[ 8209.487955] sr0: rw=0, want=4496036, limit=4
[ 8209.487964] attempt to access beyond end of device
[ 8209.487969] sr0: rw=0, want=4495012, limit=4
[ 8209.487978] attempt to access beyond end of device
[ 8209.487982] sr0: rw=0, want=4494788, limit=4
[ 8209.487990] attempt to access beyond end of device
[ 8209.487995] sr0: rw=0, want=1252, limit=4
[ 8209.488004] attempt to access beyond end of device
[ 8209.488008] sr0: rw=0, want=1028, limit=4
[ 8209.488014] UDF-fs: No partition found (1)
[ 8209.514467] attempt to access beyond end of device
[ 8209.514467] sr0: rw=0, want=68, limit=4
[ 8209.514467] isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16


