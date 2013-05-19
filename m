From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Sun, 19 May 2013 15:31:22 +0200
Message-ID: <201305191531.23110.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com> <201305171920.11127.plr.vincent@gmail.com> <20130517184732.GD12632@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rQNmRDUEF7PGg+p"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:48899 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3ESNb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 May 2013 09:31:27 -0400
Received: by mail-we0-f180.google.com with SMTP id u56so958304wes.39
        for <linux-ide@vger.kernel.org>; Sun, 19 May 2013 06:31:26 -0700 (PDT)
In-Reply-To: <20130517184732.GD12632@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Csaba =?utf-8?q?Hal=C3=A1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

--Boundary-00=_rQNmRDUEF7PGg+p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.

Le vendredi 17 mai 2013 20:47:32, vous avez =E9crit :
> On Fri, May 17, 2013 at 07:20:10PM +0200, Vincent Pelletier wrote:
> > If not, would it be possible to have a rw sysfs pseudofile per-device
> > (...per port ?) to enable DMADIR ?
>=20
> Yeap, that sounds like the best we can do at this point.  Care to
> write up a patch?

=46irst attempt attached (2/2).

Now that I got it working, I'm thining it would be better to automatically=
=20
fallback to enabling DMADIR per-device level during initialisation (just li=
ke=20
current fallbacks to 1.5Gbps and UDMA/33:PIO3, as visible in 1/2 commit=20
message).
I believe it will slow down boot when such device is plugged in, though, an=
y=20
idea on how this can be avoided ?

> While better, please go into more details.  The problem here is that
> the bridge requires DMADIR and while libata makes use of DMADIR for
> regular commands, it doesn't do that for internal commands which are
> used during EH, right?

Just to be clear about EH: the timeout happens during device  initialisatio=
n=20
(both at boot or on hotplug), not during error handling (or, maybe it happe=
ns=20
in both places, but for the same reason).
I'm not comfortable with calling device discovery/initialisation as "error=
=20
handling", but maybe it's unambiguous when used to libata.

I assume the failure to clear UNIT ATTENTION is just an error-on-error=20
which gets fixed both because it wouldn't fail to clear (I didn't check) an=
d=20
because there is no error state to clear.

> Please go into full details of what's going on and be verbose.

3rd try attached (1/2).

Regards,
=2D-=20
Vincent Pelletier

--Boundary-00=_rQNmRDUEF7PGg+p
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"

=46rom 4fd4c88648d151e6c790c8ce49bcc128492f018b Mon Sep 17 00:00:00 2001
Message-Id: <4fd4c88648d151e6c790c8ce49bcc128492f018b.1368970061.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sat, 18 May 2013 18:44:04 +0200
Subject: [1/2] libata: make ata_exec_internal_sg honor DMADIR
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

libata honors DMADIR for regular commands, but not for internal commands
used (among other) during device initialisation.

This makes SATA-host-to-PATA-device bridges based on Silicon Image SiL3611
(such as "Abit Serillel 2") end up disabled when used with an ATAPI device
after a few tries.

Log output of the bridge being hot-plugged with an ATAPI drive:

  [ 9631.212901] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 action =
0xe frozen
  [ 9631.212913] ata1: irq_stat 0x00000040, connection status changed
  [ 9631.212923] ata1: SError: { CommWake 10B8B DevExch }
  [ 9631.212939] ata1: hard resetting link
  [ 9632.104962] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9632.106393] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDMA/33
  [ 9632.106407] ata1.00: applying bridge limits
  [ 9632.108151] ata1.00: configured for UDMA/33
  [ 9637.105303] ata1.00: qc timeout (cmd 0xa0)
  [ 9637.105324] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9637.105335] ata1: hard resetting link
  [ 9638.044599] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9638.047878] ata1.00: configured for UDMA/33
  [ 9643.044933] ata1.00: qc timeout (cmd 0xa0)
  [ 9643.044953] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9643.044963] ata1: limiting SATA link speed to 1.5 Gbps
  [ 9643.044971] ata1.00: limiting speed to UDMA/33:PIO3
  [ 9643.044979] ata1: hard resetting link
  [ 9643.984225] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9643.987471] ata1.00: configured for UDMA/33
  [ 9648.984591] ata1.00: qc timeout (cmd 0xa0)
  [ 9648.984612] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9648.984619] ata1.00: disabled
  [ 9649.000593] ata1: hard resetting link
  [ 9649.939902] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9649.955864] ata1: EH complete

With this patch, the drive enumerates correctly when libata is loaded with
atapi_dmadir=3D1:

  [ 9891.810863] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 action =
0xe frozen
  [ 9891.810874] ata1: irq_stat 0x00000040, connection status changed
  [ 9891.810884] ata1: SError: { CommWake 10B8B DevExch }
  [ 9891.810900] ata1: hard resetting link
  [ 9892.762105] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9892.763544] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDMA/33=
, DMADIR
  [ 9892.763558] ata1.00: applying bridge limits
  [ 9892.765393] ata1.00: configured for UDMA/33
  [ 9892.786063] ata1: EH complete
  [ 9892.792062] scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-115  =
1.06 PQ: 0 ANSI: 5
  [ 9892.798455] sr2: scsi3-mmc drive: 12x/12x writer dvd-ram cd/rw xa/form=
2 cdda tray
  [ 9892.798837] sr 0:0:0:0: Attached scsi CD-ROM sr2
  [ 9892.799109] sr 0:0:0:0: Attached scsi generic sg6 type 5

Based on a patch by Csaba Hal=C3=A1sz <csaba.halasz@gmail.com> on linux-ide:
http://marc.info/?l=3Dlinux-ide&m=3D136121147832295&w=3D2

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
=2D--
 drivers/ata/libata-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63c743b..d121db7 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1600,8 +1600,13 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
=20
 	/* prepare & issue qc */
 	qc->tf =3D *tf;
=2D	if (cdb)
+	if (cdb) {
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
+		if ((dev->flags & ATA_DFLAG_DMADIR) &&
+		    (dma_dir =3D=3D DMA_FROM_DEVICE))
+			/* some SATA bridges need us to indicate data xfer direction */
+			qc->tf.feature |=3D ATAPI_DMADIR;
+	}
 	qc->flags |=3D ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir =3D dma_dir;
 	if (dma_dir !=3D DMA_NONE) {
=2D-=20
1.7.10.4


--Boundary-00=_rQNmRDUEF7PGg+p
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-RFC-libata-Add-a-per-device-sysfs-control-for-atapi_.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-RFC-libata-Add-a-per-device-sysfs-control-for-atapi_.patch"

=46rom 62ce0a157f245929f3b7471a3668e03792d14420 Mon Sep 17 00:00:00 2001
Message-Id: <62ce0a157f245929f3b7471a3668e03792d14420.1368970061.git.plr.vi=
ncent@gmail.com>
In-Reply-To: <4fd4c88648d151e6c790c8ce49bcc128492f018b.1368970061.git.plr.v=
incent@gmail.com>
References: <4fd4c88648d151e6c790c8ce49bcc128492f018b.1368970061.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sun, 19 May 2013 15:10:41 +0200
Subject: [2/2] [RFC] libata: Add a per-device sysfs control for atapi_dmadir

Some device require DMADIR to be enabled, but are not detected as such by
atapi_id_dmadir.
One such example is "Asus Serillel 2" SATA-host-to-PATA-device bridge: the
bridge itself requires DMADIR, even if the bridged device does not.

As atapi_dmadir module parameter can cause problems with some devices
(as per Tejun Heo's memory), enabling it may not be possible depending on
the hardware.

This patch implements a per-device sysfs control knob on port level, as
port is present before devices are attached, so configuration can happen
before device initialisation.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
=2D--
 Documentation/ABI/testing/sysfs-ata |    8 ++++++++
 drivers/ata/libata-core.c           |    3 ++-
 drivers/ata/libata-transport.c      |   27 ++++++++++++++++++++++-----
 include/linux/libata.h              |    2 ++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testin=
g/sysfs-ata
index 0a93215..c2dbe1a 100644
=2D-- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -20,6 +20,14 @@ nr_pmp_links (read)
=20
 	If a SATA Port Multiplier (PM) is connected, number of link behind it.
=20
+atapi_dmadir
+
+	Bitmask enabling dmadir for corresponding device if ATAPI.
+	1:	Enable dmadir for port's device 0
+	2:	Enable dmadir for port's device 1
+	(etc)
+	See also libata's atapi_dmadir module parameter.
+
 Files under /sys/class/ata_link
 -------------------------------
=20
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d121db7..1b4fcee 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2400,7 +2400,7 @@ int ata_dev_configure(struct ata_device *dev)
 			cdb_intr_string =3D ", CDB intr";
 		}
=20
=2D		if (atapi_dmadir || atapi_id_dmadir(dev->id)) {
+		if (atapi_dmadir || ap->atapi_dmadir & (1 << dev->devno) || atapi_id_dma=
dir(dev->id)) {
 			dev->flags |=3D ATA_DFLAG_DMADIR;
 			dma_dir_string =3D ", DMADIR";
 		}
@@ -5643,6 +5643,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->print_id =3D -1;
 	ap->host =3D host;
 	ap->dev =3D host->dev;
+	ap->atapi_dmadir =3D 0;
=20
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index c04d393..6624d1d 100644
=2D-- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -37,7 +37,7 @@
 #include "libata.h"
 #include "libata-transport.h"
=20
=2D#define ATA_PORT_ATTRS		2
+#define ATA_PORT_ATTRS		3
 #define ATA_LINK_ATTRS		3
 #define ATA_DEV_ATTRS		9
=20
@@ -217,6 +217,22 @@ static DEVICE_ATTR(name, S_IRUGO, show_ata_port_##name=
, NULL)
 ata_port_simple_attr(nr_pmp_links, nr_pmp_links, "%d\n", int);
 ata_port_simple_attr(stats.idle_irq, idle_irq, "%ld\n", unsigned long);
=20
+static ssize_t
+store_ata_port_atapi_dmadir(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct ata_port *ap =3D transport_class_to_port(dev);
+	if (kstrtouint(buf, 0, &ap->atapi_dmadir) < 0)
+		return -EINVAL;
+	return count;
+}
+
+ata_port_show_simple(atapi_dmadir, atapi_dmadir, "%d\n", (int))
+static DEVICE_ATTR(atapi_dmadir, S_IRUGO | S_IWUSR,
+		   show_ata_port_atapi_dmadir,
+		   store_ata_port_atapi_dmadir);
+
 static DECLARE_TRANSPORT_CLASS(ata_port_class,
 			       "ata_port", NULL, NULL, NULL);
=20
@@ -669,8 +685,8 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 #define SETUP_LINK_ATTRIBUTE(field)					\
 	SETUP_TEMPLATE(link_attrs, field, S_IRUGO, 1)
=20
=2D#define SETUP_PORT_ATTRIBUTE(field)					\
=2D	SETUP_TEMPLATE(port_attrs, field, S_IRUGO, 1)
+#define SETUP_PORT_ATTRIBUTE(field, mode)				\
+	SETUP_TEMPLATE(port_attrs, field, mode, 1)
=20
 #define SETUP_DEV_ATTRIBUTE(field)					\
 	SETUP_TEMPLATE(dev_attrs, field, S_IRUGO, 1)
@@ -707,8 +723,9 @@ struct scsi_transport_template *ata_attach_transport(vo=
id)
 	transport_container_register(&i->dev_attr_cont);
=20
 	count =3D 0;
=2D	SETUP_PORT_ATTRIBUTE(nr_pmp_links);
=2D	SETUP_PORT_ATTRIBUTE(idle_irq);
+	SETUP_PORT_ATTRIBUTE(nr_pmp_links, S_IRUGO);
+	SETUP_PORT_ATTRIBUTE(idle_irq, S_IRUGO);
+	SETUP_PORT_ATTRIBUTE(atapi_dmadir, S_IRUGO | S_IWUSR);
 	BUG_ON(count > ATA_PORT_ATTRS);
 	i->port_attrs[count] =3D NULL;
=20
diff --git a/include/linux/libata.h b/include/linux/libata.h
index eae7a05..0f598c5 100644
=2D-- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -773,6 +773,8 @@ struct ata_port {
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
=20
+	unsigned int		atapi_dmadir;   /* bitmask of dmadir-enabled device numbers=
 */
+
 	int			nr_pmp_links;	/* nr of available PMP links */
 	struct ata_link		*pmp_link;	/* array of PMP links */
 	struct ata_link		*excl_link;	/* for PMP qc exclusion */
=2D-=20
1.7.10.4


--Boundary-00=_rQNmRDUEF7PGg+p--
