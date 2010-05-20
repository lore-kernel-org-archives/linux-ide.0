From: Tejun Heo <tj@kernel.org>
Subject: Re: spinlock recursion in scsi_end_request() (kernel 2.6.24)
Date: Thu, 20 May 2010 12:02:48 +0200
Message-ID: <4BF508C8.9050405@kernel.org>
References: <AANLkTilIYz-UITAugWx08u-AvKB5gI-E1M3LORZ55wro@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38506 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab0ETKCv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2010 06:02:51 -0400
In-Reply-To: <AANLkTilIYz-UITAugWx08u-AvKB5gI-E1M3LORZ55wro@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prashant <0xfffff0@gmail.com>
Cc: linux-ide@vger.kernel.org

On 05/17/2010 01:32 PM, Prashant wrote:
> Hi,
> I have a board with backplane for SATA disks. Sometimes when  I unplug
> a disk while
> IO is going on, I get following problem. Has anybody of you
> experienced this before?
> Sometimes spinlock owner is kblockd, sometimes it is scsi_eh.

Sorry but 2.6.24 is way too ancient at this point and too much has
changed.  Can you please try a recent kernel and see whether the
problem is reproducible?

Thanks.

-- 
tejun
