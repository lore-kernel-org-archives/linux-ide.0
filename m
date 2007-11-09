From: Riki Oktarianto <rkoktarianto@gmail.com>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Sat, 10 Nov 2007 05:38:02 +0700
Message-ID: <20071109223802.GA23004@ceren>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <4734736C.5060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:22641 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXKIWi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 17:38:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so582493rvb
        for <linux-ide@vger.kernel.org>; Fri, 09 Nov 2007 14:38:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4734736C.5060003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?B?VPZy9ms=?= Edwin <edwintorok@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Fri, Nov 09, 2007 at 04:49:16PM +0200, T=F6r=F6k Edwin wrote:
> There is one problem with force enabling ahci. You'll loose the CDROM=
 on
> Dell laptops.
> Prior to force-enabling ahci there is one "device" that sees the 2 sa=
ta
> channels, and the 2 ide channels.
> When you force-enable ahci, this device becomes the ahci controller (=
it
> changes the device id),
> and the IDE controller will appear as a separate new device (with
> another device id), but it is disabled.
>=20
> There are registers on the ICH7 that allows you to set enabled/disabl=
ed
> status, but according to the documentation you should not enable a
> device after it has been disabled. In practice I couldn't get the CDR=
OM
> to get re-enabled:
> * either nothing happend
> * spurious irqs were sent that nobody handles, unless I used irq=3Dpo=
ll;
> but still no cdrom.
>=20
> Force-enabling AHCI, and not trying to enable the CDROM works, althou=
gh
> I occasionally got NCQ errors.
>=20
> For a (long) discussion see this thread on the powertop mailing list:
> http://www.bughost.org/pipermail/power/2007-June/000533.html
> http://www.bughost.org/pipermail/power/2007-June/000573.html
>=20
> And there is also another slightly different approach:
> http://mjg59.livejournal.com/76062.html
>=20
> Best regards,
> --Edwin
>=20

In the MacBook, after enabling ahci the IDE controller also appeared as=
 a
separate new device, but it is enabled and handled correctly by piix.

I haven't got any problem, even suspend/resume works fine.

Lucky us who got the ABAR mapped by the BIOS...

--=20
Riki Oktarianto
