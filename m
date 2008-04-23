From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/11] removing the on-stack struct request
Date: Wed, 23 Apr 2008 09:40:11 +0200
Message-ID: <20080423074010.GA8221@gollum.tnic>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:31334 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYDWHj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 03:39:57 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3629118fkr.5
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 00:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

On Tue, Apr 22, 2008 at 11:14:28AM +0200, Bartlomiej Zolnierkiewicz wro=
te:

[..]

> Looks promising but probably I'll not be able to review it properly
> this week (I'm busy with my real job) and the next week (I'll be busy
> with pushing overdue IDE updates).  OTOH I'm hoping that Borislav
> would be able to take a look in the meantime.

Yep, they're quite straight-forward and look fine except some nitpickin=
g i sent
in separate mails. FWIW, this is what we wanted to do initially but Jen=
s didn't
agree to that at the time. I guess, it's because i probably didn't expr=
ess
myself clearly enough then. See http://kerneltrap.org/mailarchive/linux=
-kernel/2008/3/1/1037974
for the whole discussion.

--=20
Regards/Gru=DF,
    Boris.
