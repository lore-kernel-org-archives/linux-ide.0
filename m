From: Valdis.Kletnieks@vt.edu
Subject: Re: [patch 3/4] Enable link power management for ata drivers
Date: Sat, 11 Aug 2007 00:58:49 -0400
Message-ID: <9122.1186808329@turing-police.cc.vt.edu>
References: <20070809211800.022150464@intel.com>
            <20070809142416.a110ba25.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1186808329_3018P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755150AbXHKE7Q@vger.kernel.org>
In-Reply-To: Your message of "Thu, 09 Aug 2007 14:24:16 PDT."
             <20070809142416.a110ba25.kristen.c.accardi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, htejun@gmail.com, akpm@linux-foundation.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--==_Exmh_1186808329_3018P
Content-Type: text/plain; charset=us-ascii

On Thu, 09 Aug 2007 14:24:16 PDT, Kristen Carlson Accardi said:
> +++ 2.6-git/drivers/ata/libata-scsi.c
> @@ -2904,6 +2976,52 @@ void ata_scsi_simulate(struct ata_device

> +		if ((dev->horkage & ATA_HORKAGE_IPM) ||
> +			!(dev->flags & ATA_DFLAG_IPM)) {
> +			ata_dev_printk(dev, KERN_ERR,
> +				"Unable to set Link PM policy\n");
> +			ap->pm_policy = MAX_PERFORMANCE;
> +		}

KERN_INFO please, or KERN_WARNING at the highest, at least until such time
as enough drivers support enough hardware that it really *does* qualify for
"this should not fail" status.

(OK, so I'm just cranky because I'm tired of seeing a KERN_ERR thrown at every
reboot, just because the ata_piix driver doesn't know how to set this stuff up
for the DVD?RW drive in my laptop.  But when this goes upstream, lots of
*other* people are going to get hit by the exact same thing and think there's
something actually *wrong* with their hardware.)

--==_Exmh_1186808329_3018P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFGvUIJcC3lWbTT17ARAhSfAJ9hzXj+RJxaN7P1v+QjUmlGwFy+VQCgibOk
b0thawrrkeq4YY2ZoP9HOU0=
=krIW
-----END PGP SIGNATURE-----

--==_Exmh_1186808329_3018P--
