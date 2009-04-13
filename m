From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc	cleanups
Date: Mon, 13 Apr 2009 03:54:38 -0400
Message-ID: <49E2EFBE.5000709@garzik.org>
References: <49D1D7A3.40303@panasas.com>	<49D1DCE2.1050201@kernel.org>	<49D214E7.2040908@panasas.com> <20090413163957P.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53259 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbZDMHyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 03:54:53 -0400
In-Reply-To: <20090413163957P.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: bharrosh@panasas.com, tj@kernel.org, petkovbb@gmail.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

FUJITA Tomonori wrote:
> On Tue, 31 Mar 2009 16:04:39 +0300
> Boaz Harrosh <bharrosh@panasas.com> wrote:
> 
>>> I
>>> just don't think bvec should be used outside of block/fs interface.
>>> As I wrote before, non-FS users have no reason to worry about bio.
>>> All it should think about is the requst it needs to issue and the
>>> memory area it's gonna use as in/out buffers.  bio just doesn't have a
>>> place there.
>>>
>> I don't understand what happens to all the people that start to work on the block
>> layer, they start getting defensive about bio being private to the request
>> level. But the Genie is out of the bag already (I know cats and bottles).
>> bio is already heavily used above the block layer from directly inside filesystems
>> to all kind of raid engines, DM MD managers, multi paths, integrity information ...
>>
>> Because bio is exactly that Ideal page carrier you are talking about.
> 
> Wrong. multi path doesn't use bio. md accesses to the bio internal
> (it's not nice) and has the own way to carry pages. dm has the own
> mechanism on the top of bio. And bio doesn't work nicely for file
> systems such as btrfs, which handle multiple devices.
> 
> Please stop your wrong argument 'bio is the ideal page carrier'.

What is the multi-device problem with bio?

The idea behind bio is to be the ideal page carrier :)  It sounds like 
bio needs revision, not abandonment.

	Jeff



