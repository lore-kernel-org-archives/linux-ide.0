From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 17:02:43 -0500
Message-ID: <yq1r5cpoflo.fsf@sermon.lab.mkp.net>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org>
	<yq1d3o9q1j7.fsf@sermon.lab.mkp.net> <4D262ACF.6010305@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:61935 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1AFWFA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 17:05:00 -0500
In-Reply-To: <4D262ACF.6010305@computer.org> (Jan Ceuleers's message of "Thu,
	06 Jan 2011 21:49:19 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

>>>>> "Jan" == Jan Ceuleers <jan.ceuleers@computer.org> writes:

>> Chances are, though, that unlike "real" SSDs your CF is slow enough
>> that it actually benefits from being treated like a rotational
>> device.

Jan> Thanks. But performance is not my primary concern or I wouldn't
Jan> have chosen a system consisting of low-performance components ;-)
Jan> (the CompactFlash card is only one example; others include the
Jan> 500MHz Geode CPU, Via Rhine NICs, a tiny amount of RAM etc). I care
Jan> more about low power consumption and the system has to be only just
Jan> fast enough for my needs.

There are "real" SSDs in CompactFlash form factor and they do fare much
better than the consumer cards. Made a significant difference on my
Geode boxes, anyway. But most importantly they have much better write
endurance than the camera cards which is the reason I originally got
them.

-- 
Martin K. Petersen	Oracle Linux Engineering
