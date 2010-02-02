From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 520 Bytes sector size
Date: Tue, 02 Feb 2010 18:04:11 -0500
Message-ID: <yq1aavrqlxw.fsf@sermon.lab.mkp.net>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:41676 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab0BBXEx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:04:53 -0500
In-Reply-To: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com> (Dan
	Porat's message of "Tue, 2 Feb 2010 14:50:57 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

>>>>> "Dan" == Dan Porat <dan.porat@gmail.com> writes:

Dan> I would like to run 520 Bytes disk in native mode.  What changes I
Dan> have to run in sg driver ?  Is there any kernel already adapted for
Dan> 520 bytes sector size ?

Linux does not support 520-byte sectors unless the drive is formatted
with DIF and hanging off a DIF-capable HBA.

-- 
Martin K. Petersen	Oracle Linux Engineering
