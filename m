From: Raja Appuswamy <raja.btl@gmail.com>
Subject: question regarding ncq implementation
Date: Tue, 2 Aug 2011 20:45:42 +0200
Message-ID: <CAJbmVfeOWrdX1dDxYFwz5FK9yqYjRyVKfVBtNmQSXN17XP5E6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37679 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab1HBSpn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2011 14:45:43 -0400
Received: by qwk3 with SMTP id 3so42745qwk.19
        for <linux-ide@vger.kernel.org>; Tue, 02 Aug 2011 11:45:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey guys,
=A0 =A0Over the past few days i've been trying to work on modifying the
AHCI driver for an experimental research operating system to support
NCQ. I already have a fully functional AHCI driver without command
queuing. But when i try to =A0READ FPDMA QUEUED command instead of the
READ DMA command, i get an interrupt with the P0IS register containing
the mask 0x45000008 (TFES, OFS and SDBS bits set). On dumping the log
page, i get 41h=A0as status=A0(DRDY and ATA_ERR if i am right) =A0and 8=
4h as
feature/error.=A0The non-ncq driver works just fine without any issues
and there is absolutely no way the hardware is at fault this time. I
have checked out the linux code and a 84h error refers to the ICRC and
ATA_ABORTED bits if i am not mistaken. I would really appreciate any
help from devs regarding how to debug this issue further. Also, are
any of the other values i get back from REAL LOG EXT useful for
debugging? If so, how do i interpret them?=A0=A0I know this is not a li=
nux
related question. So if you think i should be targeting a different
mailing list, i'd really appreciate it if you could please point me in
the right direction and i'll definitely stop bugging you guys.
Thanks in advance,
Raj
