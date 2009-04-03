From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 2/3] ide-cd: cleanup cdrom_decode_status
Date: Fri, 3 Apr 2009 16:03:08 +0200
Message-ID: <9ea470500904030703k9285e0eye5487f825df77e6@mail.gmail.com>
References: <1238655519-10074-2-git-send-email-petkovbb@gmail.com>
	 <200904030108.39927.bzolnier@gmail.com>
	 <20090403045803.GA3732@liondog.tnic>
	 <200904031241.44597.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:48239 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZDCODM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 10:03:12 -0400
In-Reply-To: <200904031241.44597.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Apr 3, 2009 at 12:41 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Friday 03 April 2009, Borislav Petkov wrote:
>> Hi,
>>
>> On Fri, Apr 03, 2009 at 01:08:39AM +0200, Bartlomiej Zolnierkiewicz wrote:
>> > On Thursday 02 April 2009, Borislav Petkov wrote:
>> > > - have (almost) equal handling of commands based solely on sense_key
>> >
>> > I'm having a VERY hard time trying to review this patch because at
>> > the same time that codepaths were merged if()s were replaced by switch()
>> > which in turn resulted in change of intendation... on top of that
>> > the patch description is very vague about this part of the changes...
>>
>> I completely and exactly understand what you are saying :), I thought so
>> too when I looked at the diffs yesterday. Well, if it's any consolation, the
>> patches've been tested so they seem to work :). Anyway, split version coming
>> up...
>
> The split version looks exactly the same except ide_cd_breathe() change
> when it comes to the main part.
>
> Did you send the wrong version by any chance?

No, but I can't split those changes anymore logically. The switch-case handles
the differentiation based on the sense_key and as such cannot be broken down
anymore without doing some weird stuff and possibly introducing more bugs and
breaking bisectability. Completely hypothetically: wouldn't a before-after
juxtaposition of the change make reviewing more easier, for example you
apply the patch on a different branch and compare the before and the after
version?

-- 
Regards/Gruss,
Boris
