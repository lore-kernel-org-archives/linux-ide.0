From: Tharindu Rukshan Bamunuarachchi <btharindu@gmail.com>
Subject: qc timeout ... failed to IDENTIFY - qemu/kvm setup
Date: Mon, 9 Aug 2010 18:55:04 +0100
Message-ID: <AANLkTikAAAGg-OO81my14YAkQP-wK86rmXVhAiqAWf1i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59075 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0HIRzi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Aug 2010 13:55:38 -0400
Received: by qyk7 with SMTP id 7so6622528qyk.19
        for <linux-ide@vger.kernel.org>; Mon, 09 Aug 2010 10:55:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

hi All,

I am getting following message when I try to start my qemu/kvm virtual =
machine.
I have been using qemu/kvm setup for last couple of months, issue was
introduced after upgrading to v2.6.35-rc6.

VM starts as usual when I disable SMP. Issue is not visible in v2.6.34x=
=2E

[=A0=A0=A0 6.052229] ata1.01: qc timeout (cmd 0xec)
[=A0=A0=A0 6.054105] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
[=A0=A0=A0 6.056653] ata2.01: qc timeout (cmd 0xec)
[=A0=A0=A0 6.058453] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
[=A0=A0 16.212186] ata1.01: qc timeout (cmd 0xec)
[=A0=A0 16.214056] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)
[=A0=A0 16.220146] ata2.01: qc timeout (cmd 0xec)
[=A0=A0 16.221986] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)
[=A0=A0 46.376202] ata1.01: qc timeout (cmd 0xec)
[=A0=A0 46.378164] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)
[=A0=A0 46.384165] ata2.01: qc timeout (cmd 0xec)
[=A0=A0 46.386140] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)

I think following CONFIGs are introduced with latest version ... could
there be any relation to above error ..

CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy


Please provide any clue or debug method to resolve the issue ?
Could this be an issue with kvm/qemu ?

Sorry if i am addressing wrong mailing-list.

cheers
tharindu
