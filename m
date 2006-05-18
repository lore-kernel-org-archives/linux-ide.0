From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-tj and SMART
Date: Thu, 18 May 2006 13:00:07 +0900
Message-ID: <446BF147.4040904@gmail.com>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com> <e4g3or$jbm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:13546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750803AbWEREAQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 00:00:16 -0400
Received: by ug-out-1314.google.com with SMTP id a2so393352ugf
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 21:00:14 -0700 (PDT)
In-Reply-To: <e4g3or$jbm$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Nicolas STRANSKY wrote:
> Le 05/16/2006 10:11 AM, Tejun Heo a =E9crit :
>=20
> Hi,
>=20
>> If you've got some time though, I'd like to see what's really going =
on.
>>  Can you modify #undef ATA_DEBUT to #define ATA_DEBUG in
>> include/linux/libata.h and post the kernel messages after issuing ab=
ove
>> command?  Be warned that it will produce a LOT of messages while boo=
ting
>> if you're using SATA disks for your system, and it can considerably =
slow
>> down booting.
>=20
> Here it is.
> I first did a "smartctl -d ata -a -o on /dev/sda" and then a "smartct=
l
> -d ata -a -S on /dev/sda" which are the two commands triggering error=
s
> on this drive with you patch.
>=20
> BTW the system is running very well with your patch apart from this
> smartctl problem.

[CC'ing Albert Lee].

Hello, Albert.

Nicolas reported that when smartd starts kernel complains about HSM=20
violation and full EH kicks in (reset and all that), which it didn't=20
used to before the recent libata changes.  Upon further examination the=
=20
offending part seems to be the HSM_ST handling code of ata_hsm_move().

	/* ATA PIO protocol */
	if (unlikely((status & ATA_DRQ) =3D=3D 0)) {
		/* handle BSY=3D0, DRQ=3D0 as error */
		qc->err_mask |=3D AC_ERR_HSM;
		ap->hsm_task_state =3D HSM_ST_ERR;
		goto fsm_start;
	}

The above is the first test done on entrance to HSM_ST for non-ATAPI=20
devices.  On startup, smartd issues some obsolete commands (feat: 0xd1=20
and 0xdb) which use PIO data-in protocol, some drives don't implement=20
the obsolete command and aborts them (stat: 0x51 err: 0x4), which is th=
e=20
correct behavior if the drive doesn't implement specific command.=20
However, the above code triggers and the error is handled as HSM=20
violation not device abortion.

It seems that HSM_ST needs to handle !DRQ && ERR case before the first=20
iteration (or maybe it should be pushed into HSM_ST_FIRST?).  Does my=20
analysis make sense?

Thanks.

--=20
tejun
