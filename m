From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Tue, 06 Apr 2010 23:30:02 -0400
Message-ID: <4BBBFC3A.3000605@teksavvy.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBBDFE3.4000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:38187 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753490Ab0DGDaG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 23:30:06 -0400
In-Reply-To: <4BBBDFE3.4000602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

On 06/04/10 09:29 PM, Tejun Heo wrote:
..
>> -    /* check the ending block number */
>> -    return ((block + n_block)<  ((u64)1<<  28))&&  (n_block<= 256);
>> +    /* check the ending block number: must be LESS THAN 0x0fffffff */
>> +    return ((block + n_block)<  (u64)((1<<  28) - 1))&&  (n_block<= 256);
>
> But why move the type casting?  The cast isn't required to begin with
> but starting with u64 constant means the whole compile time
> calculation will be in u64 (the intention of that cast I guess).
..

The cast was there already, so I left it there.
Just moved it to cover the entire compile-time expression as a unit,
rather than just the (u64)1  as the existing code did it.

If you prefer a different format for that line, then chirp up!  :)
