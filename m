From: Kodandaram Harish-ahk026 <harish@motorola.com>
Subject: SATA Coldplug operation
Date: Mon, 23 May 2005 13:03:46 +0530
Message-ID: <772BCEF88A1DD91191F80011856715F303377229@zin24exm01.ap.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from motgate8.mot.com ([129.188.136.8]:41390 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261860AbVEWHeC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 03:34:02 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate7) with ESMTP id j4N7fmP7014426
	for <linux-ide@vger.kernel.org>; Mon, 23 May 2005 00:41:49 -0700 (MST)
Received: from zin24exm01.ap.mot.com (zin24exm01.ap.mot.com [10.232.25.1])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id j4N7b2P4013862
	for <linux-ide@vger.kernel.org>; Mon, 23 May 2005 02:37:03 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello All,

I am using Intel based board with ICH5 as south bridge. A SATA disk is
connected to it and I have requirement to support hot plug for SATA disk.

In reference to SATA status report in
http://linux.yyz.us/sata/software-status.html	Hotplug Support I need few
clarifications:

1. Does Coldplug operation is limited to removal of device or even cold
insertion is possible.
2. With Coldplug operation do you mean the already connected drive can be
powered ON or OFF or its just that kernel is not aware of disk but hardware
wise the disk is connected.
3. Does Coldplug operation effects any other devices connected to ICH5.
4. Does coldplug operation is supported in 2.4 kernel and what is the
procedure to see it working

Thanks in advance.
Regards,
Harish
Motorola Inc.
Phone: 080-51364676
Mobile: 9448346311

