From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] libata: ahci enclosure management bios workaround
Date: Mon, 06 Apr 2009 20:02:34 -0400
Message-ID: <49DA981A.2000502@garzik.org>
References: <20090403203641.GA16179@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42377 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757959AbZDGACj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 20:02:39 -0400
In-Reply-To: <20090403203641.GA16179@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

David Milburn wrote:
> During driver initialization ahci_start_port may not be able
> to turn LEDs off because the hardware may still be transmitting
> a message. And since the BIOS may not be setting the LEDs to
> off the drive LEDs may end up in a fault state. This has
> been seen on ICH9r and ICH10r when configured in AHCI mode
> instead of RAID mode, this patch doesn't key off a specific
> set of device IDs but will give the EM transmit bit a chance
> to clear if busy.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

applied


