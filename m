From: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: hdparm -C always give drive state is standby (was: Kernel panic
	with 2.6.15-rc7 + libata1 patch)
Date: Tue, 03 Jan 2006 17:53:04 +0100
Message-ID: <43BAABF0.7080507@bj-ig.de>
References: <43B724BA.90405@bj-ig.de>	<43B7EA0A.7040805@bj-ig.de>	<20060101145702.GV3811@stusta.de>	<43B806C7.5000607@bj-ig.de>
	<43B93375.1020701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tower.bj-ig.de ([194.127.182.2]:46486 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S932424AbWACQxA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 11:53:00 -0500
In-Reply-To: <43B93375.1020701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Mark Lord schrieb:
> Ralf M=FCller wrote:
>> A further problem is that calling "hdparm -C" _always_ give "drive=20
>> state is:  standby" - even when the disks are clearly active. Maybe=20
>> this indicates something to you.
>=20
>=20
> MMmm.. yes, it does that here, too.
> This is probably a bug somewhere in the libata passthru code,
> or in the HDIO_* translation code.

If I'm right that this should be handled in "ata_cmd_ioctl()" then ther=
e=20
  is no copy_to_user() at all for WIN_CHECKPOWERMODE[12] - so there is=20
no chance to get data back. Are there any known plans to fix this?

Ralf

