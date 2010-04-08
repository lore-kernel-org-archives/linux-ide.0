From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 10:36:46 -0300
Message-ID: <eo2197-4lb.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50483 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab0DHNh0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 09:37:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1Nzrv5-0005VC-QE
	for linux-ide@vger.kernel.org; Thu, 08 Apr 2010 15:37:19 +0200
Received: from 189.62.197.41 ([189.62.197.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 15:37:19 +0200
Received: from fragabr by 189.62.197.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 15:37:19 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

	I'm using Linux 2.6.33 and MSI X58 Pro-E motherboard which have
the following SATA controller:

00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA
AHCI Controller

	But if I use just the following kernel option:

<*>   AHCI SATA support

	it will not be able to mount the root device.

	So I have to use:

[*]   ATA SFF support
<*>     Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support

	What's wrong here? I mean, I would like to use just AHCI and
get rid of this legacy SFF interface.

	Hints? Thanks.

-- 
Linux 2.6.33: Man-Eating Seals of Antiquity


