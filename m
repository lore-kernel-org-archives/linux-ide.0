From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: hotplug event on fdisk?
Date: Tue, 12 Jul 2005 17:57:52 +0200
Message-ID: <42D3E880.6060902@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:33805 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261497AbVGLP5z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jul 2005 11:57:55 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 9291A2F016
	for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 16:05:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id D37DD1207C
	for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 17:57:53 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 1F5F111C73
	for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 17:57:53 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I noticed that /sbin/hotplug is called by the kernel when I am doing

	fdisk -l /dev/hda

to do a "remove" and then do "add" again:

~ # fdisk -l /dev/hda
kobject_hotplug
kobject_hotplug: /sbin/hotplug block seq=574 HOME=/ 
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/block/hda/hda1 
SUBSYSTEM=block
  hda: hda1
kobject_hotplug
kobject_hotplug: /sbin/hotplug block seq=575 HOME=/ 
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/block/hda/hda1
SUBSYSTEM=block

Disk /dev/hda: 512 MB, 512483328 bytes
16 heads, 63 sectors/track, 993 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *           1         993      500440+   6  FAT16


Why is it so? And what is the system suposed to do? Actually remove the device?

--
Steven

