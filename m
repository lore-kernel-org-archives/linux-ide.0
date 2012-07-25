From: Michael Eitelwein <michael@eitelwein.net>
Subject: whitelist entry for device with known good pata-sata bridge
Date: Wed, 25 Jul 2012 16:49:32 +0200
Message-ID: <5010077C.5050509@eitelwein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out.selfhost.de ([82.98.82.95]:47725 "EHLO outgoing.selfhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964774Ab2GYO4Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2012 10:56:16 -0400
Received: from localhost (kvm-mta.eitelwein.net [192.168.123.208])
	by mail.eitelwein.net (Postfix) with ESMTP id CC8C332689
	for <linux-ide@vger.kernel.org>; Wed, 25 Jul 2012 16:49:32 +0200 (CEST)
Received: from mail.eitelwein.net ([127.0.0.1])
	by localhost (vscan.eitelwein.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYKyDpaJ1s2k for <linux-ide@vger.kernel.org>;
	Wed, 25 Jul 2012 16:49:32 +0200 (CEST)
Received: from [IPv6:2001:4dd0:ff00:89e5:f138:5c9a:fb3f:6095] (unknown [IPv6:2001:4dd0:ff00:89e5:f138:5c9a:fb3f:6095])
	by mail.eitelwein.net (Postfix) with ESMTPSA id 7408C32247
	for <linux-ide@vger.kernel.org>; Wed, 25 Jul 2012 16:49:32 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I have an external SATA drive that was slowed down by bridge limits. I
found a solution in a thread on this list posted in 2008: It introduces
whitelist entries in libata-core.c for devices with well working bridges
(e.g. email on Fri, 31 Oct 2008 01:45:27 -0400).

I added my device to this whitelist in a custom built kernel and it
works fine for weeks now. How can I have this device added on the
whitelist within the official kernel? Is this whitelist mechanism still
supported or is there a smarter way to achieve whitelisting?

I added the following whitelist entry for my Buffalo DriveStation
Quattro "BUFFALO HD-QSU2/R5":

        /* Devices that do not need bridging limits applied */
        { "MTRON MSP-SATA*",            NULL,   ATA_HORKAGE_BRIDGE_OK, },
        { "BUFFALO HD-QSU2/R5",         NULL,   ATA_HORKAGE_BRIDGE_OK, },

Regards

Michael

