From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: apparently missing test of CONFIG_PATA_WINBOND_VLB in drivers/ata
Date: Thu, 28 Oct 2010 08:50:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1010280848050.4880@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:46132 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0J2EOe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2010 00:14:34 -0400
Received: from cpec03f0ed089ed-cm001ac318e826.cpe.net.cable.rogers.com ([174.113.188.199] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1PBRw5-0002Et-E4
	for linux-ide@vger.kernel.org; Thu, 28 Oct 2010 08:50:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


  my scanning script picked up the following in drivers/ata

$ grep -r PATA_WINBOND *
Kconfig:config PATA_WINBOND
Kconfig:config PATA_WINBOND_VLB
Makefile:obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
pata_legacy.c:#ifdef PATA_WINBOND_VLB_MODULE
$

  first, that test in pata_legacy.c should be for "CONFIG_...", should
it not?  and there doesn't appear to be any test for just
CONFIG_PATA_WINBOND_VLB.  i'll leave it with someone here to figure
out what needs to be tweaked.

rday

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
