From: "NeilBrown" <neilb@suse.de>
Subject: Re: hdaprm -Y /dev/sda /dev/sdb -> I/O error -> disk kicked out of
     RAID - is it normal?
Date: Fri, 17 Jul 2009 14:38:20 +1000 (EST)
Message-ID: <29d09dacb3dce47830a95bc6493d3b88.squirrel@neil.brown.name>
References: <4A5FB1DD.3000904@wpkg.org> <4A5FFA46.1070203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37387 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbZGQEi2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jul 2009 00:38:28 -0400
In-Reply-To: <4A5FFA46.1070203@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, linux-raid@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, July 17, 2009 2:12 pm, Tejun Heo wrote:
> Tomasz Chmielewski wrote:
>> And one of the disks is kicked out of RAID.
>>
>> Is it expected behaviour (although probably the error happens somewhere
>> in the ata layer)?
>
> Yes, it's expected.  Wakeup requires reset via EH and md requests have
> FAILFAST flag set, so they never get retried.  The behavior can be
> changed tho.  Hmmm... not entirely sure what to do at this point.

Nope, 'md' requests do not get FAILFAST set.  I tried that and easily
found cases where it fails way too fast.  FAILFAST seems to mean different
things on different devices, making it useless in general (it is still
useful in some specific cases such as multipath on devices which are
expected to be used under multipath and so treat FAILFAST appropriately).

NeilBrown

