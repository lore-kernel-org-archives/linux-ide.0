From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 0/2] pata-platform configuration changes / Remove bast-ide
Date: Mon, 16 Jun 2008 12:16:25 +0100
Message-ID: <20080616111625.145158959@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:63525 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750868AbYFPLZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 07:25:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, bzolnier@gmail.com

With libata's pata-platform support being merged, look at removing
the old bast-ide driver as this can now be done by registering a
pair of platform devices in the relevant machine support file.

As an addition, introduct HAVE_PATA_PLATFORM to allow any platform
or machine that uses this support to define their use of this
without having to explicitly enable CONFIG_EMBEDDED or add numerous
enabling statements into drivers/ata/Kconfig.

For an example, this is the update that will happen to the relevant
Kconfig for the "Simtec Anubis" machine:

--- linux-2.6.26-rc3-quilt1.orig/arch/arm/mach-s3c2440/Kconfig
+++ linux-2.6.26-rc3-quilt1/arch/arm/mach-s3c2440/Kconfig
@@ -29,6 +29,7 @@ config MACH_ANUBIS
        bool "Simtec Electronics ANUBIS"
        select CPU_S3C2440
        select PM_SIMTEC if PM
+       select HAVE_PATA_PLATFORM
        help
          Say Y here if you are using the Simtec Electronics ANUBIS
          development system


These two patches do not update the PATA_PLATFORM to remove the
current 'depends on' lines as these require syncronisation with
the relevant maintainers, so I propose these be submitted once
the HAVE_PATA_PLATFORM is merged. This means the sequence is
merge the HAVE_PATA_PLATFORM Kconfig changes, then send the
updates to use it to each maintainer. Onces these are merged
it is then possible to remove the other 'depends on' items from
the Kconfig without damaging architecture or machine support.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
