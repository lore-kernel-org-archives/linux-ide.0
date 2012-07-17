From: Yang Bai <hamo.by@gmail.com>
Subject: Re: How to map ata_link to physical link and ata_port to physical port
Date: Tue, 17 Jul 2012 09:59:35 +0800
Message-ID: <CAO_0yfPpxk521qBaXCKDabdYtACMYTAWe_zkF2bG8ELveHw58g@mail.gmail.com>
References: <CAO_0yfM_qmWd_dR7UH1Y6Rk6F5b9CTVduDKLmsLb8azrmL5NZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44821 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2GQB75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2012 21:59:57 -0400
In-Reply-To: <CAO_0yfM_qmWd_dR7UH1Y6Rk6F5b9CTVduDKLmsLb8azrmL5NZA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, gwendal@google.com, jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

CC-ed Gwendal and Jeff

Ping.

On Mon, Jul 16, 2012 at 11:09 AM, Yang Bai <hamo.by@gmail.com> wrote:
> Hi hackers,
>
> In our internal usage, we want to map the disk in system like
> sd{a,b,c} to physical disk slot. When the disk is attached to LSI HBA
> card, we find that we can rely on the phy attribute of the disk to
> find the slot since this attribute does not change no matter which
> kind of disks we attach or what order we attach the disks. But when
> doing this for AHCI, we do not find an attribute that we can rely on
> it to map the disk to slot. No matter ata_port number or ata_host
> number, when we changed the order we attached the disks to slots, the=
y
> changed.
>
> So I want to know is there some attribute we can get from AHCI that
> map the logical disk to physical slot?
>
> Thanks,
> Yang



--=20
    """
    Keep It Simple,Stupid.
    """

Chinese Name: =E7=99=BD=E6=9D=A8
Nick Name: Hamo
Homepage: http://hamobai.com/
GPG KEY ID: 0xA4691A33
Key fingerprint =3D 09D5 2D78 8E2B 0995 CF8E  4331 33C4 3D24 A469 1A33
