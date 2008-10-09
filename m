From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Thu, 9 Oct 2008 10:36:14 +0200
Message-ID: <58cb370e0810090136t327734cerf6eb933422b9791c@mail.gmail.com>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
	 <20081009065141.GV19428@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:13654 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYJIIgP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Oct 2008 04:36:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4708154rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 09 Oct 2008 01:36:15 -0700 (PDT)
In-Reply-To: <20081009065141.GV19428@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 9, 2008 at 8:51 AM, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Wed, Oct 08 2008, Bartlomiej Zolnierkiewicz wrote:
>>
>> Locking improvements in preparation for replacing the global ide_lock
>> spinlock by per-hwgroup spinlocks [1].
>>
>> [1] patch (which is partially based on 2005 patch from Scalex86) for this
>> is also ready but it needs some more audit and testing
>>
>> diffstat:
>>  drivers/ide/ide-cd.c     |   38 ++++++-------
>>  drivers/ide/ide-io.c     |  129 ++++++++++++++++++++---------------------------
>>  drivers/ide/ide-ioctls.c |    3 -
>>  drivers/ide/ide-lib.c    |    7 --
>>  drivers/ide/ide-proc.c   |   25 +--------
>>  drivers/ide/ide.c        |    7 --
>>  6 files changed, 80 insertions(+), 129 deletions(-)
>
> Sorry, but I just have to ask 'why'? IDE is seeing a whole lot of churn
> for something that should essentially be a stable code base in
> maintenance mode, and now scalability improvements?

It is the stable code but being in "maintenance only mode" has never
been true and as long as there are active users & developers there is
really no reason to change it.

> Just doesn't make ANY sense to me, sorry. We may end up with a cleaner
> code base, but likely also a buggier one. It's not like hardware
> coverage testing is all that great, considering some of the ancient
> stuff it supports :-)

The changes above are relatively safe/simple and are not hardware specific.

Thanks for worring about IDE but we should be fine. :)

Bart
