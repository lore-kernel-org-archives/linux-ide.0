From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Loading both the pata_atiixp and the ahci driver causes problems
Date: Thu, 15 Mar 2007 21:42:08 -0400
Message-ID: <45F9F5F0.3090508@jonmasters.org>
References: <45F9C3F5.4070906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:4598 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXCPCOu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 22:14:50 -0400
In-Reply-To: <45F9C3F5.4070906@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Chuck Ebbert wrote:

> If you try to load both the pata_atiixp and the ahci driver
> (for the same ATI SB600 adapter), very strange things happen.
> The AHCI driver churns for three minutes or so, spewing
> messages like this, then nothing works:
> 
> <6>ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> <4>ata3.00: qc timeout (cmd 0xec)
> <4>ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)

> Shouldn't it be able to tell the device has already been
> claimed by some other driver?

One would assume it'd fail to grab the PCI IO ranges twice? I haven't 
looked at the code but I have seen this bug mentioned elsewhere so I 
might well end up having to do that yet :-)

Jon.
