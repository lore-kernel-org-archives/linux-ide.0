From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 20:52:34 -0600
Message-ID: <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	 <4bbdde49.e302be0a.3106.0220@mx.google.com>
	 <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	 <4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	 <20100408150920.5689564b@lxorguk.ukuu.org.uk>
	 <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	 <4BBE6CA6.1010808@gmail.com>
	 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	 <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	 <4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:46530 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab0DICwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 22:52:35 -0400
Received: by iwn35 with SMTP id 35so1928761iwn.21
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 19:52:35 -0700 (PDT)
In-Reply-To: <4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, Apr 8, 2010 at 8:22 PM, D=E2niel Fraga <fragabr@gmail.com> wrot=
e:
> On Thu, 8 Apr 2010 20:09:29 -0600
> Robert Hancock <hancockrwd@gmail.com> wrote:
>
>> Think you meant sata_nv or something there, forcedeth is the network
>> driver :-) In that case that's not really legacy mode though, it's
>
> =A0 =A0 =A0 =A0Oh yeah, sorry for my confusion ;) sata_nv. ;)
>
>> some chipset-specific enhanced mode like SWNCQ or ADMA in the NVIDIA
>> case, or the newer Silicon Image controllers which support the fancy
>> features with an entirely different interface from AHCI. In the case
>> of Intel controllers, though, IDE mode is basically the same as a PA=
TA
>> controller with no real SATA-specific features (NCQ, 64-bit DMA,
>> hotplug, etc.)
>
> =A0 =A0 =A0 =A0Very interesting and thanks again for the excellent ex=
planation
> Robert!
>
> =A0 =A0 =A0 =A0Ps: I imagine how many people are running their server=
s or
> desktop computers using the legacy PIIX driver, just because the BIOS
> setting is wrong (IDE instead of AHCI). In my case I just ignored the
> "RAID mode" option because I don't ever use RAID.
>
> =A0 =A0 =A0 =A0Don't you think it would be nice to add a warning mess=
age
> when the kernel detects =A0AHCI capable system like ICH10 and the ker=
nel
> is misconfigured using the legacy PIIX driver? It could be
> something like that: "AHCI capable chipset: use ahci driver instead".

We can detect an AHCI-capable Intel chipsets (in most cases anyway),
but problem is that a lot of systems with such chipsets, especially
laptops, unfortunately have no way to actually put the controller into
AHCI mode (no BIOS option for it). We could whine about it, but in a
lot of cases there's not much that can be done about it..

Intel chipsets are pretty much the only ones that have the separate
modes in the BIOS for AHCI - others like NVIDIA AHCI-compliant
controllers support both legacy mode and AHCI in the same device,
which is a lot more convenient in some ways..
