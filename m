From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] 2.6.34-rc3 v2 Disable R_OK (Early ACK) on SII 3726 PMP
Date: Tue, 20 Apr 2010 13:52:21 -0700
Message-ID: <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
References: <g2ida824cf31004141843p41f7b21fz25927e3c6faeeed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38548 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab0DTUwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2010 16:52:36 -0400
In-Reply-To: <g2ida824cf31004141843p41f7b21fz25927e3c6faeeed7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>

ping? Can this patch please be applied?

I was assuming this will show up here:
   http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/libata-dev.git;a=
=3Dshortlog;h=3Drefs/heads/upstream-linus

thanks,
grant

On Wed, Apr 14, 2010 at 6:43 PM, Grant Grundler <grundler@google.com> w=
rote:
> In 2009, While running "cache read" performance test of drives behind
> SII PMP we encountered a "all 5 drives" timeout on more than 30% of t=
he
> machines under test. =C2=A0This patch reduces the rate by a factor of=
 about 70.
> Low enough that we didn't care to further investigate the issue.
>
> Performance impact with any sort of "normal" use was ~2%+ CPU and les=
s
> than 1% throughput degradation. =C2=A0Worst case impact (cached read)=
 was
> 6% IOPS reduction. This is with NCQ off (q=3D1) but I believe FIS bas=
ed
> switching enabled in the SATA driver.
>
> The patch disables "Early ACK" in the 3726 port multiplier.
> "Early ACK" is issued when device sends a FIS to the host (via PMP)
> and the PMP sends an ACK immediately back to the device - well before
> the host gets the response. Under worst case IOPs load (cached read
> test) and more than 2 PMPs connected to a 4-port SATA controller,
> I suspect the time to service all of the PMPs is exceeding the PMPs
> ability to keep track of outstanding FIS it owes the Host. Reducing
> the number of PMPs to 2 (or 1) reduces the frequency by several order=
s
> of magnitude. Kudos to Gwendal for initial debugging of this issue.
> [Any errors in the description are mine, not his.]
>
> Patch is currently in production on Google servers.
>
> Signed-off-by: Grant Grundler <grundler@google.com>
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> ---
>
> v2: dropped references to 4726 since I didn't test 4726,
> =C2=A0 =C2=A0moved register definition directly into libata-pmp.c, an=
d
> =C2=A0 =C2=A0expanded the comment in the code to summarize the above =
description.
>
> Code below is white space mangled. Please use attached file.
>
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 00305f4..487227a 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -231,10 +231,14 @@ static const char *sata_pmp_spec_rev_str(const =
u32 *gscr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return "<unknown>";
> =C2=A0}
>
> +#define PMP_GSCR_SII_POL 129
> +
> =C2=A0static int sata_pmp_configure(struct ata_device *dev, int print=
_info)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ata_port *ap =3D dev->link->ap;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *gscr =3D dev->gscr;
> + =C2=A0 =C2=A0 =C2=A0 u16 vendor =3D sata_pmp_gscr_vendor(gscr);
> + =C2=A0 =C2=A0 =C2=A0 u16 devid =3D sata_pmp_gscr_devid(gscr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int err_mask =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reason;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr_ports, rc;
> @@ -260,12 +264,34 @@ static int sata_pmp_configure(struct ata_device
> *dev, int print_info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 /* Disable sending Early R_OK.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* With "cached read" HDD testing and mul=
tiple ports busy on a SATA
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* host controller, 3726 PMP will very ra=
rely drop a deferred
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* R_OK that was intended for the host. S=
ymptom will be all
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 5 drives under test will timeout, get =
reset, and recover.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (vendor =3D=3D 0x1095 && devid =3D=3D 0x372=
6) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 reg;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_mask =3D sata_=
pmp_read(&ap->link, PMP_GSCR_SII_POL, &reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err_mask) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rc =3D -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reason =3D "failed to read Sil3726 Private Register";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto fail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg &=3D ~0x1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_mask =3D sata_=
pmp_write(&ap->link, PMP_GSCR_SII_POL, reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err_mask) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rc =3D -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reason =3D "failed to write Sil3726 Private Register";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto fail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (print_info) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ata_dev_printk=
(dev, KERN_INFO, "Port Multiplier %s, "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "0x%04x:0x%04x r%d, %d ports, feat =
0x%x/0x%x\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sata_pmp_spec_rev_str(gscr),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sata_pmp_gscr_vendor(gscr),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sata_pmp_gscr_devid(gscr),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sata_pmp_spec_rev_str(gscr), vendor,=
 devid,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sata_pmp_gscr_rev(gscr),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_ports, gscr[SATA_PMP_GSCR_FEAT_E=
N],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gscr[SATA_PMP_GSCR_FEAT]);
>
