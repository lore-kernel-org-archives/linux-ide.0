From: "IKARASHI, Seiichi" <ikarashi@miraclelinux.com>
Subject: Re: Problems with ata-piix driver
Date: Wed, 16 Jun 2004 12:47:34 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40CFC2D6.2050304@miraclelinux.com>
References: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu> <40CFB5D7.2000702@miraclelinux.com> <40CFBC60.5000606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:65160 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S266113AbUFPDrk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2004 23:47:40 -0400
In-Reply-To: <40CFBC60.5000606@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Norman Elton <wnelto@wm.edu>, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> IKARASHI, Seiichi wrote:
> 
>> Hi,
>>
>> How about reconstruct the SATA RAID volume into
>> non-RAID volumes (separated single disks)?
>> The ata_piix/libata driver in RHEL3 seems not support
>> SATA RAID. When I encountered a similar situation on a machine
>> which was connected with a SATA HDD with its Intel 6300ESB chip
>> on-board, I made the RAID function of ESB disable and installed OS.
> 
> 
> 
> This is something different -- the hardware does NOT support RAID.  A 
> separate software RAID driver is required for Intel's proprietary RAID 
> format.  This driver has been posted to linux-kernel for 2.4.x, but is 
> not available for 2.6.x kernels.
> 
>     Jeff

Hi Jeff,

Is it the patch you mentioned above?
   http://lwn.net/Articles/60247/
Or any updates after this?
It seems to work with your ata_piix.


Seiichi


