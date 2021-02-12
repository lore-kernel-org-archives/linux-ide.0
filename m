Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA56C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Feb 2021 23:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E114164DCF
	for <linux-ide@archiver.kernel.org>; Fri, 12 Feb 2021 23:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLXuE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Feb 2021 18:50:04 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:34795 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhBLXt6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Feb 2021 18:49:58 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 18:49:58 EST
Date:   Fri, 12 Feb 2021 23:48:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613173746;
        bh=xPC8UrRyti2IMA9U1flH548K5U4UMKRDSdMR8cguVeU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=KczTCVSWum4/LASwnvHYmLhnM0DdfZ6yElJki29nGqlf+PYcAsjfk8Cq/igEvMUcr
         Xg3VJtRtnpOKLWO4/Jr40KV3BNnpN0E0eHm7dKRgH0IgXaf8oHQwnk7OMJNdYFZFKV
         Hj7wWta6Kj00osPwGYXTT+MLECBpbnWB8ZQovPk4=
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   Joe Tienock <JoeTienock@protonmail.com>
Reply-To: Joe Tienock <JoeTienock@protonmail.com>
Subject: Lower SSD-performance in 4.10 than in 4.9 kernel
Message-ID: <BbfdEUMvJf0RuP-kIWT8k4p1F9q1ZyFsmlmSgl4OJNTpDOCkbFJDU5wu8pzXRjEweu4oALYN7viS3fD1okrsD1mzuTU6_MHIYghPNDMjvMY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear maintainers:

Let me please at first thank you for your work! I've been a linux enthusias=
t since about 1995 and this is the first time I have to report a possible b=
ug to the kernel team. I'll keep it short to hopefully not cost you much ti=
me, and wait for further instructions.

Problem: SSD performance on same system changes drastically from using kern=
el 4.9.255 and older to using kernel 4.10.0-rc1 and newer, according to hdp=
arm:

`linux@linux`:~$ uname -r
4.9.255-0409255-generic
`linux@linux`:~$ hdparm -Ttv /dev/sda
[...]
Timing buffered disk reads: 1432 MB in=C2=A0 3.00 seconds =3D 476.88 MB/sec

`linux@linux:`~$ uname -r
4.10.0-041000rc1-generic
`linux@linux`:~$ hdparm -Ttv /dev/sda
[...]
Timing buffered disk reads: 1140 MB in=C2=A0 3.00 seconds =3D 379.78 MB/sec

`linux@linux`:~$ uname -r
5.10.12
`linux@linux`:~$ sudo hdparm -Ttv /dev/sda
[...]
Timing buffered disk reads: 1138 MB in=C2=A0 3.01 seconds =3D 378.64 MB/sec

`linux@linux:~$ lspci -nnk``SATA controller [0106]: Intel Corporation 6 Ser=
ies/C200 Series Chipset Family 6 port Mobile SATA AHCI Controller [8086:1c0=
3] (rev 04)`
`Subsystem: Lenovo ThinkPad T520 [17aa:21cf]`
`Kernel driver in use: ahci`
`Kernel modules: ahci`

`linux@linux:~$` smartctl -d ata -x /dev/sda

Model Family:=C2=A0=C2=A0=C2=A0=C2=A0 Crucial/Micron BX/MX1/2/3/500, M5/600=
, 1100 SSDs
Device Model:=C2=A0=C2=A0=C2=A0=C2=A0 Crucial_CT525MX300SSD1
Firmware Version: M0CR070
User Capacity:=C2=A0=C2=A0=C2=A0 525.112.713.216 bytes [525 GB]
ATA Version is:=C2=A0=C2=A0 ACS-3 T13/2161-D revision 5
SATA Version is:=C2=A0 SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)

Any help would be highly appreciated!
Thanks in advance,
Joe
