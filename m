From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Fri, 5 Feb 2010 09:48:17 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1002050934430.7774@p34.internal.lan>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:55342 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766Ab0BEOsR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2010 09:48:17 -0500
In-Reply-To: <4B6C2BC8.7000609@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org



On Fri, 5 Feb 2010, Tim Small wrote:

> Justin Piszcz wrote:
>> I have seen people report similar problems with the following drives:
>> 
>> 1 - Velociraptors (me/others) (don't work at all in raid correctly)
>> http://forums.storagereview.com/index.php/topic/27303-velociraptor-premature-failure-rate-bad-drives-premature-to-market/ 
>> 2 - Green Drives (search this list, there are similar problems) in Linux.
>> 
>> I have Caviar Black and WD RE3, they work OK in Linux.
>
> OK, but:
>
> 1. Unlike the link you sent, there's nothing suspicious in any of the SMART 
> attributes on any of the four drives - no bad sectors or other errors i.e. 
> the following raw values are all zero on the WD drive which I've been 
> stressing:
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

Hi,

They seem to have this problem with and without errors, but you should 
run (from a boot cd) for the last one (or from a recovery image) if you have
console access.

1. smartctl -t short
2. smartctl -t long
3. smartctl -t offline # and don't touch the host/machine for the amount
                        # of time it recommends
4. then show smartctl -a output

The obvious things are:

1. Try/ask to get the cables replaced/check connectors.
2. Check to make sure the PSU is ok (w/ lm sensors etc)

--

When these error occur and/or when you reboot do you ever notice any 
corruption or files in /lost+found?

--

Does it happen if you leave the drives alone (do not poll them with smart?)

--

Some other misc/info that seems like it might be useful:

http://www.newegg.com/Product/ProductReview.aspx?Item=22-136-351&SortField=0&SummaryType=0&Pagesize=10&SelectedRating=-1&PurchaseMark=&VideoOnlyMark=False&VendorMark=&Page=1&Keywords=linux

Cons: WD changed the firmware Oct 2009 to disable SCT ERC (Error Recovery Control). These drives are desktop drives that have a 2 minute ERC setting. Most hardware RAID controllers require a maximum of 7 seconds ERC or your drives will be kicked out of RAID array if it takes too long to recover a sector. Note the RAID controller can recovery the troubled sector itself from the parity disk so it doesn't need the drives to try very hard to recover. This timing is the main difference between RAID drives and desktop drives. Prior to Oct 2009 you could use a WD (leaked) utility to enable the WD equivalent of ERC (called TLER - Time Limited Error Recovery) that would then set the recovery timer to 7 seconds. On the newer drives, you should only use them as desktop drives.

Other Thoughts: In addition, the green feature of the drive parks the head very often (every 8 seconds I think). If you use the drive as a Linux OS drive, chances are the drive head will be parked/unparked so often that it will exceed the rated 300,000 load cycles in less than a year. There is another WD (leaked) utility that allows you to set the park timer from 8 seconds to a maximum of 5 minutes. It uses a little more power but prolongs the drive life span. If you use the drive mainly as storage, then there should be nothing to worry about.

Are you using them in raid or as a single disk?

http://doug.warner.fm/d/blog/2009/11/Western-Digital-15TB-Green-Drives-Not-your-Linux-Software-RAID

I'm not sure what to do with these WD drives; while they seem to work fine independantly, they don't perform correctly at all when put into a RAID array.  I'm beginning to get afraid that as the hard drives get larger and larger the complexity of the firmware is growing too quickly for drive manufacterers to keep them performing reliably.


