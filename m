From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Fri, 04 Apr 2008 01:03:10 +0900
Message-ID: <47F4FFBE.8050800@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com> <47D03272.9080209@garzik.org> <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com> <47F42862.1030406@gmail.com> <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:39526 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbYDCQDR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 12:03:17 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2141359rng.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 09:03:16 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> IDER is a controller, in this case, in the MCH/Northbridge that
> redirects a virtual drive across the LAN and presents it as a local IDE
> drive.  This is part of the Intel AMT managability engine.  You can
> point it to a physical drive, .iso or a .img file on the remote system.

Ah... fancy.  You can just make it PATA if doesn't have SCR access and 
supports slave device and use ata_cable_unknown() for ->cbl_detect.

-- 
tejun
