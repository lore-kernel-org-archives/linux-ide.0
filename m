From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: ide-tape.c sparse annotations and unaligned access removal
Date: Mon, 21 Jul 2008 20:40:54 +0200
Message-ID: <200807212040.54975.bzolnier@gmail.com>
References: <1216152845.6610.18.camel@brick> <200807161943.54033.bzolnier@gmail.com> <1216236538.28841.12.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:32676 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYGUTJc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 15:09:32 -0400
Received: by ug-out-1314.google.com with SMTP id h2so296843ugf.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jul 2008 12:09:31 -0700 (PDT)
In-Reply-To: <1216236538.28841.12.camel@brick>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>

On Wednesday 16 July 2008, Harvey Harrison wrote:
> On Wed, 2008-07-16 at 19:43 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 15 July 2008, Harvey Harrison wrote:
> > > If this is actually unaligned the access of speed/max_speed above
> > > is already broken and needs a get_unaligned.  Otherwise it is
> > > aligned and they can be removed.
> > > 
> > > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > > ---
> > > Bart, if this truly should be unaligned, let me know and I'll send you
> > > a patch fixing the speed/maxspeed issue.
> > 
> > I applied the patch as it is for now as I don't see a reason to
> > use unaligned access there but I could have forgotten some details
> > (added Borislav to cc:).
> > 
> > I've also noticed that there are some put_unaligned()-s left in
> > idetape_get_mode_sense_results(), is this intended?
> 
> I just fixed the immediate ones I saw right below the aligned access to 
> speed/max_speed.  I can't be sure about tape->caps being aligned or not,
> but at least the following incremental patch is ok if caps is 2-byte
> aligned.  Feel free to fold it into my original or put my signed-off by on
> a new commit.

Thanks, I folded it into original patch.
