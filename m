From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk stuck in error recovery loop with AHCI
Date: Sat, 24 Feb 2007 13:22:50 +0900
Message-ID: <45DFBD9A.6090204@gmail.com>
References: <20070221052022.GA15964@jim.sh> <20070223072826.GA2763@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:44150 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933379AbXBXEWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 23:22:51 -0500
Received: by py-out-1112.google.com with SMTP id a29so352851pyi
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 20:22:51 -0800 (PST)
In-Reply-To: <20070223072826.GA2763@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org

Jim Paris wrote:
> Still, it seems that some improvements could be made to the EH when
> this sort of thing happens.  For example, after "speed down requested
> but no transfer mode left" a few times in a row, maybe it would make
> sense to just fail the disk and give up.  That would have allowed
> higher layers like MD to recover.

That's SD retrying sector-by-sector a large request as libata doesn't
report proper failed sector info.  Please try 2.6.20.  md will fail the
drive after a few errors.

Patches to improve EH behavior further went into 2.6.21 devel tree and
some are pending.

Thanks.

-- 
tejun
