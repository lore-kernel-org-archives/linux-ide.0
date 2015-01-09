From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Fri, 9 Jan 2015 16:39:29 -0500
Message-ID: <20150109213929.GD2785@htj.dyndns.org>
References: <20150107152648.GC4395@htj.dyndns.org>
 <1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
 <54AEA90A.2020502@seoss.co.uk>
 <yq1387j1xtm.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:46567 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbAIVjd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2015 16:39:33 -0500
Content-Disposition: inline
In-Reply-To: <yq1387j1xtm.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tim Small <tim@seoss.co.uk>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 09, 2015 at 03:52:21PM -0500, Martin K. Petersen wrote:
> >>>>> "Tim" == Tim Small <tim@seoss.co.uk> writes:
> 
> Tim> would seem clearer to me, because as the patch currently stands,
> Tim> "ATA_HORKAGE_ZERO_AFTER_TRIM" implies to me "zero after trim is
> Tim> broken on this device".
> 
> In SCSI we use often the term "quirk" regardless of whether we enable or
> disable a feature. So "horkage" didn't really bother me much in this
> context. But I'm happy to submit a name change patch if Tejun thinks
> it's a valid concern.

I think it's fine.  It's not like its polarity is confusing - nobody
would read it as meaning the opposite.

Thanks.

-- 
tejun
