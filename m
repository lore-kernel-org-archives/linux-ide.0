From: Tejun Heo <htejun@gmail.com>
Subject: Re: hsm violation
Date: Mon, 25 Jun 2007 11:12:37 +0900
Message-ID: <467F2495.3080509@gmail.com>
References: <fa.sspu6LOivd/touNtS2IsMKPqHa0@ifi.uio.no> <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no> <467EC909.9040006@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:40062 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbXFYCMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jun 2007 22:12:49 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1221118nzf
        for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 19:12:48 -0700 (PDT)
In-Reply-To: <467EC909.9040006@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, enricoss@tiscali.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> Andrew Morton wrote:
>> On Sun, 24 Jun 2007 14:32:22 +0200 Enrico Sardi <enricoss@tiscali.it>
>> wrote:
>>> [   61.176000] ata1.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action
>>> 0x2 frozen
>>> [   61.176000] ata1.00: (spurious completions during NCQ issue=0x0
>>> SAct=0x2 FIS=005040a1:00000004)
>>
>> It's not obvious (to me) whether this is a driver bug, a hardware bug,
>> expected-normal-behaviour or what - those diagnostics (which we get to
>> see distressingly frequently) are pretty obscure.
> 
> The spurious completions during NCQ error is indicating that the drive
> has indicated it's completed NCQ command tags which weren't outstanding.
>  It's normally a result of a bad NCQ implementation on the drive.
> Technically we can live with it, but it's rather dangerous (if it
> indicates completions for non-outstanding commands, how do we know it
> doesn't indicate completions for actually outstanding commands that
> aren't actually completed yet..)

There is a small race window there.  Please consider the following sequence.

1. drive sends SDB FIS with spurious completion in it.
2. block layer issues new r/w command to the drive.  SDB FIS is still in
flight.
3. ata driver issues the command (the pending bit is set prior to
transmitting command FIS).
4. controller completes receiving FIS from #1.  Driver reads the mask
and completes all indicated commands.  If spurious completion in #1
happens to match the slot allocated in #3, the driver just completed a
command which hasn't been issued to the drive yet.

So, it actually is dangerous.  We might even be seeing the real
completion as spurious one (as the command is completed prematurely).

It seems all those HTS541* drives share this problem.  Four of them are
already on the blacklist and the other OS reportedly blacklists three of
them too.  I'll submit a patch to add HTS541616J9SA00.

Thanks.

-- 
tejun
