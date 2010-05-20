From: Tejun Heo <tj@kernel.org>
Subject: Re: Strange read data corruption on ext4/LVM/md
Date: Thu, 20 May 2010 11:42:29 +0200
Message-ID: <4BF50405.4070706@kernel.org>
References: <20100519225653.1fedb453@mjolnir.ossman.eu>	<20100519230426.47c6c1ed@mjolnir.ossman.eu>	<20100519232906.3be82279@mjolnir.ossman.eu>	<20100519233408.7436bd9b@mjolnir.ossman.eu>	<20100520091429.192d560c@mjolnir.ossman.eu>	<4BF4F979.4070903@kernel.org> <20100520112945.61bf9705@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50354 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140Ab0ETJme (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2010 05:42:34 -0400
In-Reply-To: <20100520112945.61bf9705@mjolnir.ossman.eu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 05/20/2010 11:29 AM, Pierre Ossman wrote:
> The machine is rather crammed right now, with one controller in each of
> the three available pci-e slots (5 disks). I am running continuous tests
> on the disks right now though to see if the problems is on all disks or
> just some. If just one slot is causing problems then we should see some
> results there.

I see.

> When you say FIS corruption, do you mean corruption in the sense of

Oh, not FIS, FIS is the name for SATA packets.  I meant the PCI-e
packets.  How were they called... yeap TLPs.

> randomly flipped bits? I don't know if you saw the first couple of
> mails (before linux-ide was added), but the problem is data being moved
> around, not just randomly changed.

I ony saw your previous posting.  TLP corruption can happen during
command setup phase and bit flipping in the command address part is
definitely possible, so reads and writes can be headed at wrong places
in both memory and disk.  I don't know whether this would fit your
symptom tho.

> Another note is that the problem seems to worsen under load. I'm
> running the dd thing in the background, which seems to make read errors
> more common on my test files on the filesystem level.

It would be great if you can try a different controller in similar
setup.  But please keep trying to narrow down the problem and if
possible please remove filesystem from the stack and test against the
block device directly.

Thanks.

-- 
tejun
