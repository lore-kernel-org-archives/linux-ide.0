From: Marcus Meissner <meissner@suse.de>
Subject: sata_sil problem / oops
Date: Thu, 2 Jun 2005 12:03:58 +0200
Message-ID: <20050602100358.GA28855@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:40642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261360AbVFBKD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2005 06:03:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

We see a problem in the sata_sil driver. The code looks like this:

        cls=sil_get_device_cache_line(pdev);
        cls >>= 3;
        cls++;  /* cls = (line_size/8)+1 */
        writeb(cls, mmio_base + SIL_FIFO_R0);
        writeb(cls, mmio_base + SIL_FIFO_W0);
        writeb(cls, mmio_base + SIL_FIFO_R1);
        writeb(cls, mmio_base + SIL_FIFO_W2);

We have a device where mmio_base is only 0x200 byte long, so
the access to SIL_FIFO_W2 (offset 0x241) causes an Oops.

- Should it perhaps be W1 instead of W2?

- If not, does it need a range check?

sysfs PCI data:

 pci device: name = 0000:00:0a.0, bus_id = 0000:00:0a.0, bus = pci
    path = /devices/pci0000:00/0000:00:0a.0
    class = 0x10400
    vendor = 0x1095
    device = 0x3112
    subvendor = 0x1095
    subdevice = 0x6112
    irq = 5
    res[0] = 0xdc00 0xdc07 0x101
    res[1] = 0xd800 0xd803 0x101
    res[2] = 0xd400 0xd407 0x101
    res[3] = 0xd000 0xd003 0x101
    res[4] = 0xcc00 0xcc0f 0x101
    res[5] = 0xcffffe00 0xcfffffff 0x200
    res[6] = 0xcff00000 0xcff7ffff 0x7200
    config[64]

Ciao, Marcus

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCntmO6nvzlwF1Yj4RApmhAJ9BfkP2vc8DSlkLJdeiD90CpL6U0ACaAnt7
8scycXUnAsO9NiM/HJSPeqk=
=+rZ+
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
