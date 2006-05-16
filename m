From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-tj and SMART
Date: Tue, 16 May 2006 17:11:38 +0900
Message-ID: <4469893A.10901@gmail.com>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:23676 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751674AbWEPILo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 04:11:44 -0400
Received: by wx-out-0102.google.com with SMTP id t16so694574wxc
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 01:11:43 -0700 (PDT)
In-Reply-To: <e4bvsb$s9m$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org

Nicolas STRANSKY wrote:
> Le 05/16/2006 01:13 AM, Tejun Heo a =E9crit :
>=20
> Hi,
>=20
>>> I've been using libata-tj for a couple of days and for now it's wor=
king
>>> without problem, my SI-3112 is finally working :) Thanks !
>> How does it work w/o libata-tj?
>=20
> smartctl and smartd used to work fine. But I was using a different
> controler (Promise PDC20376).
>=20
>> Your drive/controller causes HSM violation probably while executing =
a
>> SMART command (maybe during PIO-in during READ DATA?, maybe we need =
to
>> dump feature, too).  Can you try 'smartctl -d ata -a /dev/sdx' and
>> report the result and how the kernel acts during that command?
>=20
> You can find attached the result of the smartctl. It went fine and th=
ere
> was no kernel message associated. But if I try to reproduce smartd
> command, then "smartctl -d ata -a -o on -S on /dev/sda" causes the sa=
me
> error I showed in the first post, and smartctl fails with this error:
> Error SMART Enable Auto-save failed: I/O error
> Smartctl: SMART Enable Attribute Autosave Failed.

Hmmm.. That measn SMART ENABLE/DISABLE ATTRIBUTE AUTOSAVE command fails=
=2E=20
  But weirdly it fails with DRQ (ready for data) bit set, thus=20
triggering HSM violation.  My guess is the drive doesn't support that=20
command and when it aborts, it sends funky status.  I think you can=20
safely ignore the error or remove -S on from smartd configuration.

If you've got some time though, I'd like to see what's really going on.=
=20
  Can you modify #undef ATA_DEBUT to #define ATA_DEBUG in=20
include/linux/libata.h and post the kernel messages after issuing above=
=20
command?  Be warned that it will produce a LOT of messages while bootin=
g=20
if you're using SATA disks for your system, and it can considerably slo=
w=20
down booting.

--=20
tejun
