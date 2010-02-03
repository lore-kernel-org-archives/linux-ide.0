From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 520 Bytes sector size
Date: Wed, 03 Feb 2010 03:46:16 -0500
Message-ID: <yq1d40md7vr.fsf@sermon.lab.mkp.net>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>
	<yq1aavrqlxw.fsf@sermon.lab.mkp.net>
	<20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:50199 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543Ab0BCIsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 03:48:32 -0500
In-Reply-To: <20100202232540.7f5327f6@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Tue, 2 Feb 2010 23:25:40 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Dan Porat <dan.porat@gmail.com>, linux-ide@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Linux does not support 520-byte sectors unless the drive is formatted
>> with DIF and hanging off a DIF-capable HBA.

Alan> Is that true even with sg - I wouldn't have thought sg minded, it
Alan> doesn't seem to mind about strange sized transfers for CD-ROM ?

Did not work last I mucked with it a while back.  If I recall correctly
there were a few places where we assumed multiples of 512.

-- 
Martin K. Petersen	Oracle Linux Engineering
