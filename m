From: Todd and Margo Chester <ToddAndMargo@verizon.net>
Subject: Re: no hotplugging support (FIXME)
Date: Sat, 21 Feb 2009 20:50:17 -0800
Message-ID: <49A0D989.8030106@verizon.net>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
 <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com>
 <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com>
 <49A0CFFF.3050806@verizon.net> <49A0D167.9060707@gmail.com>
 <49A0D74F.1010009@verizon.net> <49A0D7F6.902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:45550 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZBVEub (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 23:50:31 -0500
Received: from rn1.rent-a-nerd.local ([71.125.120.146])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG00GT2ARTWNQQ@vms173017.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sat, 21 Feb 2009 22:50:18 -0600 (CST)
In-reply-to: <49A0D7F6.902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:

> Normally all the ports are AHCI if it's switched into that mode, so it 
> shouldn't be an issue. However, you could leave in ata_piix as the third 
> entry, so that the system will still boot if it's not in AHCI mode 
> properly. There's no real harm in having unnecessary drivers in there..

Sorry for the thousand questions.  Thank you for being so gracious.

Question: once I boot up, is there a way to tell which drive
is using which driver?

Many thanks,
-T
