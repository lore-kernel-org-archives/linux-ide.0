From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 23/32] ide-tape: struct idetape_tape_t: shorten member
	names
Date: Sun, 3 Feb 2008 12:36:17 +0100
Message-ID: <20080203113617.GB5268@gollum.tnic>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-18-git-send-email-petkovbb@gmail.com> <200802030043.23110.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:43141 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578AbYBCLhT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Feb 2008 06:37:19 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1551396fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 03 Feb 2008 03:37:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802030043.23110.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Feb 03, 2008 at 12:43:22AM +0100, Bartlomiej Zolnierkiewicz wro=
te:

Hi,

[...]

> Even if this patch contains only trivial changes, the amount of them
> and the fact that it intermixes different logical changes (shortening
> names, dead code removal and comments beautification) makes it someho=
w
> non-trivial to review.
>=20
> General comment:
> please have some mercy on the reviewer (in this case me ;) and spread
> the changes across more patches (it should also be easier for you sin=
ce
> with more patches it is more likely that the more changes get applied
> the first time and you will have less code to recast/resubmit).
>

sorry about that, i tend to forget myself sometimes when going over the=
 code and
wanting to fix all in one go. Concerning the shortening of the variable=
 names -
i wanted to make them as short as possible so that i have less lines > =
80 and
not have to break them and make them less readable. Will redo.

Thanks.

--=20
Regards/Gru=DF,
    Boris.
