From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-{cd,floppy}: do not map all cmds to an sg
Date: Thu, 5 Mar 2009 18:58:40 +0100
Message-ID: <9ea470500903050958v5d2219d0ha98fb35ae65fb75d@mail.gmail.com>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com>
	 <200903051549.22518.bzolnier@gmail.com>
	 <9ea470500903050719m7952f84ct56475c6445846eeb@mail.gmail.com>
	 <200903051752.41611.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:41582 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbZCER6n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 12:58:43 -0500
In-Reply-To: <200903051752.41611.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 5, 2009 at 5:52 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Thursday 05 March 2009, Borislav Petkov wrote:
>> Hi,
>>
>> > Unrelated to the original issue that the patch tries to fix
>> > (sg mapping no data commands which OOPS-es w/ DEBUG_VIRTUAL=y):
>> > - moving ide_init_sg_cmd()+ide_map_sg() to ide_issue_pc()
>> > - converting the code to use blk_rq_bytes()
>>
>> aah, ok, now I could get exactly what you meant :). However, (!) ide-floppy is
>> potentially broken in the same way for data-less cmds since we unconditionally
>
> Indeed, you are right but it seems that this is not a new problem.

Sure, as I said before, nobody's using ide-floppy.

> Wait... it makes things "worse" as there should have been 3 patches:
> (IOW _three_ patchpoints! ;):
>
> - ide-cd fix for problematic patch
> - ide-floppy fix for mainline
> - ide-atapi cleanup for pata tree

Yeah, I get the hint. :).

-- 
Regards/Gruss,
Boris
