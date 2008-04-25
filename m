From: "kyle" <kylewong@southa.com>
Subject: Re: ICH7: ata_piix twice as fast as ahci?
Date: Fri, 25 Apr 2008 11:09:28 +0800
Message-ID: <00b001c8a681$c65fac90$9d02a8c0@kyle>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.southa.com ([125.215.237.177]:50055 "HELO southa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752496AbYDYDJg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Apr 2008 23:09:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: joris@v5.de

Hello Joris,

Have you solve the problem? If so, how? I think I hit the similiar problem
as yours,
but instead of ICH7, I hit the problem with ICH9.

8 x Seagate 500GB harddisks are connected to ICH9 and sil24 PCI-E
controller,
transfer rate of disks connected to ICH9 are limited at around 47MB/s, while
disks connected to sil24 reach 104MB/s. All harddisks are NCQ enabled, so I
don't think NCQ is the problem.

please cc me if possible.

Regards,
Kyle


> Hello List,

> Odd problem on my machines: the sata disks appear to be a lot slower
> when used via ata_piix vs the ahci driver.

> * dd if=/dev/sda of=/dev/null runs at roughly 50MB/s under ahci a
> steady 100MB/s under ata_piix, same for hdparm
> * bonnie++ -d /home/bonnietest -s 16G -r 8192 -u root returns:

