From: Kurt Newman <knewman@globaldataguard.com>
Subject: Re: aic94xx and the adaptec sata raid controller (aic-9410)
Date: Thu, 27 Aug 2009 10:06:44 -0500
Message-ID: <4A96A104.6060709@globaldataguard.com>
References: <4A956C59.2010709@globaldataguard.com> <4A95F38F.9060509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.globaldataguard.com ([67.210.231.115]:51303 "EHLO
	mail2.globaldataguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbZH0PGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Aug 2009 11:06:21 -0400
In-Reply-To: <4A95F38F.9060509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 08/26/2009 11:09 AM, Kurt Newman wrote:
>> My question is:
>> Does the aic94xx driver enable the use of the Adaptec SATA Raid
>> functionality, such that, I'm able to see a single "raided" drive,
>> instead of multiple, individual ones.
>>
>> Background information:
>> Thus far, loading the aic94xx module simply says:
>> "aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2-2 loaded".
>>
>> However, beyond that message and several /sys entries added, I'm unable
>> to access the raid-1 "drive" created by the adaptec utility.  With or
>> without that driver loaded, I still only have access to each individual
>> drive (/dev/sda and /dev/sdb) using ata_piix.
> 
> ata_piix will be for an Intel integrated chipset SATA controller, not an
> aic94xx. Are you sure the drives are actually hooked up through the
> Adaptec controller?
> 

Yes.  I can use the Adaptec bios utility to create a mirror and spend
the hour (or so) to synchronize them.
