From: Maciej Grela <maciej.grela@gmail.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Sat, 30 Apr 2011 10:10:47 +0200
Message-ID: <BANLkTi==R1tb-oNp4Sf5DJHS3wjZyC_wLg@mail.gmail.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
	<4DBAC18A.20407@teksavvy.com>
	<BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>
	<4DBB7341.1070600@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38364 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1D3IKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Apr 2011 04:10:48 -0400
Received: by vws1 with SMTP id 1so3258774vws.19
        for <linux-ide@vger.kernel.org>; Sat, 30 Apr 2011 01:10:47 -0700 (PDT)
In-Reply-To: <4DBB7341.1070600@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org

2011/4/30 Mark Lord <kernel@teksavvy.com>:
>
> Okay. =C2=A0Now please do exactly this (and I mean EXACTLY):
>
> 1. shut down and completely power off the system.
> 2. boot up again, and immediately do "hdparm --Istdout /dev/sdb
> and post the results here.
>
> I want to see what the default security state of the drive is,
> and that sequence above will tell all.
>

Hi,

Here is the data:

/dev/sdb:
045a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 5342 3032 3443
4747 4a4d 3542 4744 0003 3ab0 0004 5342
324f 4137 3548 4869 7461 6368 6920 4854
4535 3431 3638 304a 3941 5430 3020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0100 f8b0 0950 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fc 001a 746b 7fe9 4163 746b 3e49 4163
043f 0015 0000 40fe fffe 600b 80fe 0000
0000 0000 0000 0000 f8b0 0950 0000 0000
0000 0000 0000 8848 5000 cca5 50e4 e637
0000 0000 0000 0000 0000 0000 0000 4002
4000 0000 0000 0000 0000 0000 0000 0000
0007 000b 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 8000 0000
3258 0000 0000 3333 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 8000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 c5a5

Hope this clarifies the issue.

Br,
Maciej Grela
