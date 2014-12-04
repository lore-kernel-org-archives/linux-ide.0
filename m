From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Wed, 03 Dec 2014 22:24:42 -0500
Message-ID: <yq1sigwgkqt.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <547FCECB.4090908@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23106 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaLDDYu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2014 22:24:50 -0500
In-Reply-To: <547FCECB.4090908@ubuntu.com> (Phillip Susi's message of "Wed, 03
	Dec 2014 22:02:35 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "Phillip" == Phillip Susi <psusi@ubuntu.com> writes:

Phillip> On 12/03/2014 09:44 PM, Martin K. Petersen wrote:
>> This patch whitelists SSDs from a few of the main vendors. None of
>> the whitelists are based on written guarantees. They are purely based
>> on empirical evidence collected from internal and external users that
>> have tested or qualified these drives in RAID deployments.

Phillip> Without anything in writing from the vendor, such a white list
Phillip> amounts to nothing more than wishful thinking.  You can't
Phillip> really test for it and even if it *appears* to be so, the drive
Phillip> is free to change its behavior any time.

Well. It's a bit stronger than wishful thinking given that OEM product
requirements documents and supply contracts make it so. But it is not
something we can get in writing.

It is, however, a step up from the blanket whitelist we've had so far
where we assumed that it worked for every drive that had DRAT/RZAT set.

-- 
Martin K. Petersen	Oracle Linux Engineering
