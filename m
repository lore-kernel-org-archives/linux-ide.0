From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung SSD 850Pro firmware update queued TRIM problems
Date: Wed, 25 Feb 2015 17:15:47 -0500
Message-ID: <yq1twy9k57w.fsf@sermon.lab.mkp.net>
References: <54EB35EF.2050103@zahlenfresser.de>
	<yq1zj8340nj.fsf@sermon.lab.mkp.net>
	<54ECE94B.9050302@zahlenfresser.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42214 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbbBYWPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2015 17:15:52 -0500
In-Reply-To: <54ECE94B.9050302@zahlenfresser.de> (Stefan Keller's message of
	"Tue, 24 Feb 2015 22:12:43 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Keller <linux-list@zahlenfresser.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Stefan" == Stefan Keller <linux-list@zahlenfresser.de> writes:

Stefan> Hello list, I recently updated the firmware on my Samsung 850
Stefan> Pro from EXM01B6Q to EXM02B6Q.  Now "fstrim -v /" causes SATA
Stefan> command timeouts related to TRIM with NCQ.
>> 
>> Do these timeouts happen if you disable ALPM?

Stefan> Yes.

Bummer. The only good data point we have wrt. queued TRIM problems is
that things only appear to fail when ALPM is enabled. Things are working
fine for me on all the systems in the lab, however, and I have never
been able to reproduce any of the issues reported.

I don't have any 850 drives but will try to get one. For now we should
blacklist queued trim on those.

-- 
Martin K. Petersen	Oracle Linux Engineering
