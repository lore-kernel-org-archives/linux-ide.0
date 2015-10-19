From: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH v2] ata: ahci: find eSATA ports and flag them as removable
Date: Sun, 18 Oct 2015 22:32:26 -0400
Message-ID: <5624563A.7080105@start.ca>
References: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
 <20150930213910.GG2627@mtj.duckdns.org> <5620F09A.9010909@start.ca>
 <20151016125409.GA20700@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:46054 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbbJSCcs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Oct 2015 22:32:48 -0400
In-Reply-To: <20151016125409.GA20700@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-ide@vger.kernel.org

On 15-10-16 08:54 AM, Tejun Heo wrote:
> Hello, Mark.
>
> On Fri, Oct 16, 2015 at 08:42:02AM -0400, Mark Lord wrote:
>>> Applied to libata/for-4.4.  Let's see what happens.
>>
>> Ugh.  Yet another revert to include in my own builds, I guess.
>
> Hmmm... what other patches are you reverting?

For libata, other than this one, I only disable SATA LPM.
But something is wrong with the Seagate 8TB drives in
the latest kernels, so I'll have to figure that one out too
at some point.  The drives keep dropping offline, requiring a
system power cycle to recover.  Cause unknown.  Nothing in S.M.A.R.T.

>> eSATA is used for permanent storage expansion with port-multipliers,
>> and having to stop command queuing frequently for useless polling
>> is gonna be a performance drain.
>
> What would poll it regularly?

I though your own earlier post suggested something there,
but I no longer have it to re-read.

I'm expecting that "removable" will imply different elevator
scheduling and more frequent journal flushing etc.

But perhaps it's a bit unfair to just presume that just yet,
so you have my apologies!

But I'm still reverting/disabling this one locally.

Cheers
Mark
