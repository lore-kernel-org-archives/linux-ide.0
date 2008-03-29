From: Tejun Heo <htejun@gmail.com>
Subject: Re: nVidia MCP55 SATA hotplug support?
Date: Sat, 29 Mar 2008 21:14:03 +0900
Message-ID: <47EE328B.9030000@gmail.com>
References: <47D698C8.2020206@aquazul.com> <loom.20080313T211921-877@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1591 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYC2MOM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 08:14:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so844786wah.23
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 05:14:12 -0700 (PDT)
In-Reply-To: <loom.20080313T211921-877@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Spindler <csp@inode.at>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Christian Spindler wrote:
> My hardware is:
> 
> 00:0e.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 00:0e.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 00:0e.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 
> And hotplug does not work, too.
> 
> 
> chrisi@mars:~$ lsmod | grep sata
> sata_sil24             15236  0 
> sata_nv                20612  2 
> libata                125168  3 sata_sil24,sata_nv,ata_generic
> 
> 
> There are no info in dmesg wenn plug or un-plug a drive.
> On Windows hotplug works.
> 
> Does anybody knows hot to activate hotplug?

sata_nv.swncq=1 will get you the hotplug interrupts along with NCQ 
support.  It might not be completely stable tho.

-- 
tejun
