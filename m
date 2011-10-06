From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Wed, 5 Oct 2011 22:48:13 -0700
Message-ID: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
References: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
	<20110713133425.GP2872@htj.dyndns.org>
	<20110713143936.GQ2872@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
	<20110714071459.GB3455@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
	<20110721090022.GF3455@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
	<20110722095037.GJ2622@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local>
	<20110730125456.GN2622@htj.dyndns.org>
	<loom.20110930T233659-338@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:6611 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714Ab1JFFsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 01:48:15 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p965mF96009164
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2011 22:48:15 -0700
Received: from vcbfo14 (vcbfo14.prod.google.com [10.220.205.14])
	by wpaz37.hot.corp.google.com with ESMTP id p965idRO009204
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2011 22:48:14 -0700
Received: by vcbfo14 with SMTP id fo14so3162190vcb.1
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2011 22:48:13 -0700 (PDT)
In-Reply-To: <loom.20110930T233659-338@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike I <mihrcke@gmail.com>
Cc: linux-ide@vger.kernel.org

I think I know what is going on. One of your disks at least is slow to
spinup. Due to a bug/feature in silicon image disk controller and pmp,
at bring up we can not issue a SOFT_RESET and wait for the disk to
spinup and then continue.
That why we set ATA_LFLAG_NO_SRST in=A0sata_pmp_quirks().
So what happen is we go into a function that issue identify, but we
fail, the disk is not ready [it is spinning up], so we retry.
3 times.

=46rom the first hard reset:=A012888.470385, to the time you got the fi=
nal
error:=A012901.397305 ~ 12.9s
In the second case, your controller can send SOFT_RESET and wait for
the device to respond.
Time for the disk to spinup:
28010.630028 -=A027997.097116 ~ 13.5s
As you can see, you are borderline with the PMP, but the controller
did not "wait" enough in the first case.
Given the spinup time varies with drive, age, time since last
spin-up..., it may work one day and fail the next.
To work around the problem, I have a patch that consist of allowing
the silicon image control to send a reset, but if it fails, we spin
for a fixed amount of time and retry. This is not very nice, it is a
better design to wait for event that waiting a fixed amount of time.
You may have to alter=A0ATA_LFLAG_WAIT_SRST to use the first bit availa=
ble.

Can you try with the following patch?

Thanks,
Gwendal.

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 228740f..b98b02d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2798,7 +2798,14 @@ int ata_eh_reset(struct ata_link *link, int clas=
sify,
=A0 =A0 =A0sata_scr_read(link, SCR_STATUS, &sstatus))
=A0 rc =3D -ERESTART;

- if (rc =3D=3D -ERESTART || try >=3D max_tries)
+ if (try >=3D max_tries)
+ goto out;
+
+ /* Some PMP will not serve SRST until the disk is spunup,
+ * if the controller can not wait for the PMP to acknowledge the frame=
,
+ * wait here */
+ if (rc =3D=3D -ERESTART &&
+ =A0 =A0!((lflags & ATA_LFLAG_WAIT_SRST) && (reset =3D=3D softreset)))
=A0 goto out;

=A0 now =3D jiffies;
@@ -2813,6 +2820,8 @@ int ata_eh_reset(struct ata_link *link, int class=
ify,
=A0 delta =3D schedule_timeout_uninterruptible(delta);
=A0 }

+ if (rc =3D=3D -ERESTART)
+ goto out;
=A0 if (try =3D=3D max_tries - 1) {
=A0 sata_down_spd_limit(link, 0);
=A0 if (slave)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 00305f4..d21ad7d 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -325,13 +351,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
=A0 if (vendor =3D=3D 0x1095 && devid =3D=3D 0x3726) {
=A0 /* sil3726 quirks */
=A0 ata_for_each_link(link, ap, EDGE) {
- /* Class code report is unreliable and SRST
- * times out under certain configurations.
- */
+ /* Class code report is unreliable */
+ /* PMP does not forward SRST until the drive spins up */
=A0 if (link->pmp < 5)
- link->flags |=3D ATA_LFLAG_NO_SRST |
- =A0 =A0 =A0 ATA_LFLAG_ASSUME_ATA;
-
+ link->flags |=3D ATA_LFLAG_ASSUME_ATA |
+ =A0 =A0 =A0 ATA_LFLAG_WAIT_SRST;
=A0 /* port 5 is for SEMB device and it doesn't like SRST */
=A0 if (link->pmp =3D=3D 5)
=A0 link->flags |=3D ATA_LFLAG_NO_SRST |
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b2f2003..3a18caa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,7 @@ enum {
=A0 ATA_LFLAG_NO_RETRY =3D (1 << 5), /* don't retry this link */
=A0 ATA_LFLAG_DISABLED =3D (1 << 6), /* link is disabled */
=A0 ATA_LFLAG_SW_ACTIVITY =3D (1 << 7), /* keep activity stats */
+ ATA_LFLAG_WAIT_SRST =3D (1 << 8), /* add delay when SRST fails */

=A0 /* struct ata_port flags */
=A0 ATA_FLAG_SLAVE_POSS =3D (1 << 0), /* host supports slave dev */


On Fri, Sep 30, 2011 at 2:54 PM, Mike I <mihrcke@gmail.com> wrote:
>
> tj <at> kernel.org <tj <at> kernel.org> writes:
>
> >
> > Hello,
> >
> > How did that go?
> >
> > Thanks.
> >
>
> Like Derry who started this thread, I too had seen an old thread from
> October/November 2008 with what appeared to be no resolution to this =
problem.
> Now, finding this thread, again, with no apparent resolution to this =
problem.
>
> I'm currently running Ubuntu 10.04 (lucid), kernel 2.6.32-33-generic.=
 =A0I've no
> experience with applying these git patches, and my searching to figur=
e out how
> it works have not helped.
>
> I'm using an Addonics eSATA PCI-X controller with the SiI3124 chipset=
, and I
> have an Addonics PM in an external enclosure, with a 5 bay/tray DAS. =
=A0Some of
> my drives give me this problem: (this occurs for me with pretty much =
ALL
> Samsung hard drives)
> [12888.470308] ata9.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 =
action 0xf
> [12888.470313] ata9.01: SError: { PHYRdyChg CommWake DevExch }
> [12888.470385] ata9.01: hard resetting link
> [12889.211597] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
20)
> [12889.211686] ata9.01: failed to IDENTIFY (I/O error, err_mask=3D0x1=
1)
> [12889.211692] ata9.15: hard resetting link
> [12891.430086] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
> [12891.430397] ata9.00: hard resetting link
> [12891.780786] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
20)
> [12894.211103] ata9.01: hard resetting link
> [12894.560424] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12894.560466] ata9.02: hard resetting link
> [12894.914176] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12894.914222] ata9.03: hard resetting link
> [12895.264141] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12895.264169] ata9.04: hard resetting link
> [12895.612930] ata9.04: SATA link down (SStatus 0 SControl 320)
> [12895.613007] ata9.05: hard resetting link
> [12895.964143] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
20)
> [12896.065908] ata9.00: configured for UDMA/100
> [12896.065970] ata9.01: failed to IDENTIFY (I/O error, err_mask=3D0x1=
1)
> [12896.065977] ata9.15: hard resetting link
> [12898.283804] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
> [12898.284128] ata9.00: hard resetting link
> [12898.634174] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
20)
> [12899.562524] ata9.01: hard resetting link
> [12899.914147] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12899.914180] ata9.02: hard resetting link
> [12900.261682] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12900.261724] ata9.03: hard resetting link
> [12900.610413] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12900.961283] ata9.05: hard resetting link
> [12901.310385] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
20)
> [12901.397241] ata9.00: configured for UDMA/100
> [12901.397300] ata9.01: failed to IDENTIFY (I/O error, err_mask=3D0x1=
1)
> [12901.397305] ata9.01: failed to recover link after 3 tries, disabli=
ng
> [12901.397311] ata9.15: hard resetting link
> [12903.613694] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
> [12903.960564] ata9.00: hard resetting link
> [12904.311125] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
20)
> [12905.260154] ata9.02: hard resetting link
> [12905.602929] ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12905.611319] ata9.03: hard resetting link
> [12905.962555] ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 3=
00)
> [12905.962592] ata9.04: hard resetting link
> [12906.312931] ata9.04: SATA link down (SStatus 0 SControl 320)
> [12906.313004] ata9.05: hard resetting link
> [12906.660409] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
20)
> [12906.753619] ata9.00: configured for UDMA/100
> [12906.766586] ata9.02: configured for UDMA/100
> [12906.771917] ata9.03: configured for UDMA/100
> [12907.121462] ata9: EH complete
>
> If I hot plug the same drive using a port directly off my mobo(no PM =
in the
> mix), I get this result(drive connects/mounts/works):
> [27997.097104] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4050000 act=
ion
> 0xe frozen
> [27997.097108] ata5: irq_stat 0x00400040, connection status changed
> [27997.097111] ata5: SError: { PHYRdyChg CommWake DevExch }
> [27997.097116] ata5: hard resetting link
> [28007.147622] ata5: softreset failed (device not ready)
> [28007.147627] ata5: hard resetting link
> [28010.630028] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [28010.748595] ata5.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
> [28010.748599] ata5.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth=
 31/32)
> [28010.755227] ata5.00: configured for UDMA/133
> [28010.755237] ata5: EH complete
> [28010.756338] scsi 4:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0SAM=
SUNG HD154UI =A01AG0
> PQ: 0 ANSI: 5
> [28010.756475] sd 4:0:0:0: Attached scsi generic sg10 type 0
> [28010.756572] sd 4:0:0:0: [sdj] 2930277168 512-byte logical blocks: =
(1.50
> TB/1.36 TiB)
> [28010.756613] sd 4:0:0:0: [sdj] Write Protect is off
> [28010.756616] sd 4:0:0:0: [sdj] Mode Sense: 00 3a 00 00
> [28010.756636] sd 4:0:0:0: [sdj] Write cache: enabled, read cache: en=
abled,
> doesn't support DPO or FUA
> [28010.756760] =A0sdj: sdj1
> [28010.816161] sd 4:0:0:0: [sdj] Attached SCSI disk
>
> I've been using Ubuntu for a few years now, and have been living with=
 the
> problem...working around it with USB docking stations and such. =A0Bu=
t, I'd
> really hope to see/find this problem worked out.
>
> Thoughts/tips/suggestions? =A0Since I'm pretty much a novice when it =
comes to
> patching, a link to a guide for git patching would be appreciated too=
=2E
>
> Thank You,
> Mike
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
