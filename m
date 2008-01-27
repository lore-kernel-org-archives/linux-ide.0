From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 0/32] ide-tape redux v1
Date: Sun, 27 Jan 2008 09:41:20 +0100
Message-ID: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re1.yahoo.com ([69.147.102.67]:23884 "HELO
	smtp104.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755497AbYA0Ima (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 03:42:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Hi Bart,

after a lot of hammering ide-tape got pimped pretty considerably (ca. 6=
00 lines
shorter and slicker :)). I'm sure there's more to be done like, e.g. re=
placing
the BKL in idetape_write_release() with finer-grained locking etc, prob=
ably also
some pipeline improvements, removal of OnStream support, etc. but that'=
ll come
later.

 Documentation/ide/ChangeLog.ide-tape.1995-2002 |  405 +++
 drivers/ide/Kconfig                            |    3 +-
 drivers/ide/ide-tape.c                         | 4146 +++++++++-------=
--------
 3 files changed, 1991 insertions(+), 2563 deletions(-)

--=20
Regards/Gru=DF,
   Boris.
