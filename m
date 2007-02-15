From: Florin Andrei <florin@andrei.myip.org>
Subject: SiI 3114 and sata_sil
Date: Thu, 15 Feb 2007 10:31:33 -0800
Message-ID: <45D4A705.4050407@andrei.myip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:39873 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030500AbXBOSi0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 13:38:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

(I'm not subscribed to linux-ide)

I've two almost identical systems (slightly different CPUs) that use SiI 
3114 for SATA and RAID.

One of them was installed a while ago with Fedora Core 5 (kernel 
2.6.15-1.2054_FC5smp) and whoever installed it was able to turn on 
hardware RAID.

The other was installed with CentOS 4.4 (kernel 2.6.9-42.0.8.ELsmp) by 
myself. I tried many different things, but I couldn't activate RAID. The 
installer was always seeing two separate drives instead of one RAID volume.

Is this caused by the sata_sil driver? Is the version used by CentOS too 
old to support RAID?

BTW, on Fedora 5, how do I monitor the status of the RAID arrays? There 
doesn't seem to be anything in /proc to provide that info.

Thanks,

-- 
Florin Andrei

http://florin.myip.org/
