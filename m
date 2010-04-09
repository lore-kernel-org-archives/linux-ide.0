From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 09 Apr 2010 00:28:07 -0400
Message-ID: <4BBEACD7.30601@garzik.org>
References: <eo2197-4lb.ln1@tux.abusar.org.br> <20100408144525.2f3f5718@lxorguk.ukuu.org.uk> <4bbdde49.e302be0a.3106.0220@mx.google.com> <20100408145916.50dbe8de@lxorguk.ukuu.org.uk> <4bbde1ea.c701be0a.60ec.0270@mx.google.com> <20100408150920.5689564b@lxorguk.ukuu.org.uk> <4bbde4f7.1702be0a.5f6c.028e@mx.google.com> <4BBE6CA6.1010808@gmail.com> <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:38258 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab0DIE2K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 00:28:10 -0400
Received: by qyk9 with SMTP id 9so976237qyk.1
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 21:28:09 -0700 (PDT)
In-Reply-To: <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 04/08/2010 10:00 PM, D=E2niel Fraga wrote:
> On Thu, 08 Apr 2010 17:54:14 -0600
> Robert Hancock<hancockrwd@gmail.com>  wrote:
>
>> Depends on a lot of things, and what you mean by "significant". You
>> don't get NCQ in legacy mode, and you also don't get 64-bit DMA supp=
ort,
>> which gets more significant the more RAM you have.
>
> 	I understand Robert. Ok, by significant I mean "better" and
> "faster".
>
> 	So there's no NCQ in legacy mode? But you wrote that
> regarding just the ICH chipset or all chipsets? Because I remember wh=
en
> I used the forcedeth driver there was NCQ.

This has a reasonably comprehensive list:
http://ata.wiki.kernel.org/index.php/SATA_hardware_features

