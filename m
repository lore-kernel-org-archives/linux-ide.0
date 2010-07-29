From: "Wainschenker Nicolas" <nwainschenker@ort.edu.ar>
Subject: ESXi Sil3512 Compatibility
Date: Wed, 28 Jul 2010 23:43:07 -0300
Message-ID: <20100729023913.M52441@ort.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ort.edu.ar ([201.253.103.3]:42354 "EHLO ort.edu.ar"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751838Ab0G2Dgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jul 2010 23:36:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello, my name is Nicolas, im from Argentina. Im doing some testings with 
ESXi 3.5 and 4.1. i saw that the Silicon Imagen 3512 Sata Controller 
is "supported" by these Hypervisors. At least its in the HCL (Hardware 
Compatibility List). The thing is that i make the LUN (RAID1) with 2x1tb WD 
Drives but when im installing those hypervisors i see the both of the disks 
and no LUNs.

i would like to know if you have any solution for this.

Thanks.
Sorry for my low skill in english.

Nicolas D. Wainschenker.
