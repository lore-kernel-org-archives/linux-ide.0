From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 16:54:10 -0500
Message-ID: <yq1vd21ofzx.fsf@sermon.lab.mkp.net>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org>
	<AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
	<AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
	<yq18vyxq15w.fsf@sermon.lab.mkp.net>
	<AANLkTiksg1a1joizFhJ34yGHZpbdaCKt5HcWnMoyEkWp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:37270 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab1AFVzO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 16:55:14 -0500
In-Reply-To: <AANLkTiksg1a1joizFhJ34yGHZpbdaCKt5HcWnMoyEkWp@mail.gmail.com>
	(Jeff Garzik's message of "Thu, 6 Jan 2011 15:41:45 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Freemyer <greg.freemyer@gmail.com>, Jan Ceuleers <jan.ceuleers@computer.org>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:

Jeff> In an ideal world where information and engineers are cost-free...

Oh, yeah...


Jeff> if a device is non-rotational, we should know this, whether it's
Jeff> ancient compact flash, or gigabyte's DRAM-based ATA device, or
Jeff> modern SSD.  It shouldn't be a question of whether or not treating
Jeff> a non-rotational device as a non-rotational device is performance
Jeff> win -- because if you're asking that question, it might imply
Jeff> areas where we are making invalid assumptions about certain
Jeff> classes of non-rotational devices :)

Well, there were a few attempts at getting SSD performance metrics into
ATA. They failed for political/marketing reasons. Even if we had gotten
the metrics we wanted I'm sure most vendors would have indicated that
"this one goes to eleven".

All we have is non-rotational which means "seeks are cheaper than on
rotating media". And for a lot of older/slower flash devices it's
actually a win to do merging because command latency can be quite
high. So it's not necessarily a win to go non-rotational. Which is why I
suggested looking at numbers instead of blindly whitelisting every ATA
flash device known to man.

However, now it appears that what Greg really needs is a
supports_secure_erase flag...

-- 
Martin K. Petersen	Oracle Linux Engineering
