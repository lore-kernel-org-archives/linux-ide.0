From: Tejun Heo <tj@kernel.org>
Subject: Re: Problems with ALPM on devices part of raid array
Date: Sat, 30 Aug 2008 12:53:34 +0200
Message-ID: <48B926AE.7030108@kernel.org>
References: <48B17C20.7020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35505 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYH3Kyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 06:54:50 -0400
In-Reply-To: <48B17C20.7020203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

T=F6r=F6k Edwin wrote:
> I have an AHCI capable chipset now (ICH10), so I tried ALPM[*], by
> echo-ing min_power to:
> ./class/scsi_host/host0/link_power_management_policy
> ./class/scsi_host/host5/link_power_management_policy
>=20
> The 6 SATA2 drives have 3 partitions each, partition 1 is RAID1,
> partition 3 is RAID10.
>=20
> This soon caused me troubles, as the kernel gave I/O error messages, =
and
> unmounted my filesystems running
> on /dev/md4 (raid10 array). Unfortunately I don't have those messages
> saved to my logs, because my /var filesystem got automatically unmoun=
ted.
> I had no choice but to reboot, and then md kicked 4 drives out of the
> md4 array (6 total drives), and then refused
> to assemble (too few drives). The RAID1 array (md3) got reassembled, =
and
> resynced successfully.
> I had to force the assembly of /dev/md4 [and encountered a mdadm bug
> while doing so: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D49=
6334]
>=20
> I think ALPM should refuse to set link pm if the device is part of a
> raid array, or the md driver should be aware
> of ALPM, and wait a little longer for the device to come back online.
> Mentioning this problem somewhere in the sources/docs would be nice.

Being part of RAID is very unlikely to have anything to do with the
failures.  Can you post kernel, boot log, error messages and the
output of hdparm -I on array members?

--=20
tejun
