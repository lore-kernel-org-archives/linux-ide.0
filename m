From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problems with ata-piix driver
Date: Tue, 15 Jun 2004 23:19:12 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40CFBC30.9090902@pobox.com>
References: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28298 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266114AbUFPDT1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2004 23:19:27 -0400
In-Reply-To: <2CAA5C8E-BEC8-11D8-BEE9-000A95B0A866@wm.edu>
List-Id: linux-ide@vger.kernel.org
To: Norman Elton <wnelto@wm.edu>
Cc: linux-ide@vger.kernel.org

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

Usually this means you need to disable 'combined mode' or 'legacy mode' 
in the BIOS setup.

I'll take a look at that bug...

	Jeff



