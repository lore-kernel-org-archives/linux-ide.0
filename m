From: Mark Lord <liml@rtr.ca>
Subject: Re: HighPoint RocketRAID 2320
Date: Tue, 04 Aug 2009 23:44:08 -0400
Message-ID: <4A790008.3020601@rtr.ca>
References: <20090803201836.GD13863@dsg.to> <20090803203139.GE13863@dsg.to> <4A7821AF.9010609@kernel.org> <20090804174852.GH13863@dsg.to> <4A78FE5A.1080203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44093 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932670AbZHEDoJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 23:44:09 -0400
In-Reply-To: <4A78FE5A.1080203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
>> Hi Tejun,
>>
>> I tried this and attach a dmesg output. The result was the same.
> ..
> Mmm... interrupts are not getting through the bridge chip.
=2E.

This is just a blind shot in the dark, but easy enough to try:

How about booting with pci=3Dnomsi on the kernel command line ?

Cheers
