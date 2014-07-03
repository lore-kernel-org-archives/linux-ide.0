From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Thu, 3 Jul 2014 09:47:17 -0400
Message-ID: <20140703134717.GA16191@htj.dyndns.org>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:57214 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187AbaGCNrV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 09:47:21 -0400
Received: by mail-qc0-f173.google.com with SMTP id l6so220333qcy.18
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 06:47:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404389382-27298-5-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Thu, Jul 03, 2014 at 08:09:41PM +0800, Kevin Hao wrote:
> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. This patch provides the function
> for libata to adjust the queue depth for a host controller.

ATA_TAG_INTERNAL is an internal way of marking an EH command and
doesn't actually get used as a command tag.  After all, EH doesn't
issue any tagged command.  We can use tag 32 for it but have been
using 31 for it for historical reasons, so the only necessary part is
updating the tag allocator to wrap according to the max number of tags
supported by the controller. 

Thanks.

-- 
tejun
