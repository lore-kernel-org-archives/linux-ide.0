From: Tejun Heo <htejun@gmail.com>
Subject: Re: Again... DMA speed too slow
Date: Sun, 13 Apr 2008 11:23:48 +0900
Message-ID: <48016EB4.1070804@gmail.com>
References: <20080330235357.20a54963@werewolf> <20080402001640.41c103a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:34319 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbYDMCYK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 22:24:10 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1391844waf.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 19:24:10 -0700 (PDT)
In-Reply-To: <20080402001640.41c103a7.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>, "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Sun, 30 Mar 2008 23:53:57 +0200 "J.A. Magall=F3n" <jamagallon@ono.=
com> wrote:
>=20
>> Hi all...
>>
>> I have tried to burn some data from the commandline with wodim (sinc=
e time
>> ago I just used beasero...), and I have noticed this (media is CD, n=
ot DVD):
>>
>> Vendor_info    : 'HL-DT-ST'
>> Identification : 'DVDRAM GSA-H10N '
>> Revision       : 'JL12'
>> Device seems to be: Generic mmc2 DVD-R/DVD-RW.
>> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
>> Driver flags   : MMC-3 SWABAUDIO BURNFREE
>> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P R=
AW/R96R
>> Speed set to 8467 KB/s
>> wodim: DMA speed too slow (OK for 5x). Cannot write at speed 48x.
>> Starting to write CD/DVD at speed  48.0 in real TAO mode for single =
session.
>>
>> I just can burn CDs at 5x ??
>> But then the program tries to write at 48x.
>> It the DMA message really true ?

Which controller are you on?  I bet the recording itself will work fine=
=20
on 48x.  It's probably that READ/WRITE BUFFERs are executed using PIO=20
for compatibility reasons.

--=20
tejun
