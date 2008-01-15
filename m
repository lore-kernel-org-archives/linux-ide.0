From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 8/12] ide-floppy: merge idefloppy_{input,output}_buffers
Date: Tue, 15 Jan 2008 08:14:34 +0100
Message-ID: <20080115071434.GB32009@gollum.tnic>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-9-git-send-email-bbpetkov@yahoo.de> <200801142238.35893.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:25549 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752469AbYAOHSR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 02:18:17 -0500
Content-Disposition: inline
In-Reply-To: <200801142238.35893.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 14, 2008 at 10:38:35PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 13 January 2008, Borislav Petkov wrote:
> > We merge idefloppy_{input,output}_buffers() into idefloppy_io_buffe=
rs() by
> > introducing a 4th arg. called direction. According to its value
> > we atapi_input_bytes() or atapi_output_bytes(). Also, this simplifi=
es the
> > interrupt handler logic a bit. Finally, rename idefloppy_io_buffers=
() to
> > ide_floppy_io_buffers().
> >=20
> > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
>=20
> This change depends on "ide-floppy: use an xfer_func_t and io_buf_t t=
ypedefs
> in order to unify rw" which was not in the "v2.5" series.

Yep, this is correct. Probably i should've mentioned that in the preamb=
le. It
is rather confusing, imho, when sending only a subset of the patches. R=
ather,
I should've sent the whole series after tagging the ones already applie=
d so
that you have an idea about their ordering. Will note that for the next=
 time.

> I took the patch #16/21 from the previous series and applied it manua=
lly
> fixing rejects, please verify that I didn't brake something in the pr=
ocess.

Will do the whole driver testing in the weekend. :)

--=20
Regards/Gru=DF,
    Boris.
