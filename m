From: Tejun Heo <tj@kernel.org>
Subject: Re: HighPoint RocketRAID 2320
Date: Wed, 05 Aug 2009 12:58:10 +0900
Message-ID: <4A790352.6080804@kernel.org>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to> <4A7821AF.9010609@kernel.org> <20090804174852.GH13863@dsg.to> <4A78FE5A.1080203@rtr.ca> <4A790008.3020601@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55655 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933141AbZHED6q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 23:58:46 -0400
In-Reply-To: <4A790008.3020601@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
>> Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
>>> Hi Tejun,
>>>
>>> I tried this and attach a dmesg output. The result was the same.
>> ..
>> Mmm... interrupts are not getting through the bridge chip.
> ..
>=20
> This is just a blind shot in the dark, but easy enough to try:
>=20
> How about booting with pci=3Dnomsi on the kernel command line ?

And if that fails irqpoll.  :-)

--=20
tejun
