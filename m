From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4] libata: support the ata host which implements a queue
 depth less than 32
Date: Mon, 14 Jul 2014 12:42:44 -0400
Message-ID: <20140714164244.GG31610@htj.dyndns.org>
References: <1405138104-25769-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35938 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbaGNQms (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2014 12:42:48 -0400
Received: by mail-qc0-f170.google.com with SMTP id c9so3802361qcz.15
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2014 09:42:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405138104-25769-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Sat, Jul 12, 2014 at 12:08:24PM +0800, Kevin Hao wrote:
> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 31 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. So consider the queue depth
> implemented by the hardware when requesting a command tag.
> 
> Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied to libata/for-3.16-fixes.

Thanks.

-- 
tejun
