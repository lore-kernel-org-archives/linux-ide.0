From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: not full working ata_piix
Date: Wed, 25 Nov 2009 07:50:38 -0500
Message-ID: <4B0D281E.4040805@pobox.com>
References: <931603659.20091125091656@gmx.de> <20091125104312.76d1b986@lxorguk.ukuu.org.uk> <4B0D2013.8030901@pobox.com> <1166921694.20091125134646@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36818 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934553AbZKYMuh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Nov 2009 07:50:37 -0500
In-Reply-To: <1166921694.20091125134646@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gorgone <gorgone@gmx.de>
Cc: linux-ide@vger.kernel.org

On 11/25/2009 07:46 AM, Gorgone wrote:
> Guten Tag Jeff Garzik,
>
> am Mittwoch, 25. November 2009 um 13:16 schrieben Sie:
>
>> On 11/25/2009 05:43 AM, Alan Cox wrote:
>>>>       00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)
>>>>       00:1f.2 0106: 8086:27c1 (rev 01)
>>>
>>> This should be handled by the AHCI driver under the SATA configuration
>>> options.
>
>> Agreed/correct.  Also, CONFIG_IDE needs to be disabled.
>
>>          Jeff
>
> the sata ahci intel driver dont work for the 2 ide ports
>
> if i disable CONFIG_IDE
>
> root file system .... can not be found
>
> http://pastebin.com/f4c78a7ad

The IDE driver puts devices on /dev/hdX, the newer libata driver exports 
disks at /dev/sdX

	Jeff



