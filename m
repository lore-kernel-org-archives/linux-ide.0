From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata coldplug?
Date: Tue, 15 Feb 2005 13:30:18 -0500
Message-ID: <42123FBA.4050809@pobox.com>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com> <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr> <42122859.9060609@pobox.com> <421235D1.60501@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7615 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261807AbVBOSag (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Feb 2005 13:30:36 -0500
In-Reply-To: <421235D1.60501@conterra.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: linux-ide@vger.kernel.org

Dieter St=FCken wrote:
> Jeff Garzik wrote:
>=20
>> Seems like the hotplug code is triggering....
>=20
>=20
> apropos:
>=20
> will "coldplug" be possible some day?
>=20
> The FAQ says:
>  ... some SATA controllers will never support hotplug
>=20
> I never want to relay on any kind of "hotplug", but may
> be I want to drop some drive from the system, after an
> regular umount; or I want to put in some additional disk
> while the system is running. This would be very usefull
> for LVM, too. I found some hints about how to to do that
> for SCSI disks, but this did not work properly for SATA :(
>=20
> Will/is it possible for SATA, too?

Eventually for all controllers except Intel ICH5/6 (ata_piix), yes.

	Jeff



