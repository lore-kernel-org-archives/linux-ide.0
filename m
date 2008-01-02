From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: ide-floppy redux p1
Date: Wed, 2 Jan 2008 10:25:05 +0100
Message-ID: <20080102092505.GA16665@gollum.tnic>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp103.plus.mail.re1.yahoo.com ([69.147.102.66]:28465 "HELO
	smtp103.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753222AbYABJ1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 04:27:44 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

here's the unfinished redux of ide-floppy which i'm sending now so that=
 we could
sinchronize trees. There are some things left to be done which are not =
so
trivial and i'd like to give them a bit more thought :).


 drivers/ide/ide-floppy.c                         | 1248 +++++++-------=
--------
 drivers/ide/ide-floppy.h                         |  351 ++++++
 include/linux/cdrom.h                            |    1 +
 4 files changed, 819 insertions(+), 845 deletions(-)

--=20
Regards/Gru=DF,
    Boris.
