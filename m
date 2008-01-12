From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 00/21] ide-floppy redux v2
Date: Sat, 12 Jan 2008 21:51:02 +0100
Message-ID: <20080112205102.GB31954@gollum.tnic>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <200801121446.00276.bzolnier@gmail.com> <200801122114.40047.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:29245 "HELO
	smtp110.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751372AbYALUyb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:54:31 -0500
Content-Disposition: inline
In-Reply-To: <200801122114.40047.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jan 12, 2008 at 09:14:39PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
[...]

> PS1 Please rebase the patches still needing polishing on top of updat=
ed
> IDE quilt tree, recast them and respin the patch series (no need to p=
ost
> already merged patches).

sure, will do.

> PS2 what happend to "fix DMA error reporting" patch? (#13 is missing,=
 hmm?)

Yeah, this is strange. It seems git-send-email missed some of the patch=
es. I had
to send #16,#17 manually but didn't notice #13 was also missing. Will s=
end with
the next batch.

--=20
Regards/Gru=DF,
    Boris.
