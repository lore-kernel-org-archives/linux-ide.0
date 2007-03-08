From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Sata marvel kernel module
Date: Thu, 08 Mar 2007 05:04:54 -0500
Message-ID: <45EFDFC6.2070100@garzik.org>
References: <45EFDE3C.3090604@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45039 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030626AbXCHKE4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 05:04:56 -0500
In-Reply-To: <45EFDE3C.3090604@fastwebnet.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pillar Engineering <pillar@fastwebnet.it>
Cc: linux-ide@vger.kernel.org

Pillar Engineering wrote:
> Hi, i'm working in a project and I use the  Marvell 88SE6145 sata 
> controller.
> I use the sata_mv module for the linux kernel and, untill now, version 
> 2.6.20.1, it supports only the first two ports on the controller.

sata_mv does not support your hardware at all.  The PCI ID is not 
present, so it won't even load for your hardware without modification.

For the time being, look around for the ahci.c patch I posted, which 
enables the SATA portion of the 6145.

	Jeff



