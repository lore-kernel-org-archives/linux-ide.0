From: Jo Geraerts <jog@elex.be>
Subject: libata CHS mapping
Date: Tue, 28 Feb 2006 11:46:41 +0100
Message-ID: <44042A11.1060801@elex.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sarge.elex.be ([194.7.83.94]:52371 "EHLO mail.elex.be")
	by vger.kernel.org with ESMTP id S1751452AbWB1KrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 05:47:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear,

Somewhere in the libata code (ata_std_bios_param) the CHS mapping is hardcoded
to X/255/63. These values are incorrect on IBM thinkpad t43 (and probarly
others). We use unattended.sf.net to install our laptops. With these values it
resulted in a unbootable system.

When i recompiled the kernel with hardcoded values X/240/63 things worked smoothly.

Is it possible (probarly yes) or very timeconsuming to make these value
configurable through kernel parameters or maybe even better to ask the BIOS
about it's vision of the CHS mapping? My knowledge of kernel programming is not
sufficient enough to do it myself. Changing hardcoded values was already a
challenge ;)

Best regards,


jo




- --
Jo Geraerts
Network/System Administrator
jog@elex.be
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEBCoREdXgl9N9FMARApa5AJwLS7C+TuxvkqcUSgUahwh5M/j54QCfTapR
/TnUXEa2GvLIDNUTpDQwROU=
=0TaU
-----END PGP SIGNATURE-----
