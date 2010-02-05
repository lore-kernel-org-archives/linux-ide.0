From: Tim Small <tim@buttersideup.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Fri, 05 Feb 2010 14:31:36 +0000
Message-ID: <4B6C2BC8.7000609@buttersideup.com>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:46900 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab0BEObs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2010 09:31:48 -0500
In-Reply-To: <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Justin Piszcz wrote:
> I have seen people report similar problems with the following drives:
>
> 1 - Velociraptors (me/others) (don't work at all in raid correctly)
> http://forums.storagereview.com/index.php/topic/27303-velociraptor-premature-failure-rate-bad-drives-premature-to-market/ 
>
> 2 - Green Drives (search this list, there are similar problems) in Linux.
>
> I have Caviar Black and WD RE3, they work OK in Linux.

OK, but:

1. Unlike the link you sent, there's nothing suspicious in any of the 
SMART attributes on any of the four drives - no bad sectors or other 
errors i.e. the following raw values are all zero on the WD drive which 
I've been stressing:

Raw_Read_Error_Rate
Reallocated_Sector_Ct
Seek_Error_Rate
Spin_Retry_Count
Calibration_Retry_Count
Reallocated_Event_Count
Current_Pending_Sector
Offline_Uncorrectable
UDMA_CRC_Error_Count
Multi_Zone_Error_Rate

... as well as empty SMART errors logs.


2. A few failures were seen with the Seagate drives as well (see last 
bits of the email), similarly with no apparent bad SMART attributes.


Thanks,

Tim.
