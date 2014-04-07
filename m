From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Mon, 07 Apr 2014 15:52:00 -0400
Message-ID: <yq1y4zgvrxb.fsf@sermon.lab.mkp.net>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
	<1452108.oyGVeRVWlF@quad>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51736 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbaDGTwR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2014 15:52:17 -0400
In-Reply-To: <1452108.oyGVeRVWlF@quad> (Chris Samuel's message of "Sat, 05 Apr
	2014 19:12:05 +1100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Samuel <chris@csamuel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org, linux-ide@vger.kernel.org, Marc MERLIN <marc@merlins.org>

>>>>> "Chris" == Chris Samuel <chris@csamuel.org> writes:

Chris> Both patches applied cleanly to 3.14, kernel now reports
Chris> "unsupported" for everything other than the SSD in my ZaReason
Chris> laptop (Crucial M4 mSATA SSD) which reports "unqueued" (which is
Chris> expected).

Chris> Tested-By: Chris Samuel <chris@csamuel.org>

Thanks for testing (both of you)!

-- 
Martin K. Petersen	Oracle Linux Engineering
