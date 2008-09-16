From: Tejun Heo <tj@kernel.org>
Subject: Re: XFS shutting down due to IO timeout on SATA disk (pata_via for
 CX700)
Date: Tue, 16 Sep 2008 10:35:13 -0700
Message-ID: <48CFEE51.2070200@kernel.org>
References: <20080911193511.7960bc82@neptune.home>	<48CE22E5.9090403@kernel.org>	<20080915190242.58d21a8f@neptune.home>	<48CEC8F2.4040904@kernel.org> <20080916102152.3f35439f@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40312 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbYIPRhQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 13:37:16 -0400
In-Reply-To: <20080916102152.3f35439f@pluto.restena.lu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>

Hello,

Bruno Pr=E9mont wrote:
> I don't have other drives of the same model, but 3 ones slightly smal=
ler
> in size and previous generation, those are just a few months older (b=
ut
> also have way more uptime), see below for the smartctl output. I've n=
ever
> seen ATA errors on them.
> These other drives are running on AMD based platform, SB600 SATA with=
 AHCI.

So, smartctl output seems fine.

> Just for the record, on the VIA there were no errors yet with
> 2.6.27-rc6-git3 though I ran some compiling on it. As such it *could*=
 be
> that one of the patches pushed by Jeff helped:
>   [libata] LBA28/LBA48 off-by-one bug in ata.h
>   sata_inic162x: enable LED blinking
>   ata: duplicate variable sparse warning

The only patch which could have affected the result is the off-by-one
one; however, FLUSH timeout is a bit unexpected failure mode for the
problem.  Can you please keep the system running for a whlie and see
whether the problem occurs?

Thanks.

--=20
tejun
