From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED (resolved)
Date: Mon, 2 Aug 2010 12:23:03 -0600
Message-ID: <AANLkTi=YDuEYt4BK4T4bJH3cY5GujC-tCV4D-ORcbDVT@mail.gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
	<4C3D134B.2090604@gmail.com>
	<Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211433360.24693@envy.nxs.se>
	<4C531A40.6080804@gmail.com>
	<Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
	<AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
	<Pine.LNX.4.61.1008020720250.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55240 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0HBSXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2010 14:23:04 -0400
Received: by ywh1 with SMTP id 1so1331055ywh.19
        for <linux-ide@vger.kernel.org>; Mon, 02 Aug 2010 11:23:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.1008020720250.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

On Mon, Aug 2, 2010 at 1:21 AM, Tomas Lund <tlund@nxs.se> wrote:
> On Sun, 1 Aug 2010, Robert Hancock wrote:
>
>> The output above shows that the drive has security enabled and locke=
d, so
>> it seems that must be the case, and it won't be accessible unless it=
's
>> unlocked. hdparm should be able to disable it, though it seems you m=
ay need
>> a valid password to do it..
>
> There is something I did not mention in any of my earlier posts, and =
that is
> the fact that the server also has had a 3ware controller installed (r=
emoved
> as part of fault isolation) and some of the disks has been attached t=
o that
> controller. In the case of the samsung 1tb disk, it was attached to t=
he
> 3ware conroller after it was successfully tested on the motherboard
> sata-controller.
>
> Some googling and testing found that yes, the 3ware controller does i=
ndeed
> lock the drives, even if they are just automatically exported as "JBO=
D".
>
> The following command successfully unlocked my devices:
>
> hdparm --user-master u --security-disable "3wareUserPassword =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 "
> /dev/sdb
>
> I have unlocked and tested a total of 4 disks now, both the samsung 1=
TB and
> 3 of the WDC 2TB disks. Thank you very much! Left to do: test that
> everything is working with the PMP aswell.

Good to hear.

> Question: Would it be unreasonable to request that the kernel would i=
ssue
> the apropriate ATA-commands to a disk as soon as it is detected, and =
not try
> to read from it if it is locked? It would have been really, really ni=
ce to
> just get the error message "drive is locked".

It should be possible to indicate that, yes. I'll look into it when I
get a chance, if someone doesn't beat me to it..
