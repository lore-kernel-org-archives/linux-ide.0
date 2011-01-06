From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 14:23:40 -0500
Message-ID: <yq1d3o9q1j7.fsf@sermon.lab.mkp.net>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:61055 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1AFTYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 14:24:37 -0500
In-Reply-To: <4D25E96D.10400@computer.org> (Jan Ceuleers's message of "Thu, 06
	Jan 2011 17:10:21 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

>>>>> "Jan" == Jan Ceuleers <jan.ceuleers@computer.org> writes:

Jan> - However, the CompactFlash card in my broadband router is
Jan>   incorrectly reported as rotational.

Hardly surprising for something that's designed for use in cameras...

Chances are, though, that unlike "real" SSDs your CF is slow enough that
it actually benefits from being treated like a rotational device.

-- 
Martin K. Petersen	Oracle Linux Engineering
