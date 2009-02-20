From: Todd and Margo Chester <ToddAndMargo@verizon.net>
Subject: no hotplugging support (FIXME)
Date: Fri, 20 Feb 2009 12:48:29 -0800
Message-ID: <499F171D.5020600@verizon.net>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:50413 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZBTUsl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 15:48:41 -0500
Received: from rn1.rent-a-nerd.local ([68.238.72.98])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFD00151TSTBLPI@vms173009.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Fri, 20 Feb 2009 14:48:30 -0600 (CST)
In-reply-to: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I am having a nasty problem with hot swapping a removable (not
eSATA) drive I use for backup on several servers.  It is reported
over on
http://bugs.centos.org/view.php?id=3391

Trying to help me find a work around to the problem at
http://www.centos.org/modules/newbb/viewtopic.php?topic_id=18608&start=0#forumpost68783
Alan posted your ata_piix.c code at
http://centos.toracat.org/ajb/tmp/toddandmargo/ata_piix.c
He pointed out

1483 /* no hotplugging support (FIXME) */
1484 if (!in_module_init)
1485 return -ENODEV;

What do you mean by the comment in line 1483?  Is there some
know issue with hot swapping SATA drives?

Many thanks,
-T

