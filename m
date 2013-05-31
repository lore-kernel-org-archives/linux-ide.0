From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Fri, 31 May 2013 10:20:06 +0900
Message-ID: <20130531012006.GB29975@mtj.dyndns.org>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61705 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3EaBUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 21:20:11 -0400
Content-Disposition: inline
In-Reply-To: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: timur@tabi.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, May 30, 2013 at 09:18:29AM -0500, Mark Langsdorf wrote:
> The Calxeda SATA phy intermittently fails to bring up a link with Gen3
> Retrying the phy hard reset can work around the issue, but the drive
> may fail again. In less than 150 out of 15000 test runs, it took more
> than 10 tries for the link to be established (but never more than 35).
> Triple the maximum observed retry count to provide plenty of margin for
> rare events and to guarantee that the link is established.
> 
> Also, the default 2 second time-out on a failed drive is too long in
> this situation. The uboot implementation of the same driver function
> uses a much shorter time-out period and never experiences a time out
> issue. Shorten the Linux time-out value for this driver to 500 ms and
> keep the other timing constants the same as the stock AHCI driver. This
> change was also tested 15000 times on 24 drives and none of them
> experienced a time out.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> ---
> Changes from v1
> 	Add const to the timing variable definition
> 	Added more detail in why the various numbers were chosen

Can you make the detailed explanation comment in the code so that
people don't have to try to hunt down this commit later on?  The
commit message can explain it briefly and refer to the comment in the
body.

Thanks.

-- 
tejun
