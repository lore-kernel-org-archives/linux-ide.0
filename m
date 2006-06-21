From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Wed, 21 Jun 2006 23:18:56 +0200
Message-ID: <e7cd40$lpk$1@sea.gmane.org>
References: <20060512132437.GB4219@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44514 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751153AbWFUVTO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2006 17:19:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtA6Q-0007PF-0T
	for linux-ide@vger.kernel.org; Wed, 21 Jun 2006 23:19:10 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 23:19:10 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 23:19:10 +0200
In-Reply-To: <20060512132437.GB4219@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Le 05/12/2006 03:24 PM, Tejun Heo a =E9crit :
> Hello, all.
>=20
> Lately libata has been going through a lot of changes and even more
> are around the corner.  I've been working on error handling and
> advanced SATA features for quite sometime now, and, finally, patches
> have been finalized and submitted for review a few days ago.
>=20
> 2.6.18 is the target for mainline merge.  As there is quite some time
> between now and 2.6.18, I have made patches to update the current
> stable kernel to support the new features so that they can receive
> wider testing and interested people don't have to wait too long.  I
> intend to maintain these patches through 2.6.16 and 17 until the
> mainline merge happens.
>=20
> Added new features are
>=20
> * New error handling
> * IRQ driven PIO (from Albert Lee)
> * SATA NCQ support
> * Hotplug support
> * Port Multiplier support
>=20
> The following drivers support new features.
>=20
> ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
> sata_sil:	new EH, irq-pio, hotplug
> ahci:		new EH, irq-pio, NCQ, hotplug
> sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
>=20
> More info can be found at the following URL.
>=20
>  http://home-tj.org/wiki/index.php/Libata-tj-stable

Hi,

I've been using this patch for 2.6.16 for a month now, and it really
works very well. As 2.6.17 is now released, is there going to be a
"libata-tj" for this kernel as well ?
BTW, what is the status of sata_sil new code merge with mainline ? Is i=
t
still expected to be in 2.6.18 ?

Thanks,
--=20
Nico
S'assure-t-on sur l'alliance
Qu'a faite la n=E9cessit=E9 ?
	-+- Jean de La Fontaine (1621-1695),
	    Le Chat et le Rat (Fables VIII.22) -+-

