From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: sata coldplug?
Date: Tue, 15 Feb 2005 18:48:01 +0100
Message-ID: <421235D1.60501@conterra.de>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com> <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr> <42122859.9060609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from vvv.conterra.de ([212.124.44.162]:7377 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S261635AbVBORsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2005 12:48:05 -0500
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id E9F251C88E8
	for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2005 18:48:03 +0100 (CET)
In-Reply-To: <42122859.9060609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Seems like the hotplug code is triggering....

apropos:

will "coldplug" be possible some day?

The FAQ says:
  ... some SATA controllers will never support hotplug

I never want to relay on any kind of "hotplug", but may
be I want to drop some drive from the system, after an
regular umount; or I want to put in some additional disk
while the system is running. This would be very usefull
for LVM, too. I found some hints about how to to do that
for SCSI disks, but this did not work properly for SATA :(

Will/is it possible for SATA, too?

Dieter.
--=20
Dieter St=FCken, con terra GmbH, M=FCnster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
