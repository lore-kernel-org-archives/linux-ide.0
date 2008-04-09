From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Wed, 09 Apr 2008 03:40:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0804090337110.19638@zirkon.biophys.uni-duesseldorf.de>
References: <200803301714.04527.bzolnier@gmail.com>
 <200803302134.42569.bzolnier@gmail.com>
 <Pine.LNX.4.64.0803310750230.6871@anakin>
 <200804072113.42441.bzolnier@gmail.com> <20080408094029.GA1005@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.rz.uni-duesseldorf.de ([134.99.128.30]:46773 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbYDICPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 22:15:22 -0400
In-reply-to: <20080408094029.GA1005@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

Hi,

>> v2:
>> * Add 'struct request *rq' argument to ->ata_{in,out}put_data methods
>>   and don't byte-swap disk fs requests (we shouldn't un-swap fs requests
>>   because fs itself is stored byte-swapped on the disk) - this is how
>>   things were done before the patch (ideally device mapper should be
>>   used instead but it would break existing setups and would have some
>>   performance impact).
>
> I like the part about checking 'struct request *rq', will make a  clean
> distinction between ide command data and ide disk/medium data which is badly
> needed.
>
> However, not only FS data is byteswapped, complete disk including partition
> table and everything else is. Will "rq->cmd_type == REQ_TYPE_FS" also catch
> all these cases?

IIRC only identify data (and perhaps ATAPI data) need to be byteswapped 
twice (or not at all), so REQ_TYPE_FS should catch all other cases.

(Good catch about ATAPI there, BTW - I never thought about that, and ISTR 
that IDE CD-ROMs never worked in Linux. That would be the reason why..)

 	Michael
