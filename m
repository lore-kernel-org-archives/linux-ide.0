From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] stop gcc warning about uninitialized 'dev' in	ata_scsi_scan_host
Date: Thu, 16 Oct 2008 08:02:08 +0200
Message-ID: <87r66hjcwv.fsf@denkblock.local>
References: <20081015232505.GB9272@ldl.fc.hp.com>
	<48F6A2E7.5090005@kernel.org> <20081016034042.GA27621@ldl.fc.hp.com>
	<48F6BAFE.6080106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:47764 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbYJPGCW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 02:02:22 -0400
In-Reply-To: <48F6BAFE.6080106@kernel.org> (Tejun Heo's message of "Thu, 16
	Oct 2008 12:54:38 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alex Chiang <achiang@hp.com>, jeff@redhat.com, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Tejun Heo <tj@kernel.org> wrote:
> Alex Chiang wrote:
>> * Tejun Heo <tj@kernel.org>:
>
>>> Alex Chiang wrote:
>>>> Shuts up gcc-3.4.5-glibc-2.3.6 when it complains of:
>>>>
>>>> drivers/ata/libata-scsi.c: In function `ata_scsi_scan_host':
>>>> drivers/ata/libata-scsi.c:3225: warning: 'dev' might be used
>>>> uninitialized in this function
>>>>
>>>> Signed-off-by: Alex Chiang <achiang@hp.com>
>>> Nacked-by: Tejun Heo <tj@kernel.org>
>>>
>>> Some gcc versions complain about sata_via, others complain
>>> about something else.  Some versions complain about some
>>> iterator usages while not complaining about others, but none of
>>> those complaints is actually wrong or dangerous.  I don't think
>>> adding = NULL whenever some version of gcc complains is the
>>> right approach.
>> 
>> Hm, ok.
>> 
>> I guess we don't want to sprinkle these around all over the place
>> just to solve cosmetic issues, which makes sense, but is there
>> some other approach we could take instead? Any suggestions? Or
>> just live with it?
>
> I think the current policy is blaming gcc but I also added quite a few
> bogus NULL initializations here and there and caught several bugs thanks
> to those warnings.  We can think about adding an additional annotation
> with leading double underbars which indicate that certain pointer
> arguments to functions expect (or are okay with) pointers to
> uninitialized variables which should be able to remove many of those
> spurious warnings (on the caller side, the compiler can ignore the
> warning and on the callee side the compiler can check whether it's being
> dereferenced without being written to).  Does anyone know whether gcc
> already has that type of annotation?

Well, I don't know of this particular kind of annotation. However, I
don't quite see how that would solve the reported issue. Here, dev is a
local variable and the warning is generated due to the line

		if (dev != last_failed_dev) {

For this sort of thing we have:

	struct ata_device *uninitialized_var(dev);

Or is that precisely the thing you did *not* want?

Regards,

Elias
