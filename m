From: "Martin K. Petersen" <martin.petersen@Oracle.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 14:31:39 -0500
Message-ID: <yq18vyxq15w.fsf@sermon.lab.mkp.net>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org>
	<AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
	<AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:22957 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab1AFTdS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 14:33:18 -0500
In-Reply-To: <AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
	(Greg Freemyer's message of "Thu, 6 Jan 2011 13:40:41 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jan Ceuleers <jan.ceuleers@computer.org>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

>>>>> "Greg" == Greg Freemyer <greg.freemyer@gmail.com> writes:

Greg> As the maintainer, can you provide direction as to how quirks
Greg> should be maintained for the rotating disk flag (as reflected in
Greg> /sys/block/sda/queue/rotational).

Greg> There is Bart's patch, Peter's patch, and Martin says it can be
Greg> overridden from userspace (I'm not sure which tool,

# echo 0 > /sys/block/sda/queue/rotational


Greg> nor do I know if there is already a userspace quirks table to add
Greg> to.).

I agree with Jeff that Tejun's tool would be the right place. And
there's always udev...

But the question is whether it's worth the hassle since there a many of
these devices out there and it is unclear whether treating them as
non-rotational is a win. If you can provide some compelling performance
improvement numbers for a particular device we can look into adding a
quirk for it.

-- 
Martin K. Petersen	Oracle Linux Engineering
