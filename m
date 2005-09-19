From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_promise and SATA+PATA controllers in general
Date: Sun, 18 Sep 2005 22:11:55 -0400
Message-ID: <432E1E6B.7040001@pobox.com>
References: <Pine.LNX.4.62.0509181644210.10435@ultros>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:4998 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932291AbVISCMA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Sep 2005 22:12:00 -0400
In-Reply-To: <Pine.LNX.4.62.0509181644210.10435@ultros>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Lloyd <dmlloyd@tds.net>
Cc: linux-ide@vger.kernel.org

David Lloyd wrote:
> Does this mean have e.g. a pata_port_ops member as well as a 
> sata_port_ops member on the ata_probe_ent/ata_host_set, and mark each 
> port as being either PATA or SATA with a flag of some sort?  Or, would 

definitely not.


> it be best to have a port_ops pointer per port?

Each port should be able to export unique behavior.  That implies having 
per-port hooks, since host-global hooks make it impossible for one port 
to have different hooks from another port.

Establishing a global limit of two unique behaviors (sata_port_ops, 
pata_port_ops) is not scalable at all.

Further complicating things, some hooks (such as ->irq_clear) are 
host-wide hooks and not port-specific hooks.

	Jeff


