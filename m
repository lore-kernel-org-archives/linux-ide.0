From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Wed, 03 Dec 2014 22:35:59 -0500
Message-ID: <yq1k328gk80.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <547FCECB.4090908@ubuntu.com>
	<yq1sigwgkqt.fsf@sermon.lab.mkp.net> <547FD4F6.7090700@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26037 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaLDDgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2014 22:36:07 -0500
In-Reply-To: <547FD4F6.7090700@ubuntu.com> (Phillip Susi's message of "Wed, 03
	Dec 2014 22:28:54 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "Phillip" == Phillip Susi <psusi@ubuntu.com> writes:

Phillip> On 12/03/2014 10:24 PM, Martin K. Petersen wrote:
>> Well. It's a bit stronger than wishful thinking given that OEM
>> product requirements documents and supply contracts make it so. But
>> it is not something we can get in writing.

Phillip> OEM product requirements documents and supply contracts sound
Phillip> like forms of writing to me.

Except they are not forms of writing that we as a community have access
to.

-- 
Martin K. Petersen	Oracle Linux Engineering
