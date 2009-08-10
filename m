From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: sata AHCI controller over non-PCI bus
Date: Mon, 10 Aug 2009 13:03:01 +0400
Message-ID: <4A7FE245.8020002@ru.mvista.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989152@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64581 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751883AbZHJJDG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 05:03:06 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5989152@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Subbrathnam, Swaminathan" <swami.iyer@ti.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

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


