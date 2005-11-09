From: David Lloyd <dmlloyd@tds.net>
Subject: Re: sata_promise and SATA+PATA controllers in general
Date: Tue, 8 Nov 2005 23:50:03 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0511082339510.20633@ultros>
References: <Pine.LNX.4.62.0509181644210.10435@ultros> <432E1E6B.7040001@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound2.mail.tds.net ([216.170.230.92]:7400 "EHLO
	outbound2.mail.tds.net") by vger.kernel.org with ESMTP
	id S932465AbVKIFuK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 00:50:10 -0500
In-Reply-To: <432E1E6B.7040001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Sun, 18 Sep 2005, Jeff Garzik wrote:

> Further complicating things, some hooks (such as ->irq_clear) are 
> host-wide hooks and not port-specific hooks.

Looks like what is needed is a host_ops kind of structure that would 
contain irq_handler, irq_clear (it seems as if irq_clear generally 
operates on a port, however, so that makes it kinda odd), and host_stop, 
maybe others too; then these members would be moved there, and 
ata_probe_ent would get a pointer to this structure, as would 
ata_host_set.

As an aside, is ata_probe_ent supposed to represent the entire controller 
or simply a single port?  It looks like sometimes it does one role, 
sometimes the other.  If the former, then I guess the port_ops pointer 
should become an array of size ATA_MAX_PORTS.

Answers or comments appreciated.

- D
