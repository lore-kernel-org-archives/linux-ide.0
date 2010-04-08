From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 08 Apr 2010 17:54:14 -0600
Message-ID: <4BBE6CA6.1010808@gmail.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>	<4bbdde49.e302be0a.3106.0220@mx.google.com>	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>	<20100408150920.5689564b@lxorguk.ukuu.org.uk> <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42421 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823Ab0DHXyS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 19:54:18 -0400
Received: by gyg13 with SMTP id 13so1469707gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 16:54:17 -0700 (PDT)
In-Reply-To: <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 04/08/2010 08:15 AM, D=E2niel Fraga wrote:
> On Thu, 8 Apr 2010 15:09:20 +0100
> Alan Cox<alan@lxorguk.ukuu.org.uk>  wrote:
>
>> Yes
>
> 	Ok, problem solved. You're right, the BIOS option was wrong.
> The problem is that it's called "RAID mode" and I found it not
> intuitive since I don't use RAID (so I didn't touch it). I changed it
> from IDE to AHCI and it worked.
>
> 	So just a quick and last question. I read here the following:
>
> http://forum-en.msi.com/index.php?topic=3D106575.120
>
> "AHCI is a native SATA Mode.  There is not necessarely a major
> performance difference between IDE/Legacy Mode and AHCI Mode".
>
> 	Of course this guy is talking about Windows, but can it be
> applied to Linux too? I mean, does AHCI offers no significant
> performance improvement over SFF/Legacy mode?

Depends on a lot of things, and what you mean by "significant". You=20
don't get NCQ in legacy mode, and you also don't get 64-bit DMA support=
,=20
which gets more significant the more RAM you have.
