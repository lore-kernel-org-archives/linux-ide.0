From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Tue, 27 Dec 2005 12:27:57 -0700
Message-ID: <e9c3a7c20512271127v36eb56c9m54568a79784412e@mail.gmail.com>
References: <20051214201049.GA20640@dwillia2-linux.ch.intel.com>
	 <20051218091904.GA39033@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_564_8414064.1135711677987"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:32104 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751134AbVL0T17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Dec 2005 14:27:59 -0500
Received: by zproxy.gmail.com with SMTP id f1so1349788nzc
        for <linux-ide@vger.kernel.org>; Tue, 27 Dec 2005 11:27:58 -0800 (PST)
In-Reply-To: <20051218091904.GA39033@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org

------=_Part_564_8414064.1135711677987
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/18/05, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Wed, Dec 14, 2005 at 01:10:49PM -0700, Dan Williams wrote:
> > * libata does not care about error interrupts, so handle them locally
> > * the interrupts that are ignored only appear to happen at init time
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Okay, I finally had some time to look at this.  A few comments . . . .
>
> > ---
> >
> >  drivers/scsi/sata_vsc.c |   30 +++++++++++++++++++++++++++++-
> >  1 files changed, 29 insertions(+), 1 deletions(-)
> >
> > applies-to: 90d8277c8775f3c09655df3b48c37fe07504d162
> > 710b992dc354832bb854b9fb05c8fc73c15664d8
> > diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> > index cf94e01..7dcc486 100644
> > --- a/drivers/scsi/sata_vsc.c
> > +++ b/drivers/scsi/sata_vsc.c
> > @@ -81,6 +81,19 @@
> >  /* Port stride */
> >  #define VSC_SATA_PORT_OFFSET         0x200
> >
> > +/* Error interrupt status bit offsets */
> > +#define VSC_SATA_INT_ERROR_E_OFFSET  2
> > +#define VSC_SATA_INT_ERROR_P_OFFSET  4
> > +#define VSC_SATA_INT_ERROR_T_OFFSET  5
> > +#define VSC_SATA_INT_ERROR_M_OFFSET  1
> > +#define is_vsc_sata_int_err(port_idx, int_status) \
> > +      (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_id=
x))) | \
> > +                     (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_id=
x))) | \
> > +                     (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_id=
x))) | \
> > +                     (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_id=
x)))   \
> > +                    )\
> > +      )
> > +
>
> I just want to be sure I'm getting this right.
> Here you're specifying an interest in the "Data Integrity", "Unrecognized=
 FIS
> Reception", "FIFO" errors, and "PHY went from Not-Ready to Ready" bits (t=
ext
> is using names in VSC7174 manual).  Are these the four bits that have cau=
sed
> you trouble, and you haven't had problems with the "CRC Error" and "RERR =
Received",
> and "PHY Ready Change-Of-State" bits?

In the Intel 31244 manual (pg 222
http://www.intel.com/design/storage/manuals/27360306.pdf) it
classifies some errors as diagnostic.  My initial thought was to just
check for and clear non-diagnostic errors, but after working with your
patch I discovered this was not sufficient.

> >  static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg=
)
> >  {
> > @@ -193,13 +206,28 @@ static irqreturn_t vsc_sata_interrupt (i
> >                       struct ata_port *ap;
> >
> >                       ap =3D host_set->ports[i];
> > +
> > +                     if (is_vsc_sata_int_err(i, int_status)) {
> > +                             u32 err_status;
> > +                             printk(KERN_DEBUG "%s: ignoring interrupt=
(s)\n", __FUNCTION__);
> > +                             err_status =3D ap ? vsc_sata_scr_read(ap,=
 SCR_ERROR) : 0;
> > +                             vsc_sata_scr_write(ap, SCR_ERROR, err_sta=
tus);
> > +                             handled++;
> > +                     }
> > +
>
> This is short circuiting the normal LIBATA interrupt handling, right?
> Later, if LIBATA becomes interested in these bits, they'll already be
> cleared.

See below, it turns out that clobbering these bits is not necessary,
but it would negatively impact performance to leave them set.

> Also, if ap actually is NULL, the vsc_sata_scr_write() call will fail
> when it tries to dereference ap.

Ok.

>
> >                       if (ap && !(ap->flags &
> >                                   (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOIN=
TR))) {
> >                               struct ata_queued_cmd *qc;
> >
> >                               qc =3D ata_qc_from_tag(ap, ap->active_tag=
);
> > -                             if (qc && (!(qc->tf.ctl & ATA_NIEN)))
> > +                             if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
> >                                       handled +=3D ata_host_intr(ap, qc=
);
> > +                             } else {
> > +                                     printk(KERN_DEBUG "%s: ignoring i=
nterrupt(s)\n", __FUNCTION__);
> > +                                     ata_chk_status(ap);
> > +                                     handled++;
> > +                             }
> > +
>
> I don't think I fully understand the problem you're trying to solve, but
> the gist seems to be that you're taking endless interrupts even when
> ATA_NIEN is set.
Yes...

> So you add the dummy ata_chk_status call to clear
> interrupts that the libata core isn't interested in.  But ata_chk_status
> doesn't actually clear it unless you first write to the SCR_ERROR
> register above?

Actually I added the dummy ata_chk_status because just clearing the
SCR_ERROR bits did not stop the stream of interrupts.  Upon further
investigation it appears that clearing the SCR_ERRORS is not
_required_ and all that is necessary is the ata_chk_status() call.=20
however not clearing the SCR_ERROR results in the error interrupt
recurring everytime the disk is accessed.

For example:
vsc_sata_interrupt: clearing interrupt, status 30383; sata err status 50002
vsc_sata_interrupt: clearing interrupt, status 30383; sata err status 50002
Adding 136512k swap on /dev/sda1.  Priority:-1 extents:1 across:136512k
vsc_sata_interrupt: clearing interrupt, status 38303; sata err status 50002
vsc_sata_interrupt: clearing interrupt, status 38303; sata err status 50002
Adding 125456k swap on /dev/sdb1.  Priority:-2 extents:1 across:125456k
vsc_sata_interrupt: clearing interrupt, status 830303; sata err status 5000=
2
vsc_sata_interrupt: clearing interrupt, status 830303; sata err status 5000=
2
Adding 136512k swap on /dev/sdc1.  Priority:-3 extents:1 across:136512k

> FWIW, on my Vitesse chip, the int_status and SCR_ERROR bits that are set =
and
> when this code is called this code are 0x83 and 0x50002, respectively.  B=
ut
> not clearing them doesn't seem to cause a problem . . . this must be diff=
erent
> behavior in your chip (presumably the Intel branch).

Yes, with your patch I get the same output, perhaps the Vitesse part
does not tie these bits to the error interrupt, or they are masked by
default?

I like your new organization of the code.  I went ahead and revised
the patch further to make is_vsc_sata_int_err() less expensive, and
better document the need for the extra error handling code.  I also
updated the Kconfig entry to make it obvious that the Intel part can
use the same driver.  My apologies for attaching the patch I am still
working on the best way to get list traffic to a sane MTA on my linux
box at work.

Dan

------=_Part_564_8414064.1135711677987
Content-Type: text/x-patch; name=sata_vsc_intel-2.6.15-rc.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sata_vsc_intel-2.6.15-rc.patch"

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 20dd85a..5bde03b 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -586,10 +586,10 @@ config SCSI_SATA_VIA
 	  If unsure, say N.
 
 config SCSI_SATA_VITESSE
-	tristate "VITESSE VSC-7174 SATA support"
+	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for Vitesse VSC7174 Serial ATA.
+	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
 	  If unsure, say N.
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2282c04..72ddba9 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2044,7 +2044,7 @@ static int atapi_qc_complete(struct ata_
 	else {
 		u8 *scsicmd = cmd->cmnd;
 
-		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
+		if (scsicmd[0] == INQUIRY) {
 			u8 *buf = NULL;
 			unsigned int buflen;
 
@@ -2058,6 +2058,9 @@ static int atapi_qc_complete(struct ata_
 	 * device.  2) Ensure response data format / ATAPI information
 	 * are always correct.
 	 */
+	/* FIXME: do we ever override EVPD pages and the like, with
+	 * this code?
+	 */
 			if (buf[2] == 0) {
 				buf[2] = 0x5;
 				buf[3] = 0x32;
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index fcfa486..149ed83 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -81,6 +81,22 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET		0x200
 
+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_CRC		(1 << 6)
+#define VSC_SATA_INT_ERROR_T		(1 << 5)
+#define VSC_SATA_INT_ERROR_P		(1 << 4)
+#define VSC_SATA_INT_ERROR_R		(1 << 3)
+#define VSC_SATA_INT_ERROR_E		(1 << 2)
+#define VSC_SATA_INT_ERROR_M		(1 << 1)
+#define VSC_SATA_INT_PHY_CHANGE	(1 << 0)
+#define VSC_SATA_INT_ERROR (VSC_SATA_INT_ERROR_CRC  + VSC_SATA_INT_ERROR_T + \
+			     VSC_SATA_INT_ERROR_P    + VSC_SATA_INT_ERROR_R + \
+			     VSC_SATA_INT_ERROR_E    + VSC_SATA_INT_ERROR_M + \
+			     VSC_SATA_INT_PHY_CHANGE)
+
+#define is_vsc_sata_int_err(port_idx, int_status) \
+	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
+
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -206,8 +222,28 @@ static irqreturn_t vsc_sata_interrupt (i
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
+				} else if (is_vsc_sata_int_err(i, int_status)) {
+					/*
+					 * On some chips (i.e. Intel 31244), an error 
+					 * interrupt will sneak in at initialization
+					 * time (phy state changes).  Clearing the SCR
+					 * error register is not required, but it prevents
+					 * the phy state change interrupts from recurring 
+					 * later.
+					 */
+					u32 err_status;
+					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
+					printk(KERN_DEBUG "%s: clearing interrupt, "
+					       "status %x; sata err status %x\n",
+					       __FUNCTION__,
+					       int_status, err_status);
+					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+					/* Clear interrupt status */
+					ata_chk_status(ap);
+					handled++;
+				}
 			}
 		}
 	}


------=_Part_564_8414064.1135711677987--
