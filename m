From: Phill Jolliffe <phill.jolliffe@gmail.com>
Subject: Re: PMP 3726 problem?
Date: Thu, 30 Dec 2010 21:40:40 +0000
Message-ID: <AANLkTik+U4eh3bqx5oJ0wxU8+sJogGV+-tPzMTycSPTd@mail.gmail.com>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com> <4D1BDB10.803@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59599 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0L3VlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2010 16:41:12 -0500
Received: by wwi17 with SMTP id 17so11687133wwi.1
        for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2010 13:41:10 -0800 (PST)
In-Reply-To: <4D1BDB10.803@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

> 1. =A0Have you tried the PCIe x1 eSATA card that came bundled with yo=
ur
> unit? =A0Does it work properly using that card?

Switched from the mobo's built in esata port to bundled card. All 4
sata drives are detected without fault on each of 5 trial reboots.

[root@JollyBox ~]# dmesg | grep  -i sil
sata_sil24 0000:01:00.0: version 1.1
scsi6 : sata_sil24
scsi7 : sata_sil24

Here is the lspci from the bundled card.

http://pastebin.com/1TuM99Q4

I had avoided using the bundled card and used the mobo builtin esata +
md sw raid as I need the single PCIe slot on my mobo for a graphics
card.

> 1. =A0Have you tried more than 1 eSATA cable?

Sorry, should of mentioned I already tried a new cable before.

> 3. =A0Do you have any equipment of any kind, that generates EMI or RF=
I, in

Nothing out of the norm but re juggled everything on the desk to
maximise the esata cables distance from even the power strip for the
PC.  Only electric items within a meter are the disk enclosure and PC
itself.
