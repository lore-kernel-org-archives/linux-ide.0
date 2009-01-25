From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: Another libata error related to OCZ SSD
Date: Sun, 25 Jan 2009 12:08:39 +0100
Message-ID: <20090125110839.GA4691@ics.muni.cz>
References: <20090111174159.GC4250@ics.muni.cz> <200901192239.25071.rjw@sisk.pl> <497BB9BB.4040608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:50536 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbZAYLIx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jan 2009 06:08:53 -0500
Content-Disposition: inline
In-Reply-To: <497BB9BB.4040608@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, Jan 25, 2009 at 10:00:43AM +0900, Tejun Heo wrote:
>=20
> Does the following command make any difference?
>=20
>  echo 0 > /sys/class/scsi_disk/h:c:i:l/manage_start_stop
>=20
> The h:c:i:l part needs to be adjusted to point to the OCZ disk.  lscs=
i
> will show which value to use.

Well, the real problem seems to be in touching link power management po=
licy
(it did not happen with ata_piix driver thus the driver seemed to be ok=
)

If I touch power management with theses commands:
echo max_performance > /sys/class/scsi_host/host0/link_power_management=
_policy
echo medium_power > /sys/class/scsi_host/host0/link_power_management_po=
licy

the suspend fails.

I always restore max_performance policy before the suspend.

--=20
Luk=E1=B9 Hejtm=E1nek
