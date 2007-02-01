From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 10:18:49 +0100
Message-ID: <45C1B079.3080704@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:56557 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030520AbXBAJSz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 04:18:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx1.imc-berlin.de (Postfix) with ESMTP id 83D5C144C5
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2007 10:16:41 +0100 (CET)
Received: from mx1.imc-berlin.de ([127.0.0.1])
	by localhost (mx1.imc-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IeBCnmIZ5Tji for <linux-ide@vger.kernel.org>;
	Thu,  1 Feb 2007 10:16:41 +0100 (CET)
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mx1.imc-berlin.de (Postfix) with ESMTP id 6B524A243
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2007 10:16:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id A437A10AD1
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2007 10:18:50 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id B7281A070
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2007 10:18:49 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I am seeing kernel messages like

[ 1284.480000] hda: status timeout: status=0xd0 { Busy }
[ 1284.480000] ide: failed opcode was: unknown
[ 1284.480000] hda: no DRQ after issuing MULTWRITE_EXT
[ 1284.490000] ide0: unexpected interrupt, status=0x80, count=1
[ 1284.830000] ide0: reset: success

with a 2.5" Seagate ST940813AM on my embedded ARM system (linux 2.6.14, no
IDE controller. HDD registers just memory mapped).

HDD is used in PIO4 with MultSect=16.

What exactly does that mean? Only that the HDD is to slow to answer this
request with 100ms (WAIT_DRQ=(HZ/10))?

And will the request issued again after the reset of the drive?

Some old posting mentions that disabling "multi sector write" would help.
But I did not find any references to why this would solve the problem.
Is it a bug of this special HDD? Or a kernel problem?

Thanks a million!

Steven
