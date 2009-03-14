From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 0/2 v2] libata: use ata.h mode mask defines everywhere
Date: Sat, 14 Mar 2009 21:34:53 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142131010.65817@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:55422 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbZCNUe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 16:34:56 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiaZJ-000HCp-Fp
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 21:34:53 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch series converts all drivers/ata/ drivers to use ATA_PIOx /=20
ATA_MWDMAx / ATA_UDMAx defines for transfer masks, uncovering a few=20
possible bugs in the process. Nothing important.

This series makes no functional changes, only converts hex codes to the=
ir=20
corresponding defines.

v2:
 - squashed into two patches
 - left an ascii table in pata_at32 alone

Erik Inge Bols=C3=B8 (2):
  ide/ata: add some more transfer masks to ata.h
  libata: convert drivers to use ata.h mode mask defines

