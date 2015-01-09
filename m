From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Fri, 09 Jan 2015 15:52:21 -0500
Message-ID: <yq1387j1xtm.fsf@sermon.lab.mkp.net>
References: <20150107152648.GC4395@htj.dyndns.org>
	<1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
	<54AEA90A.2020502@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22362 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbAIUwp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2015 15:52:45 -0500
In-Reply-To: <54AEA90A.2020502@seoss.co.uk> (Tim Small's message of "Thu, 08
	Jan 2015 15:58:02 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

>>>>> "Tim" == Tim Small <tim@seoss.co.uk> writes:

Tim> would seem clearer to me, because as the patch currently stands,
Tim> "ATA_HORKAGE_ZERO_AFTER_TRIM" implies to me "zero after trim is
Tim> broken on this device".

In SCSI we use often the term "quirk" regardless of whether we enable or
disable a feature. So "horkage" didn't really bother me much in this
context. But I'm happy to submit a name change patch if Tejun thinks
it's a valid concern.

-- 
Martin K. Petersen	Oracle Linux Engineering
