From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Fri, 05 Feb 2010 16:47:31 -0500
Message-ID: <4B6C91F3.5090809@teksavvy.com>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:9110 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933322Ab0BEVrf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2010 16:47:35 -0500
In-Reply-To: <4B6C2BC8.7000609@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Tim Small wrote:
> Justin Piszcz wrote:
>> I have seen people report similar problems with the following drives:
>>
>> 1 - Velociraptors (me/others) (don't work at all in raid correctly)
>> http://forums.storagereview.com/index.php/topic/27303-velociraptor-premature-failure-rate-bad-drives-premature-to-market/ 
>>
>> 2 - Green Drives (search this list, there are similar problems) in Linux.
>>
>> I have Caviar Black and WD RE3, they work OK in Linux.
> 
> OK, but:
> 
> 1. Unlike the link you sent, there's nothing suspicious in any of the 
> SMART attributes on any of the four drives - no bad sectors or other 
> errors i.e. the following raw values are all zero on the WD drive which 
> I've been stressing:
> 
> Raw_Read_Error_Rate
> Reallocated_Sector_Ct
> Seek_Error_Rate
> Spin_Retry_Count
> Calibration_Retry_Count
> Reallocated_Event_Count
> Current_Pending_Sector
> Offline_Uncorrectable
> UDMA_CRC_Error_Count
> Multi_Zone_Error_Rate
> 
> ... as well as empty SMART errors logs.
> 
> 
> 2. A few failures were seen with the Seagate drives as well (see last 
> bits of the email), similarly with no apparent bad SMART attributes.
..

I have observed (and reported) the same issue in the past,
on Hitachi and Seagate drives.

The only constants seem to be libata and ICH7/8.
We must have a bug somewhere in there.

-ml
