From: Mark Lord <liml@rtr.ca>
Subject: Re: Add one more HITACHI SATA disk to NCQ blacklist
Date: Thu, 31 Jan 2008 12:21:56 -0500
Message-ID: <47A203B4.8020902@rtr.ca>
References: <1201797194.7165.13.camel@user-computer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1233 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545AbYAaRWB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jan 2008 12:22:01 -0500
In-Reply-To: <1201797194.7165.13.camel@user-computer>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simos Xenitellis <simos.lists@googlemail.com>
Cc: linux-ide@vger.kernel.org

Simos Xenitellis wrote:
> Hi,
> The hard disk with 
> 	model num: "HITACHI HTS541616J9SA00"
> 	model rev: "SB4IC7UP"
> 
> is causing NCQ errors and should be blacklisted.
> Currently the blacklist for Hitachi hard disks includes
> 
> 	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
> 	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
> ...
> 	/* Blacklist entries taken from Silicon Image 3124/3132
> 	   Windows driver .inf file - also several Linux problem reports */
> 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
> 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
> 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
> 
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=drivers/ata/libata-core.c;hb=HEAD
> 
> The same hard disk causing NCQ errors to different users,
> http://www.nabble.com/hdparm--B-1-and-Load_Cycle-on-Hitachi-HTS541616J9SA00-td14702758.html
..

Those first two "references" above look totally bogus -- they have nothing to do with NCQ.

> https://bugs.edge.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470
..

That one is for 2.6.22.  We need to know if the problem exists with 2.6.24,
as the NCQ code has had a number of fixes since July 2007.

Also, more information about the hardware involved would be useful.
An NCQ bug could be due to the SATA chipset more than the drive,
or perhaps only the combination of the two.

Cheers


> Could you please add the entry
> 	{ "HITACHI HTS541616J9SA00",    NULL,     ATA_HORKAGE_NONCQ, },
> 
> Simos
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

