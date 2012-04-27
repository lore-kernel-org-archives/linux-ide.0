From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Support for 4 KiB disk sectors in Linux kernel
Date: Fri, 27 Apr 2012 14:30:44 +0200
Message-ID: <4F9A9174.3050204@fold.natur.cuni.cz>
References: <4F9170FB.7080208@intel.com> <yq17gxa1iwc.fsf@sermon.lab.mkp.net> <4F919B55.2020802@fold.natur.cuni.cz> <D9FFE20C522965449E182ACE73889AEB1860718E@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:40008 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753026Ab2D0Ma4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Apr 2012 08:30:56 -0400
In-Reply-To: <D9FFE20C522965449E182ACE73889AEB1860718E@IRSMSX101.ger.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Dorau, Lukasz wrote:
> On Friday, April 20, 2012 7:22 PM Martin Mokrejs wrote:
>>
>> Martin K. Petersen wrote:
>>>>>>>> "Lukasz" == Lukasz Dorau <lukasz.dorau@intel.com> writes:
>>>
>>> Lukasz> Where can I find information about current status of support for
>>> Lukasz> 4 KiB disk sectors in Linux kernel?  Is there a
>>> Lukasz> leader/maintainer of this issue in community?
>>>
>>> We have supported 4Kn for a decade. 512e obviously works out of the
>>> box. However, filesystem/partition/DM tooling has been updated to align
>>> correctly on 512e devices.
>>>
> 
> Does it mean that I can just plug the 4K HDD in and it will work without making any changes in kernel?

Yes, only make sure you have recent enough fdisk/gdisk or other partition
manager and make first partition start at sector 2048 (instead of former
default start sector 63) to be sure you will have no alignment issues.

If you use EFI partition instead of the MS-DOS type which cannot span 2TB
drives already, you will need CONFIG_EFI_PARTITION=y and gdisk installed
and forget about fdisk.
Martin


> 
> Lukasz
> 
>>> See:
>>>
>>> 	http://oss.oracle.com/~mkp/docs/linux-advanced-storage.pdf
>>
>> Also:
>>
>> https://ata.wiki.kernel.org/articles/a/t/a/ATA_4_KiB_sector_issues_d4b8.ht
>> ml
>> http://sourceforge.net/apps/mediawiki/bootinfoscript/index.php?title=Boot
>> _Problems:Windows_Writes_To_MBR
>> https://help.ubuntu.com/community/Grub2
>>
>>
>> I agree there is nothing about under Documentation/ in kernel sources, at
>> least
>> from users point of view.
>> Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
