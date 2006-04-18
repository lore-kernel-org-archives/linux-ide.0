From: Frido Ferdinand <frido@zolder.org>
Subject: PIIX libata ?
Date: Tue, 18 Apr 2006 13:59:05 +0000 (UTC)
Message-ID: <loom.20060418T155655-644@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:4260 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932137AbWDROPT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Apr 2006 10:15:19 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FVqys-0003oB-Bg
	for linux-ide@vger.kernel.org; Tue, 18 Apr 2006 16:15:02 +0200
Received: from office.isp-services.nl ([212.79.224.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Apr 2006 16:15:02 +0200
Received: from frido by office.isp-services.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Apr 2006 16:15:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

How can i see that PIIX is either from libata or the usual IDE drivers. I have
both enabled in the kernel but not sure which takes presedence, will the drives
show up as /dev/sda ? disks used are non-sata/normal ide disks.

Regards,

Frido

