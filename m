From: "Subbrathnam, Swaminathan" <swami.iyer@ti.com>
Subject: RE: sata AHCI controller over non-PCI bus
Date: Mon, 10 Aug 2009 14:52:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F59891CB@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989152@dbde02.ent.ti.com>
 <4A7FE245.8020002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60657 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZHJJYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2009 05:24:47 -0400
In-Reply-To: <4A7FE245.8020002@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, "jeff@garzik.org" <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff,
	From the below link (from Sergei) it seems that you have already re-factored the AHCI implementation dependency on PCI.  I would like to add support for the OMAPL138 SATA on top of your changes.  That would be the ideal way forward for me.

	Have the ahci re-factoring changes queued for mainline merge already?  I just joined the list and hence do not know the status.

Sergei,
	Appreciate the response.

Regards
swami

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
Sent: Monday, August 10, 2009 2:33 PM
To: Subbrathnam, Swaminathan
Cc: linux-ide@vger.kernel.org
Subject: Re: sata AHCI controller over non-PCI bus

Hello.

Subbrathnam, Swaminathan wrote:
> Hi,
>
>             I would like to post support for OMAPL138 SATA controller that is AHCI 1.1 compliant.  OMAPL138 is an ARM926 based platform.
>
> Current "ahci.c" assumes that AHCI is getting supported over PCI by default, whereas the SATA AHCI controller on OMAPL138 is connected to a non-PCI bus.  Since I am in the process of posting the support I would like to get the  opinion from the community on how to proceed on this front.

   Well, you're not the first with this problem, Marvell already had it.

>   I see the following 2 options today
>
> 1.       #ifdef the PCI specific code in ahci.c and implement the platform_device based implementation to support non-PCI AHCI controllers.
>   

   I don't think this is a community-acceptable option at all.

> 2.       Re-organize the ahci.c to abstract the AHCI functionalities from PCI, non-PCI bus dependencies.
>
> Currently we have implemented Option 1 in our internal tree to support SATA on OMAPL138 platform and it works well.  Ideally I would want to proceed with Option 2 but would like get feedback from the community before proceeding in this direction.

   See 
http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=shortlog;h=libahci 
for Jeff Garzik's work on separating AHCI support from PCI.

MBR, Sergei



