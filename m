From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 15:39:46 -0700
Message-ID: <E1Eoq94-00009u-SS@highlab.com>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ecae158-153-dhcp.colorado.edu ([128.138.158.153]:51174 "EHLO
	highlab.com") by vger.kernel.org with ESMTP id S932135AbVLTWjW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 17:39:22 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1Eoq94-00009u-SS
	for linux-ide@vger.kernel.org; Tue, 20 Dec 2005 15:39:46 -0700
In-reply-to: <43A88218.1040205@physics.ucsd.edu> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Terrence Martin <tmartin@physics.ucsd.edu> wrote:
> Nope it appears I have the same problem, the system hangs on reboot with 
> rc5 as well as rc6.

Are you using Raids groups as PVs with LVM?  I'm seeing some hangs with
that configuration in 2.6.15-rc5.  I'm still chasing after it, might be
operator error...


-- 
Sebastian Kuzminsky
