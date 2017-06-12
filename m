From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Convert bare printks to pr_cont
Date: Mon, 12 Jun 2017 15:28:55 -0400
Message-ID: <20170612192855.GM19206@htj.duckdns.org>
References: <9b704f23a6e72b8b5b365efa88f9dda393407b7f.1497295039.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34391 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdFLT26 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2017 15:28:58 -0400
Content-Disposition: inline
In-Reply-To: <9b704f23a6e72b8b5b365efa88f9dda393407b7f.1497295039.git.joe@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 12, 2017 at 12:17:39PM -0700, Joe Perches wrote:
> Linus Torvalds changed the behavior of printks without KERN_<LEVEL>.
> 
> Convert the continuation prints to use pr_cont.
> 
> At the same time, convert the existing printks with KERN_<LEVEL> to
> pr_<level>
> 
> Miscellanea:
> 
> o Coalesce a multiline format
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
