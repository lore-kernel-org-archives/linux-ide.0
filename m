From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung SSD 850Pro firmware update queued TRIM problems
Date: Tue, 24 Feb 2015 13:36:32 -0500
Message-ID: <yq1zj8340nj.fsf@sermon.lab.mkp.net>
References: <54EB35EF.2050103@zahlenfresser.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49118 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbBXSgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2015 13:36:35 -0500
In-Reply-To: <54EB35EF.2050103@zahlenfresser.de> (Stefan Keller's message of
	"Mon, 23 Feb 2015 15:15:11 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Keller <linux-list@zahlenfresser.de>
Cc: linux-ide@vger.kernel.org

>>>>> "Stefan" == Stefan Keller <linux-list@zahlenfresser.de> writes:

Stefan> Hello list, I recently updated the firmware on my Samsung 850
Stefan> Pro from EXM01B6Q to EXM02B6Q.  Now "fstrim -v /" causes SATA
Stefan> command timeouts related to TRIM with NCQ.

Do these timeouts happen if you disable ALPM?

-- 
Martin K. Petersen	Oracle Linux Engineering
