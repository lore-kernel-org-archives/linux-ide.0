From: Simon Guinot <simon@sequanux.org>
Subject: hotplug issue with PM JMB350 rev B
Date: Wed, 21 Sep 2011 11:23:13 +0000
Message-ID: <20110921112313.GI1215@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vm1.sequanux.org ([188.165.36.56]:58003 "EHLO vm1.sequanux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab1IUL2f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Sep 2011 07:28:35 -0400
Received: from localhost (softwrestling.org [188.165.144.248])
	by vm1.sequanux.org (Postfix) with ESMTPSA id 4303110810E
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2011 13:22:16 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have recently discovered a disk unplug issue with the port multiplier
JMB350 revision B. This PM is embedded on the net2big_v2 machines (based
on a ARM Marvell SoC, Kirkwood 6281). I use a Linux kernel v3.1-rc5 and
the SATA driver is sata_mv.

After a disk unplug, the PM became quickly unresponsive and a board
power-off is needed to recover. Reset the board is not enough. I suspect
the PM firmware (v0.7.9) from being bugged. On the previous net2big_v2
boards, a JMB350 rev A is embedded and disk unplug is well supported.

Here are some ATA debug traces when a disk is unplugged and replugged:

[   13.810409] ata1: SATA link down (SStatus 0 SControl F300)
[   14.520406] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
[   14.527462] ata2.15: Port Multiplier 1.1, 0x197b:0x2352 r1, 2 ports, feat 0x0/0x8
[   14.540837] ata2.00: hard resetting link
[   14.931100] ata2.01: hard resetting link
[   15.560436] ata2.00: ATA-8: Hitachi HDS722020ALA330, JKAOA28A, max UDMA/133
[   15.567365] ata2.00: 3907029168 sectors, multi 0: LBA48
[   15.630438] ata2.00: configured for UDMA/133
[   15.634894] ata2: EH complete
[   15.650684] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
[   15.659541] sd 1:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[   15.667563] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   15.673111] sd 1:0:0:0: [sda] Write Protect is off
[   15.678225] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.730269]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[   15.736738] sd 1:0:0:0: [sda] Attached SCSI disk

>>> unplug <<<

[   59.937370] mv_err_intr, edma_err_cause=00000100
[   59.941971] mv_err_intr, fis_cause=00008200
[   59.980438] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x190000 action 0xf
[   59.987379] ata2.00: SError: { PHYRdyChg 10B8B Dispar }
[   60.030434] ata2.00: hard resetting link
[   60.500356] mv_err_intr, edma_err_cause=00000020
[   60.504985] ata2.00: failed to read SCR 0 (Emask=0x40)
[   60.510103] ata2.00: COMRESET failed (errno=-5)
[   60.514629] ata2.00: failed to read SCR 0 (Emask=0x40)
[   60.519745] ata2.00: reset failed, giving up
[   60.524013] ata2.15: hard resetting link
[   60.870402] ata2.15: SATA link down (SStatus 0 SControl F300)
[   60.917000] ata2.15: failed to read PMP GSCR[0] (Emask=0x3)
[   60.922565] ata2.15: PMP revalidation failed (errno=-5)
[   65.870400] ata2.15: hard resetting link
[   66.220401] ata2.15: SATA link down (SStatus 0 SControl F300)
[   66.266985] ata2.15: failed to read PMP GSCR[0] (Emask=0x3)
[   66.272549] ata2.15: PMP revalidation failed (errno=-5)
[   66.277753] ata2.15: limiting SATA link speed to 1.5 Gbps
[   71.220401] ata2.15: hard resetting link
[   71.570400] ata2.15: SATA link down (SStatus 0 SControl F310)
[   71.616997] ata2.15: failed to read PMP GSCR[0] (Emask=0x3)
[   71.622558] ata2.15: PMP revalidation failed (errno=-5)
[   76.570477] ata2.15: hard resetting link
[   76.920396] ata2.15: SATA link down (SStatus 0 SControl F310)
[   76.966982] ata2.15: failed to read PMP GSCR[0] (Emask=0x3)
[   76.972541] ata2.15: PMP revalidation failed (errno=-5)
[   81.920402] ata2.15: hard resetting link
[   82.270401] ata2.15: SATA link down (SStatus 0 SControl F310)
[   82.316981] ata2.15: failed to read PMP GSCR[0] (Emask=0x3)
[   82.322541] ata2.15: PMP revalidation failed (errno=-5)
[   82.327744] ata2.15: failed to recover PMP after 5 tries, giving up
[   82.333995] ata2.15: Port Multiplier detaching
[   82.338415] ata2.00: disabled
[   82.341386] ata2.00: disabled
[   82.344359] ata2: hard resetting link
[   82.690400] ata2: SATA link down (SStatus 0 SControl F310)
[   82.695874] ata2: EH complete
[   82.698833] ata2.00: detaching (SCSI 1:0:0:0)
[   82.710680] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   82.716289] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
[   82.722771] sd 1:0:0:0: [sda] Stopping disk
[   82.726969] sd 1:0:0:0: [sda] START_STOP FAILED
[   82.731511] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00

>>> plug <<<

[  101.545177] mv_err_intr, edma_err_cause=00000010
[  101.549815] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[  101.557219] ata2: edma_err_cause=00000010 pp_flags=00000000, dev connect
[  101.563911] ata2: SError: { PHYRdyChg DevExch }
[  101.568438] ata2: hard resetting link
[  107.520398] ata2: link is slow to respond, please be patient (ready=0)
[  111.600395] ata2: SRST failed (errno=-16)
[  111.604386] ata2: hard resetting link
[  117.550396] ata2: link is slow to respond, please be patient (ready=0)
[  121.630394] ata2: SRST failed (errno=-16)
[  121.634388] ata2: hard resetting link
[  127.580395] ata2: link is slow to respond, please be patient (ready=0)
[  156.680395] ata2: SRST failed (errno=-16)
[  156.684389] ata2: limiting SATA link speed to 1.5 Gbps
[  156.689502] ata2: hard resetting link
[  161.740408] ata2: SRST failed (errno=-16)
[  161.744405] ata2: reset failed, giving up
[  161.748400] ata2: EH complete

The only workaround I found is reseting the PM when an asynchronous
notification is received. Here is a patch example:

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 4b6b209..7d68db9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2644,14 +2644,23 @@ static void mv_err_intr(struct ata_port *ap)
        ata_ehi_clear_desc(ehi);
        ata_ehi_push_desc(ehi, "edma_err_cause=%08x pp_flags=%08x",
                          edma_err_cause, pp->pp_flags);
-
        if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
                ata_ehi_push_desc(ehi, "fis_cause=%08x", fis_cause);
                if (fis_cause & FIS_IRQ_CAUSE_AN) {
                        u32 ec = edma_err_cause &
                               ~(EDMA_ERR_TRANS_IRQ_7 | EDMA_ERR_IRQ_TRANSIENT);
+                       u32 *gscr = ap->link.device->gscr;
+
                        sata_async_notification(ap);
-                       if (!ec)
+
+                       /* Handle AN for JMB350 */
+                       if (sata_pmp_attached(ap) &&
+                           sata_pmp_gscr_vendor(gscr) == 0x197b &&
+                           sata_pmp_gscr_devid(gscr) == 0x2352) {
+                               err_mask |= AC_ERR_DEV;
+                               action |= ATA_EH_RESET;
+                               ata_ehi_push_desc(ehi, "JMB350 AN");
+                       } else if (!ec)
                                return; /* Just an AN; no need for the nukes */
                        ata_ehi_push_desc(ehi, "SDB notify");
                }

At this point, I need to find a workaround good enough for mainline.

Any hints or advices are welcome.

Thanks in advance,

Simon

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk55ySEACgkQgtp0PDeOcDqK2wCfVcGHr4cDfsnGDe2A40amfW7a
EbAAniIbDHM4kIAqU+Rlb8pw5F200gcH
=48jr
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
