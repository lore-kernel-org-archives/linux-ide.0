From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Thu, 06 May 2010 15:49:43 -0400
Message-ID: <4BE31D57.6020400@garzik.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50111 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab0EFTtr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 May 2010 15:49:47 -0400
Received: by vws18 with SMTP id 18so106075vws.19
        for <linux-ide@vger.kernel.org>; Thu, 06 May 2010 12:49:45 -0700 (PDT)
In-Reply-To: <4BE2D5D6.1010705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 05/06/2010 10:44 AM, Tejun Heo wrote:
> Hello,
>
> On 05/06/2010 11:30 AM, Arjan van de Ven wrote:
>> The thing is, SSS means the system requests (well, demands) that we
>> don't spin up the disks up in parallel.... which we really really
>> ought to honor... Jeff had a very valid point.
>
> Hmmm... yeah but SSS doesn't really demand it.  It just says "I can do
> staggered spin up".  I wish this thing had been implemented in the
> form of "stay spin down till necessary (ie. start in standby mode)".
> Currently, there's no way to tell whether staggered spin up is needed
> or drives are already spun up.
>
>> While today some bioses may spin everything up, that's not going to
>> be the case going forward...  the industry as a whole is moving away
>> from that (slowly but steadily).
>
> Yeah, sure, in the long run maybe but I'm skeptical how useful this is
> at this point.  Going forward, the right thing to do would be
> implementing some sort of token infrastructure so that drivers can
> request and hold the token while spinning up a drive so that the
> concurrency of spin ups can be controlled.
>
> Jeff, what do you think about lifting the check for now unless there
> are known cases where this can cause problems?

The problem being...  that we are honoring SSS bit, and thus thing are 
slower?  :)  I don't see any reason to change that, seeing as how people 
may be using it to avoid power spikes.

I agree there's no way to tell whether SSS is needed, but we cannot 
ignore SSS on that basis alone.  We should avoid making the assumption 
that BIOS w/ SSS bit has already spun up all drives regardless.

	Jeff



