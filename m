From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/4] libata: Expose TRIM capability in sysfs
Date: Tue, 05 May 2015 17:54:13 -0400
Message-ID: <yq1oalyr8qi.fsf@sermon.lab.mkp.net>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
	<1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
	<20150505175055.GA24551@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22066 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbEEVyq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 17:54:46 -0400
In-Reply-To: <20150505175055.GA24551@infradead.org> (Christoph Hellwig's
	message of "Tue, 5 May 2015 10:50:55 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org, hare@suse.de, linux-ide@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

>> + forced_unqueued: Drive's unqueued DSM support is known to be +
>> buggy and only unqueued TRIM commands + are sent

Christoph> Shouldn't the first "unqueued" be a "queued"

Yes, sorry about that.

-- 
Martin K. Petersen	Oracle Linux Engineering
