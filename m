Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB039E17A
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820282; cv=none; b=WJ7BIp6m0rqx1cT3sbR9yTiKHsovFdlKWxl9GZ/4hvp7+div8UirHg+fH/GCEJv5Prrr1+C4sRNilIacXIZimp6niI8fcvnBwXf5Dv/vm4CRbnOTkUkkYWI1EjeyFi0rNMyWuZOd/mfLpW0GvVeEm7m/NwKbPOl+Peq7OEoej/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820282; c=relaxed/simple;
	bh=0mT1ZlesY/EVX3Yp9FU8CtQLomNVApNIyt/aCOjACDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQuGEgf/B/oaQsB/KBY4BJvH9AGzse56td4AzHIag7mxKb3rghUj6dbpvrSLnevkWwFE3KUa8LjFobIC8A90BM0pFHnfL1Q3ox9Me25ZhIR0oToi9+z3A2Ggi+whLkw/IIBlkROkN94+5m8jgyE5jjTYrsGUxPKik9zAjxoiEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=XYRrd8Y/; arc=none smtp.client-ip=115.124.28.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="XYRrd8Y/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775820271; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=P50AMDaHtMp0vKeaZ6PHeBBBZM/lzzYiyMIGxXlWBlE=;
	b=XYRrd8Y/ew37zbD0QQ9EcVxzB8l11xr5B4KbDw69PvO14C6VLDURzgbAh3/1BO7nVfNa+r56Vp9w2yEWqKMLHNtacBSukfSDOZeesobUQdzYl59mLwBHq1mxfi2kkld89mTsGOqHLyM2Ov2ES9/jxd68//xkwX1O/FVFU6aOAN9ygLktv/ko/B6cJokpqybcyQq8ut6ZR6I8sKhXdM/OAQIksXHDSX7mrXKlsIGJiPWZ36kQUT0Vk/aPftE2T2lOQAV5ZYRZWSPga4LWqi/RKAF2JlkqoyZTwoGiKGEb1kgVJ2hHB5V1kRoL6MiI1lErgoo5IYosZa/pLMFMAdS6/Q==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00530679-0.000183067-0.99451;FP=4348031170714015482|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.h9GNTOB_1775820269;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h9GNTOB_1775820269 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 19:24:30 +0800
From: AlanCui4080 <me@alancui.cc>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Fri, 10 Apr 2026 19:24:29 +0800
Message-ID: <12870147.O9o76ZdvQC@alanarchdesktop>
In-Reply-To: <4482b737-1454-48cb-a941-165aa84fb2eb@kernel.org>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop> <14062658.dW097sEU6C@alanarchdesktop>
 <4482b737-1454-48cb-a941-165aa84fb2eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 10 April 2026 12:19=EF=BC=8Cyou wrote=EF=BC=9A
> I need to check the code again, but no, That's not that. Sinc on resume we
> revalidate the device, it is ata_dev_reread_id() that needs to be a bit m=
ore lax
> on timeouts and repeatedly call ata_dev_read_id() with an increasing time=
out as
> defined by ata_eh_identify_timeouts(). That should the IDENTIFY issue for=
 drives
> that slow to respond to that command on resume/while spinning up.
>=20
> >> Or add a check/wait for "drive ready"
> >> when resuming, similar to the PUIS handling (power up in standby).
> >=20
> > There is tried_spinup in ata_dev_read_id(), but seems required the devi=
ce to=20
> > response at least incomplete IDENTIFY, with a device will never respons=
e=20
> > during spining up, is that possible to implement it?
>=20
> Ah, yes, forgot about that one. So it is not an option.
>=20

Hi, I've tried (and extra WARN ONCE at ata_port_is_frozen):

=2D--

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 374993031895..0ac0daae33f9 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3902,7 +3902,15 @@ int ata_dev_reread_id(struct ata_device *dev, unsign=
ed int readid_flags)
        int rc;
=20
        /* read ID data */
=2D       rc =3D ata_dev_read_id(dev, &class, readid_flags, id);
+       int retry_read_id =3D 3;
+       do {
+               rc =3D ata_dev_read_id(dev, &class, readid_flags, id);
+               if (rc) {
+                       ata_dev_warn(dev, "retrying ata_dev_read_id(), %d t=
imes remainng",
+                               retry_read_id);
+               }
+               retry_read_id--;
+       } while (rc && retry_read_id > 0);
        if (rc)
                return rc

=2D-

But it reports:

```
[  119.260621] ata2: found unknown device (class 0)
[  119.264620] ata4: found unknown device (class 0)
[  119.415623] ata2: found unknown device (class 0)
[  119.415634] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  119.422627] ata4: found unknown device (class 0)
[  119.422636] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  124.646636] ata4.00: qc timeout after 5000 msecs (cmd 0xec)
[  124.646646] ata4.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[  124.646648] ata4.00: retrying ata_dev_read_id(), 3 times remainng
[  124.646657] ------------[ cut here ]------------
[  124.646659] ata_port_is_frozen(ap)
[  124.646660] WARNING: drivers/ata/libata-core.c:1549 at ata_exec_internal=
+0x4e4/0x590, CPU#0: scsi_eh_3/155
=2E..
[  124.646793] Call Trace:
[  124.646795]  <TASK>
[  124.646799]  ata_dev_read_id+0x3b2/0x560
[  124.646805]  ata_dev_reread_id+0x50/0xf0
[  124.646808]  ata_dev_revalidate+0x64/0xd0
[  124.646811]  ata_eh_recover+0xa76/0xf90
[  124.646815]  ? update_load_avg+0x7b/0x740
[  124.646819]  ? __dequeue_entity+0x4f4/0x5d0
[  124.646823]  sata_pmp_error_handler+0x387/0x660
[  124.646827]  ? __flush_work+0x2b1/0x360
[  124.646832]  ahci_error_handler+0x42/0x80
[  124.646836]  ata_scsi_port_error_handler+0x71a/0x950
[  124.646840]  ata_scsi_error+0x95/0xd0
[  124.646843]  scsi_error_handler+0xd1/0x530
[  124.646848]  ? __pfx_scsi_error_handler+0x10/0x10
[  124.646851]  kthread+0xfc/0x240
[  124.646855]  ? __pfx_kthread+0x10/0x10
[  124.646858]  ret_from_fork+0x243/0x280
[  124.646862]  ? __pfx_kthread+0x10/0x10
[  124.646865]  ret_from_fork_asm+0x1a/0x30
[  124.646873]  </TASK>
[  124.646875] ---[ end trace 0000000000000000 ]---
[  124.646877] ata4.00: failed to IDENTIFY (I/O error, err_mask=3D0x40)
[  124.646879] ata4.00: retrying ata_dev_read_id(), 2 times remainng
[  124.646886] ata4.00: failed to IDENTIFY (I/O error, err_mask=3D0x40)
[  124.646888] ata4.00: retrying ata_dev_read_id(), 1 times remainng
[  124.646889] ata4.00: revalidation failed (errno=3D-5)
[  124.646919] ata2.00: qc timeout after 5000 msecs (cmd 0xec)
[  124.646927] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[  124.646929] ata2.00: retrying ata_dev_read_id(), 3 times remainng
[  124.646937] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x40)
[  124.646939] ata2.00: retrying ata_dev_read_id(), 2 times remainng
[  124.646945] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x40)
[  124.646947] ata2.00: retrying ata_dev_read_id(), 1 times remainng
[  124.646948] ata2.00: revalidation failed (errno=3D-5)
[  125.110629] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  125.110649] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  125.146916] ata2.00: configured for UDMA/133
[  125.163102] ata4.00: configured for UDMA/133

```

And, yes, libata will freeze the link when the qc failed:

```
if (qc->flags & ATA_QCFLAG_ACTIVE) {
	qc->err_mask |=3D AC_ERR_TIMEOUT;
	ata_port_freeze(ap);
	ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
		     timeout, command);
}
```

So, should the retry happened in ata_exec_internal()? No, the ata_exec_inte=
rnal has
no a path to cancel the command already issued, it can only be freeze and r=
eset the
port. All we can do is to continue wait and increase the timeout 3 times be=
fore
let the port reset. I don't think that is a good idea.

Alan.


