From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/16] Generic ide device flags
Date: Sun, 29 Jun 2008 12:59:03 +0200
Message-ID: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:56595 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbYF2K7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564624fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:10 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

here's another series of generic ide tweaks. The biggest change in here=
 is the
introduction of ide_drive_t->dev_flags member which replaces all flags =
members
in the drivers structs. As a result, some PC_FLAGs become useless and g=
ot
removed, details in the respective patch descriptions below. The change=
s have
been tested with the hardware i have (i.e., ide-cd and ide-floppy).


 drivers/ide/ide-atapi.c    |   26 ++++++---
 drivers/ide/ide-cd.c       |  108 ++++++++++++++++++++----------------=
-----
 drivers/ide/ide-cd.h       |   38 --------------
 drivers/ide/ide-cd_ioctl.c |   27 +++++------
 drivers/ide/ide-floppy.c   |   81 ++++++++++++------------------
 drivers/ide/ide-tape.c     |  116 ++++++++++++++++++------------------=
-------
 drivers/scsi/ide-scsi.c    |   24 ++-------
 include/linux/ide.h        |   64 +++++++++++++++++++++++--
 8 files changed, 229 insertions(+), 255 deletions(-)


--=20
Regards/Gru=C3=9F,
Boris.
