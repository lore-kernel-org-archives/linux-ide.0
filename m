From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Wed, 31 Aug 2005 18:50:42 +0400
Message-ID: <4315C3C2.5010007@wasp.net.au>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>	<x3k1x4akhog.fsf@Psilocybe.Update.UU.SE>	<4315BB6F.2050402@wasp.net.au> <17173.49068.154562.170503@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:33758 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932495AbVHaOvE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2005 10:51:04 -0400
In-Reply-To: <17173.49068.154562.170503@Psilocybe.Update.UU.SE>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorild Selen <thorild@Update.UU.SE>
Cc: linux-ide@vger.kernel.org

Thorild Selen wrote:
> Brad Campbell writes:
>  > In one machine, I'm using 15 disks on 4 SATA150TX4 cards with
>  > 2.6.11.7 and have been now for over 4 months.. it's working
>  > perfectly.. not so much as a glitch.
> 
> Is this a single-processor system without hyperthreading or the like?
> In that case, it could be that the problem only appears on SMP/HT
> systems, which would be interesting to know.
> 
> (I was hit by the bug on a single-processor Xeon system, but with HT
> enabled. I never thought of testing if disabling HT would make the bug
> disappear or not. And now that the system is up and running again, I
> don't really have the possibility to experiment with it.)
> 
> If you have partitions on different devices that you can spare and
> feel a little risky, you can try running badblocks -w (WARNING: this
> will destroy any data on the disk/partition!) on several disks
> simultaneously.  That appears to be the simplest way to quickly
> reproduce the bug.

These 15 drives are in a RAID-6 that gets thrashed from time to time quite hard.. so there is almost 
*always* simultaneous IO to them.. But it is certainly a UP machine (both of them are).
This one has 15 drives RAID-6, the other has 10 drives RAID-5 and 3 drives RAID-5 (two on the 
Promise ctrlr and one on the on-board VIA)

No free partitions to spare, sorry.. all md's are pretty full.
However I did all sorts of badblocks/dd/bonnie runs when I was burning in the box and never had an 
issue at all.

-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
