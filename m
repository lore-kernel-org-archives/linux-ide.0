From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: BUG in latest GIT 2.6.28-0658-g637b180
Date: Wed, 07 Jan 2009 15:01:32 -0600
Message-ID: <4965182C.3010707@lwfinger.net>
References: <49643869.8000500@lwfinger.net> <200901072115.40148.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:55748 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754555AbZAGVBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 16:01:38 -0500
In-Reply-To: <200901072115.40148.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 07 January 2009, Larry Finger wrote:
>> The latest GIT generates the following BUG.
>>
>>
>> BUG: sleeping function called from invalid context at mm/slab.c:3046
>> in_atomic(): 0, irqs_disabled(): 1, pid: 523, name: modprobe
>> no locks held by modprobe/523.
>> irq event stamp: 17802
>>  [<ffffffff8020c2cb>] system_call_fastpath+0x16/0x1b
> 
> Fix below.  Thanks again Larry!

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

The fix works here.

Larry
