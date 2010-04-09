From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 20:09:29 -0600
Message-ID: <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	 <20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	 <4bbdde49.e302be0a.3106.0220@mx.google.com>
	 <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	 <4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	 <20100408150920.5689564b@lxorguk.ukuu.org.uk>
	 <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	 <4BBE6CA6.1010808@gmail.com>
	 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:47561 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0DICJb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 22:09:31 -0400
Received: by gxk9 with SMTP id 9so1764113gxk.8
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 19:09:30 -0700 (PDT)
In-Reply-To: <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, Apr 8, 2010 at 8:00 PM, D=E2niel Fraga <fragabr@gmail.com> wrot=
e:
> On Thu, 08 Apr 2010 17:54:14 -0600
> Robert Hancock <hancockrwd@gmail.com> wrote:
>
>> Depends on a lot of things, and what you mean by "significant". You
>> don't get NCQ in legacy mode, and you also don't get 64-bit DMA supp=
ort,
>> which gets more significant the more RAM you have.
>
> =A0 =A0 =A0 =A0I understand Robert. Ok, by significant I mean "better=
" and
> "faster".
>
> =A0 =A0 =A0 =A0So there's no NCQ in legacy mode? But you wrote that
> regarding just the ICH chipset or all chipsets? Because I remember wh=
en
> I used the forcedeth driver there was NCQ.

Think you meant sata_nv or something there, forcedeth is the network
driver :-) In that case that's not really legacy mode though, it's
some chipset-specific enhanced mode like SWNCQ or ADMA in the NVIDIA
case, or the newer Silicon Image controllers which support the fancy
features with an entirely different interface from AHCI. In the case
of Intel controllers, though, IDE mode is basically the same as a PATA
controller with no real SATA-specific features (NCQ, 64-bit DMA,
hotplug, etc.)
