From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/24] ide-tape: remove pipelined mode operation
Date: Sat, 1 Mar 2008 16:45:29 +0100
Message-ID: <20080301154529.GB30547@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <20080301095518.GW6704@kernel.dk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:58986 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbYCAPph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 10:45:37 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2720736nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 07:45:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080301095518.GW6704@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 01, 2008 at 10:55:18AM +0100, Jens Axboe wrote:
> On Sat, Mar 01 2008, Borislav Petkov wrote:
> > Hi Bart,
> >=20
> > here's the 1st draft of the pipeline removal series. As the diffsta=
t below openly
> > states it, a lot of code got removed - even more than the cleanup s=
eries we did
> > earlier. There are several issues that we need to address concernin=
g these
> > patches:
> >=20
> > 1. only compile-tested since i don't have the hardware, i.e. longer=
 -mm brewing is
> > advisable the least.
> >=20
> > 2. I have left the tape->merge_stage buffer structure along with it=
s
> > alloc/free functions intact for now, for simplicity. The next step =
would be
> > to go and carefully audit the code and then remove that last piece
> > too and use allocations on the stack instead. I guess we still expe=
ct
> > Jens's response on whether blk_{get,put}_request is the way to go h=
ere.
> >=20
> > Jens?
>=20
> Hm, I have not seen any questions regarding this directed my way :-)
> Please point me to the original question and I'll take a look at it.

Hi Jens,

sorry but maybe we weren't that explicit, here's a pointer to the relev=
ant
thread: http://www.mail-archive.com/linux-ide@vger.kernel.org/msg15541.=
html. It
boils down to removing the statically allocated arrays of buffers for p=
c and rq
structs in ide-floppy and ide-tape, and using GFP_ATOMIC stack memory i=
nstead.
Bart's idea was to even go a step further and even avoid allocation err=
ors in
out-of-mem situations by reusing requests from the request queue but wa=
sn't sure
whether this'll fly and wanted to run it by you...

Thanks.

--=20
Regards/Gru=DF,
    Boris.
