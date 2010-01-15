From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
	Cougar Point DeviceIDs
Date: Thu, 14 Jan 2010 18:15:56 -0600
Message-ID: <51f3faa71001141615k3223a02fhb0b882b6cbe680cf@mail.gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
	 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
	 <51f3faa71001131611y343ad225n1acc73900fd49894@mail.gmail.com>
	 <51f3faa71001131642u2cc9de80n8e73be7a8707afb2@mail.gmail.com>
	 <20100114201136.GA3814@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:58176 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab0AOAP4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 19:15:56 -0500
In-Reply-To: <20100114201136.GA3814@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 14, 2010 at 2:11 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Wed, 13 Jan 2010, Robert Hancock wrote:
>> Hmm, it seems like it's a bit more complicated than that. For ICH6R
>> (0x2652), ata_piix attaches to it regardless of mode intentionally, it
>> has specific logic to disable AHCI on the controller since it can be
>> used in either mode. That seems a bit questionable. Having the same
>> device being handled by different enabled drivers and depending on
>> link or module load order to decide which one loads is fragile and
>> prone to errors. I'd be in favor of removing the ICH6R support from
>> ata_piix entirely and saying that you should be using ahci for that
>> device. Maybe when ahci was immature there was a benefit to allowing
>> ata_piix to run it, but I doubt that's true today.
>
> Maybe it is the silicon AHCI in ICH6R that is immature, and one is much
> better of using it in IDE mode?

That seems unlikely, since the Intel-provided Matrix Storage drivers
for that controller on Windows will be using AHCI mode..
