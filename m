From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 18:20:18 -0400
Message-ID: <4C325AA2.9020201@pobox.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com> <4C322585.602@pobox.com> <4C3252FF.3040501@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63994 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab0GEWUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 18:20:22 -0400
Received: by gxk23 with SMTP id 23so2670078gxk.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Jul 2010 15:20:21 -0700 (PDT)
In-Reply-To: <4C3252FF.3040501@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 07/05/2010 05:47 PM, Mark Lord wrote:
> On 05/07/10 02:33 PM, Jeff Garzik wrote:
>> On 07/05/2010 10:25 AM, Mark Lord wrote:
>>> Enable use of hyphenated pattern ranges in glob_match(), similar to how
>>> shell globbing works, and how developers might expect things to work.
>>>
>>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>> ---
>>>
>>> Patch also attached, to get around ongoing mailer issues here.
>>> Eventually, glob_match() will move out of libata into lib/string.c or
>>> similar.
>>
>> No issue with correctness... but where is the demonstrated need?
>>
>> Did someone ask for this?
> ..
>
> Not specifically. But since this will eventually end up as a kernel-wide
> library function, somebody somewhere will eventually make the reasonable
> assumption that it does globbing "in the usual way".
>
> Adding the hyphenated ranges turned out to be almost trivial,
> so I added it on and posted the patch.
>
> I could also send you follow-on patches to use that feature
> in the ata blacklists, if you like, saving a few more bytes hither and
> dither. :)

I understand the logic, but typically lean towards rejecting this sort 
of patch due to "mission creep."  It's always easy to make code do One 
More Thing, but without any actual users, there is little justification.

In this case, if you send a follow-on patch to _use_ this, I would be 
happy to apply both glob_match() and blacklist patches at that point.


> Speaking of this stuff.. how do we go about moving this function to
> /lib/strings.c ?
> Can that be done via your git tree?

Technically, yes, git can easily do that.

Two comments come to mind, though:

1) ditto on mission creep.  lib/string.c is a burden carried by -all- 
Linux platforms unconditionally, whereas loading libata.ko depends on 
several conditions.  I wouldn't advise moving it until additional usage 
justifies burdening all platforms -- including non-SATA tiny embedded 
platforms -- with glob_match() implementation.

It's becoming a real problem with lib/ in general, unfortunately.  If 
two minor sections of the kernel (or two minor, wholly unrelated 
drivers) need some common code, it gets dumped into lib/ with the 
associated costs forced upon all.

2) once other kernel users appear, submit the "move to lib/string" patch 
as a distinct patch in the series of patches to driver XYZ adding a 
glob_match() caller.  I'll happily add an Acked-by on your patch, and it 
can be submitted either direct to Linus/Andrew, or via the specific 
subsystem tree that is adding a new glob_match() caller.

I prefer the Acked-by route for patches that are only tangentially 
related to libata.

	Jeff



