From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Thu, 3 Jul 2014 09:50:58 -0400
Message-ID: <20140703135058.GB16191@htj.dyndns.org>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49086 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbaGCNvC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 09:51:02 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so229925qcw.31
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 06:51:01 -0700 (PDT)
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

Shouldn't the function at least trigger WARN_ON_ONCE() if it's forcing
the tag to be 0 when it shouldn't be?  Silently mapping things to zero
doesn't look like a particularly good idea.

Thanks.

-- 
tejun
