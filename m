From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Tue, 9 Mar 2010 09:13:18 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1003090906450.9819@uplift.swm.pp.se>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:55360 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab0CIINT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 03:13:19 -0500
In-Reply-To: <4B96013F.1050904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

On Tue, 9 Mar 2010, Tejun Heo wrote:

> How fast does it increase?  ie. counts / hour.

I can confirm this, and it seems to differ between different firmware 
versions and WD20-models:

# smartctl -a /dev/sdc | egrep 
'Power_On_Hours|Load_Cycle_Count|Device|Firmware'
Device Model:     WDC WD20EADS-32S2B0
Firmware Version: 01.00A01
Device is:        Not in smartctl database [for details use: -P showall]
   9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       905
193 Load_Cycle_Count        0x0032   193   193   000    Old_age   Always       -       22562
# smartctl -a /dev/sdd | egrep 
'Power_On_Hours|Load_Cycle_Count|Device|Firmware'
Device Model:     WDC WD20EADS-32S2B0
Firmware Version: 01.00A01
Device is:        Not in smartctl database [for details use: -P showall]
   9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       919
193 Load_Cycle_Count        0x0032   193   193   000    Old_age   Always       -       22520
# smartctl -a /dev/sde | egrep 'Power_On_Hours|Load_Cycle_Count|Device|Firmware'
Device Model:     WDC WD20EADS-00R6B0
Firmware Version: 01.00A01
Device is:        Not in smartctl database [for details use: -P showall]
   9 Power_On_Hours          0x0032   089   089   000    Old_age   Always       -       8581
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       45
# smartctl -a /dev/sdf | egrep 'Power_On_Hours|Load_Cycle_Count|Device|Firmware'
Device Model:     WDC WD20EADS-00R6B0
Firmware Version: 01.00A01
Device is:        Not in smartctl database [for details use: -P showall]
   9 Power_On_Hours          0x0032   092   092   000    Old_age   Always       -       5849
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       30
# smartctl -a /dev/sdg | egrep 'Power_On_Hours|Load_Cycle_Count|Device|Firmware'
Device Model:     WDC WD20EARS-00S8B1
Firmware Version: 80.00A80
Device is:        Not in smartctl database [for details use: -P showall]
   9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       760
193 Load_Cycle_Count        0x0032   195   195   000    Old_age   Always       -       16615


-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
