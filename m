From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: ide_cd modifies hard_* members of request
Date: Tue, 18 Mar 2008 12:22:02 +0100
Message-ID: <9ea470500803180422s491622d4i81f8e37796f44313@mail.gmail.com>
References: <1205830486.7126.16.camel@nikanth-laptop.blr.novell.com>
	 <9ea470500803180405h5ede15eaqa86515058a632e2b@mail.gmail.com>
	 <20080318110803.GV17940@kernel.dk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:41500 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYCRLWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 07:22:04 -0400
Received: by wf-out-1314.google.com with SMTP id 28so5921146wff.4
        for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2008 04:22:03 -0700 (PDT)
In-Reply-To: <20080318110803.GV17940@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Nikanth Karthikesan <knikanth@suse.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Mar 18, 2008 at 12:08 PM, Jens Axboe <jens.axboe@oracle.com> wr=
ote:
>
> On Tue, Mar 18 2008, Boris Petkov wrote:
>  > (sorry, forgot to cc all)
>  >
>  > On Tue, Mar 18, 2008 at 9:54 AM, Nikanth Karthikesan <knikanth@sus=
e.de> wrote:
>  > > Hi
>  > >
>  > >  Despite the warning in blkdev.h, that members of struct request=
 starting
>  > >  with hard_* are block layer internals, and no driver should tou=
ch them,
>  > >  the ide_cd driver seems to fiddle around with it.
>  > >
>  > >  Is this reqd, or can this be made to work without the need for =
this?
>  > >
>  > >  If this reqd, why not provide a helper function for that in blo=
ck layer
>  > >  itself, may be, with a warning about usage?
>  > >
>  > >  Thanks
>  > >  Nikanth Karthikesan
>  >
>  > Hi,
>  >
>  > the code pieces you're referring to are in there since at least th=
e
>  > first git import of the kernel source (i.e. 2005) aka long time so
>  > Bart/Jens should know that...
>
>  restore_request(), I'm assuming. It was probably me who modified thi=
s
>  code, I don't think there's any justification for it. I would sugges=
t
>  killing it.

I'll conjure up something later wrt above.

> And cdrom_read_from_buffer() as well, it's a silly addition.

This one is already gone, however the patch is still in Bart's tree
for -mm testing:
ftp://ftp.fi.kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/i=
de-cd-remove-the-internal-64k-buffer.patch

>
>  --
>  Jens Axboe
>
>



--=20
Regards/Gru=DF,
Boris
