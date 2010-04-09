From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 08:47:17 -0600
Message-ID: <z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	 <4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	 <20100408150920.5689564b@lxorguk.ukuu.org.uk>
	 <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	 <4BBE6CA6.1010808@gmail.com>
	 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	 <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	 <4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
	 <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
	 <4BBEFDA1.5050607@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:32890 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0DIOrR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 10:47:17 -0400
Received: by iwn35 with SMTP id 35so2276522iwn.21
        for <linux-ide@vger.kernel.org>; Fri, 09 Apr 2010 07:47:17 -0700 (PDT)
In-Reply-To: <4BBEFDA1.5050607@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Fri, Apr 9, 2010 at 4:12 AM, Tim Small <tim@buttersideup.com> wrote:
> Robert Hancock wrote:
>> We can detect an AHCI-capable Intel chipsets (in most cases anyway),
>> but problem is that a lot of systems with such chipsets, especially
>> laptops, unfortunately have no way to actually put the controller in=
to
>> AHCI mode (no BIOS option for it). We could whine about it, but in a
>> lot of cases there's not much that can be done about it..
>>
>
> I have a couple of machines with those BIOSes, and apart from the fac=
t
> that the Intel ICH datasheets say something like "none but the saintl=
y
> BIOS writers shall program this register", it does seem to be possibl=
e
> to put an ICH9R into AHCI mode using setpci and the fake hot plug dri=
ver...

In some cases it's likely doable - though you'd likely want to do it
as a PCI quirk, so that it gets detected as an AHCI device in the
first place rather than having to change it later.

>
> I just wondered what the potential pitfalls might be of doing this?
> Obviously you wouldn't want to be doing anything with the controller =
at
> the time that you change it's mode. =A0Is there also the risk of the
> bloody bios fiddling with the device after the OS has booted (and the=
n
> getting surprised about it no longer being in piix mode)?

Some laptop BIOSes do try to access the controller at certain points,
like suspend or powerdown (presumably to make sure the drive heads are
unloaded or something) - we've run into problems in the past when the
controller was disabled at points where the BIOS didn't expect it to
be and it was trying to poke at it, causing a big delay until it
finally gave up.

=46or reasons like that we likely couldn't do it in the general case. W=
e
could provide it as a disabled-by-default feature, where if someone
enables it and it breaks they get to keep both pieces..
