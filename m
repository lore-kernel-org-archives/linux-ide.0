From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Sun, 2 Jun 2013 01:00:10 -0700
Message-ID: <20130602080010.GB8286@mtj.dyndns.org>
References: <1369842679-9680-1-git-send-email-mark.langsdorf@calxeda.com>
 <1370014046-5202-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:39643 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3FBIAQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 04:00:16 -0400
Content-Disposition: inline
In-Reply-To: <1370014046-5202-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: timur@tabi.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, clemens@ladisch.de, sergei.shtylyov@cogentembedded.com

On Fri, May 31, 2013 at 10:27:26AM -0500, Mark Langsdorf wrote:
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

For the third time, explain the above in the comment; otherwise, it's
not going in.

-- 
tejun
