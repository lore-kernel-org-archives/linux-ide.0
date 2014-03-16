From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: ahci_platform broken build
Date: Sun, 16 Mar 2014 15:13:55 +0100
Message-ID: <5325B1A3.9070102@redhat.com>
References: <5325AFB2.4050505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35493 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbaCPOOC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Mar 2014 10:14:02 -0400
In-Reply-To: <5325AFB2.4050505@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Gardner <tim.gardner@canonical.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dann frazier <dann.frazier@canonical.com>

Hi,

On 03/16/2014 03:05 PM, Tim Gardner wrote:
> Gents  - while reviewing some patches for arm64 in Ubuntu I noticed t=
hat there is at least one patch sequence in linux-next that breaks the =
build.
>=20
> 156c5887948cd191417f18026aab9ce26e5a95da ahci-platform: Add support f=
or devices with more then 1 clock
> 039ece38da45f5e6a94be3aa7611cf3634bc2461 libahci: Allow drivers to ov=
erride start_engine
>=20
> For example:
>=20
> git reset --hard 156c5887948cd191417f18026aab9ce26e5a95da
> echo "CONFIG_SATA_AHCI_PLATFORM=3Dy" >> .config
> make oldconfig scripts prepare
> make M=3Ddrivers/ata
>=20
>   WARNING: Symbol version dump /home/rtg/linux/linux-next/Module.symv=
ers
>            is missing; modules will have no dependencies and modversi=
ons.
>=20
>   CC      drivers/ata/libata-core.o
>   CC      drivers/ata/libata-scsi.o
>   CC      drivers/ata/libata-eh.o
>   CC      drivers/ata/libata-transport.o
>   CC      drivers/ata/libata-sff.o
>   CC      drivers/ata/libata-pmp.o
>   CC      drivers/ata/libata-acpi.o
>   LD      drivers/ata/libata.o
>   CC      drivers/ata/ahci.o
>   CC      drivers/ata/libahci.o
>   CC      drivers/ata/ahci_platform.o
> drivers/ata/ahci_platform.c: In function =91ahci_probe=92:
> drivers/ata/ahci_platform.c:209:2: error: implicit declaration of fun=
ction =91ahci_enable_clks=92 [-Werror=3Dimplicit-function-declaration]
> drivers/ata/ahci_platform.c:293:2: error: implicit declaration of fun=
ction =91ahci_disable_clks=92 [-Werror=3Dimplicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [drivers/ata/ahci_platform.o] Error 1
> make: *** [_module_drivers/ata] Error 2
>=20
> The compile problem is then fixed in 96a01ba52c60fdd74dd6e8cf06645d06=
515b1396 (ahci-platform: Add enable_ / disable_resources helper functio=
ns) which is not really kosher.

Ah good catch, at some point I decided to prefix all the ahci_* functio=
ns defined in ahci_platform.c
with ahci_platform_ instead of just ahci_. Somehow the functions got ad=
ded with their new names
directly in the "ahci-platform: Add support for devices with more then =
1 clock" patch (this is
intentional), but the calls added in that patch kept using the old name=
s. Then in the
"ahci-platform: Add enable_ / disable_resources helper functions" patch
the calls get moved to another place and now show up with the proper ah=
ci_platform_*
names. My bad.

Tejun it is probably easiest if you fix this up directly in your tree, =
let me know if you
want a fixed up resend of the 2 patches in question instead.

Regards,

Hans
