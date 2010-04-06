From: Tejun Heo <tj@kernel.org>
Subject: Re: Working around bogus HPAs in libata
Date: Tue, 06 Apr 2010 11:01:28 +0900
Message-ID: <4BBA95F8.7070909@kernel.org>
References: <1269192318.18314.218.camel@localhost>	 <4BB5637E.4050604@kernel.org> <1270245450.12516.187.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56261 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756507Ab0DFCBv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Apr 2010 22:01:51 -0400
In-Reply-To: <1270245450.12516.187.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org

Hello,

On 04/03/2010 06:57 AM, Ben Hutchings wrote:
> Several distributions have turned on the switch by default.  As I said
> previously, this turned out to be a bad idea.

Heh, yeah, I did that on openSUSE which was mandatory for backward
compatibility because ide unlocked HPA by default (at least on
openSUSE).  Do you know how common are these problem cases w/ default
HPA unlocking?  Diddling with HPAs and writing stuff to disks from
BIOS is generally a very bad idea because it means that switching BIOS
options or attaching a hard drive to a different motherboard can lead
to data corruption.

>> Does the following patch work as expected?
...
> So, this looks good, but I'm slightly disturbed by the multiple
> 'capacity change' messages when using libata.

I'll see where those multiple messages are coming from.

> Also, the warnings in ata_dev_revalidate() should not be shown when
> we are deliberately changing capacity.

Given that this is an ugly situation, I don't think it's a bad idea to
emit ugly messages.

> My test case also revealed a bug in the partition scanning retry:
> partition 2 is an extended partition and wholly within the HPA, so the
> extended partition table is not accessible until the HPA is disabled.
> But it is not rescanned after the HPA is disabled.  However, this is is
> consistent between IDE and libata drivers and will not be a regression
> when making the transition.

Ah... I see, but let's fix that up too.  It could be worse to have
half working workaround than not working around at all.  I'll update
the patch once the currently pending HPA updates are in.

Thanks.

-- 
tejun
