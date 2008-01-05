From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [RESEND PATCH 02/10] ide-floppy: move ide-floppy struct and
	macro defs into its own header. While at it
Date: Sat, 5 Jan 2008 13:45:01 +0100
Message-ID: <20080105124501.GA5704@gollum.tnic>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-2-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-3-git-send-email-bbpetkov@yahoo.de> <200801042349.09964.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.plus.mail.re1.yahoo.com ([69.147.102.64]:34821 "HELO
	smtp101.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754188AbYAEMr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 07:47:57 -0500
Content-Disposition: inline
In-Reply-To: <200801042349.09964.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 04, 2008 at 11:49:09PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
Hi Bart,

> Hmm, contrary to ide-cd.c case there doesn't seem to be a need curren=
tly for
> moving code out of ide-floppy.c (and this patch series doesn't change=
 that).
?, you mean this patch series _does_ change that, meaning it moves the =
struct
defs into a header file. Do i get this correctly that we don't need the=
 header
file and the struct defs should remain in the .c file?

> Besides it would be better to just remove some structs like it has be=
en done
> with i.e. struct atapi_capabilities_page in ide-cd.c case [1] because=
:

[...]

> typedefs are evil (exceptions are rare) and should die :)
>=20

i'm redoing them right now against ide-2.6.git and will post when ready=
=2E By the
way, i have done some more cleanups in the meantime. Should i include t=
hem into
this series or send them later?

--=20
Regards/Gru=DF,
    Boris.
