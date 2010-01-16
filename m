From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
	Cougar Point DeviceIDs
Date: Fri, 15 Jan 2010 22:57:37 -0600
Message-ID: <51f3faa71001152057n66524711x316ac055d3043625@mail.gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
	 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
	 <51f3faa71001131611y343ad225n1acc73900fd49894@mail.gmail.com>
	 <51f3faa71001131642u2cc9de80n8e73be7a8707afb2@mail.gmail.com>
	 <20100114201136.GA3814@khazad-dum.debian.net>
	 <51f3faa71001141615k3223a02fhb0b882b6cbe680cf@mail.gmail.com>
	 <20100116030257.GG3814@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:54796 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab0APE5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2010 23:57:38 -0500
In-Reply-To: <20100116030257.GG3814@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 15, 2010 at 9:02 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Thu, 14 Jan 2010, Robert Hancock wrote:
>> > Maybe it is the silicon AHCI in ICH6R that is immature, and one is=
 much
>> > better of using it in IDE mode?
>>
>> That seems unlikely, since the Intel-provided Matrix Storage drivers
>> for that controller on Windows will be using AHCI mode..
>
> That doesn't say much.
>
> If the change doesn't risk switching unaware users from IDE mode to A=
HCI, it
> is not a problem. =A0But if it does, why risk it? =A0It is not like a=
nyone that
> wants hotplug and has an ICH6-R/M system won't have figured it out by=
 now
> how to get it to use AHCI, these are NOT new systems.
>
> AHCI in ICH6R or ICH6M is not always an advantage. =A0You don't want =
it on
> ICH6-M in a laptop if it is not going to use the hotplug, for example=
=2E =A0In
> AHCI mode, the chip draws more power.

Well, the ICH6M seems to be stuck in whatever mode the user and/or
BIOS designer has stuck it in,so nothing would change with it, only
with the ICH6R which is not a mobile chipset. I'm not sure about using
more power in the controller in AHCI mode, but in IDE mode, you can't
use SATA link power saving, which is likely just as significant.
