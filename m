From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: is there a value to CONFIG_NO_ATA_LEGACY?
Date: Sun, 10 Feb 2008 14:44:16 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101442240.14742@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:39481 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYBJToZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 14:44:25 -0500
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com ([99.235.212.34] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1JOI6A-0005nw-WE
	for linux-ide@vger.kernel.org; Sun, 10 Feb 2008 14:44:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


  in drivers/ata/libata-sff.c:

...
#if defined(CONFIG_NO_ATA_LEGACY)
                /* Some platforms with PCI limits cannot address compat
                   port space. In that case we punt if their firmware has
                   left a device in compatibility mode */
                if (legacy_mode) {
                        printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
                        return -EOPNOTSUPP;
                }
#endif
...

  there is no Kconfig file that defines that variable -- should that
test be removed?  or is something eventually coming that defines it?

rday
--
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
========================================================================
