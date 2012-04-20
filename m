From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Support for 4 KiB disk sectors in Linux kernel
Date: Fri, 20 Apr 2012 19:22:29 +0200
Message-ID: <4F919B55.2020802@fold.natur.cuni.cz>
References: <4F9170FB.7080208@intel.com> <yq17gxa1iwc.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:32788 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753310Ab2DTRTY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 13:19:24 -0400
In-Reply-To: <yq17gxa1iwc.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Lukasz Dorau <lukasz.dorau@intel.com>, linux-ide@vger.kernel.org

Martin K. Petersen wrote:
>>>>>> "Lukasz" == Lukasz Dorau <lukasz.dorau@intel.com> writes:
> 
> Lukasz> Where can I find information about current status of support for
> Lukasz> 4 KiB disk sectors in Linux kernel?  Is there a
> Lukasz> leader/maintainer of this issue in community?
> 
> We have supported 4Kn for a decade. 512e obviously works out of the
> box. However, filesystem/partition/DM tooling has been updated to align
> correctly on 512e devices.
> 
> See:
> 
> 	http://oss.oracle.com/~mkp/docs/linux-advanced-storage.pdf

Also:

https://ata.wiki.kernel.org/articles/a/t/a/ATA_4_KiB_sector_issues_d4b8.html
http://sourceforge.net/apps/mediawiki/bootinfoscript/index.php?title=Boot_Problems:Windows_Writes_To_MBR
https://help.ubuntu.com/community/Grub2


I agree there is nothing about under Documentation/ in kernel sources, at least
from users point of view.
Martin
