From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Thu, 04 Dec 2014 21:46:53 -0500
Message-ID: <yq1vblqg6ea.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <547FCECB.4090908@ubuntu.com>
	<yq1sigwgkqt.fsf@sermon.lab.mkp.net> <547FD4F6.7090700@ubuntu.com>
	<yq1k328gk80.fsf@sermon.lab.mkp.net>
	<20141204214946.3ce15a90@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17784 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbaLECrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 21:47:11 -0500
In-Reply-To: <20141204214946.3ce15a90@lxorguk.ukuu.org.uk> (One Thousand
	Gnomes's message of "Thu, 4 Dec 2014 21:49:46 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Phillip Susi <psusi@ubuntu.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "Alan" == One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> writes:

Alan> I assume it's something vaguely of the form

Alan> Vendor A has agreed with Oracle that drive identity X will do this
Alan> and meet some certification so Oracle can approve it for databases

Actually, we don't trust devices to zero anything for us :)

Alan> Oracle has agreed to break vendor A's legs if it doesn't

Alan> Oracle would rather like that the kernel just knows about this
Alan> drive as being good, based on the above.

We're generally not dealing with this kind of consumer/SMB hardware at
Oracle. So s/Oracle/$OTHER_OEM/, but yeah.

My interest in this is purely from the upstream discard lackey
perspective...

-- 
Martin K. Petersen	Oracle Linux Engineering
