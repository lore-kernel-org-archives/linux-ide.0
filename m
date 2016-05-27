From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Kernel option to disable TRIM/discard system-wide?
Date: Thu, 26 May 2016 22:52:21 -0400
Message-ID: <yq1oa7syzyy.fsf@sermon.lab.mkp.net>
References: <57436FA6.1010801@rabbit.us> <5745A24D.2010601@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31378 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbcE0Cwh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2016 22:52:37 -0400
In-Reply-To: <5745A24D.2010601@rabbit.us> (Peter Rabbitson's message of "Wed,
	25 May 2016 15:02:05 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Rabbitson <rabbit+list@rabbit.us>
Cc: linux-ide@vger.kernel.org

>>>>> "Peter" == Peter Rabbitson <rabbit+list@rabbit.us> writes:

>> I want to disable trim on my system for good - yet there seems to be
>> no kernel boot parameter for this.

There's no global way to disable TRIM but you can disable it on a
per-device basis by setting /sys/block/sdN/queue/discard_max_bytes to
0. You can force queued TRIM off with noncqtrim if that makes you feel
better. However, we haven't blacklisted any drives due to TRIM problems
in about a year.

-- 
Martin K. Petersen	Oracle Linux Engineering
