From: "IKARASHI, Seiichi" <ikarashi@miraclelinux.com>
Subject: Re: Problems with ata-piix driver
Date: Wed, 16 Jun 2004 11:52:07 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40CFB5D7.2000702@miraclelinux.com>
References: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:5361 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S266136AbUFPCwM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2004 22:52:12 -0400
In-Reply-To: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu>
List-Id: linux-ide@vger.kernel.org
To: Norman Elton <wnelto@wm.edu>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

How about reconstruct the SATA RAID volume into
non-RAID volumes (separated single disks)?
The ata_piix/libata driver in RHEL3 seems not support
SATA RAID. When I encountered a similar situation on a machine
which was connected with a SATA HDD with its Intel 6300ESB chip
on-board, I made the RAID function of ESB disable and installed OS.

Regards,
Seiichi Ikarashi


Norman Elton wrote:

> Hello,
> 
> I got your e-mail sfrom the ata_piix.c header. When I boot RedHat's 
> installer program, the installer freezes when trying to load the 
> ata_piix driver. I have filed a bug with RedHat (#125624). Jeff, I 
> notice the bug has been assigned to you.
> 
> Is there any way around this issue? It's preventing me from installing 
> RH on one of our servers.
> 
> Thanks,
> 
> Norman Elton
> 
> ------------------------------------------------------
> Norman Elton
> Information Technology - Network Engineering
> College of William & Mary
> 757-221-7790
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

