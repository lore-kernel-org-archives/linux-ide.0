From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: no hotplugging support (FIXME)
Date: Fri, 20 Feb 2009 19:03:04 -0600
Message-ID: <499F52C8.90205@gmail.com>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org> <499F171D.5020600@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:50794 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbZBUBDJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 20:03:09 -0500
Received: by el-out-1112.google.com with SMTP id b25so618257elf.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2009 17:03:07 -0800 (PST)
In-Reply-To: <499F171D.5020600@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd and Margo Chester <ToddAndMargo@verizon.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Todd and Margo Chester wrote:
> Hi Jeff,
> 
> I am having a nasty problem with hot swapping a removable (not
> eSATA) drive I use for backup on several servers.  It is reported
> over on
> http://bugs.centos.org/view.php?id=3391
> 
> Trying to help me find a work around to the problem at
> http://www.centos.org/modules/newbb/viewtopic.php?topic_id=18608&start=0#forumpost68783 
> 
> Alan posted your ata_piix.c code at
> http://centos.toracat.org/ajb/tmp/toddandmargo/ata_piix.c
> He pointed out
> 
> 1483 /* no hotplugging support (FIXME) */
> 1484 if (!in_module_init)
> 1485 return -ENODEV;
> 
> What do you mean by the comment in line 1483?  Is there some
> know issue with hot swapping SATA drives?

If you're using the ata_piix driver then it means your motherboard is 
not in AHCI mode, so hotplugging is not supported by either the driver 
or controller. You have to enable AHCI for SATA hotplug to work on Intel 
controllers.
