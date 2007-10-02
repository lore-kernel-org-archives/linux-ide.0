From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 4
Date: Tue, 02 Oct 2007 14:55:31 -0400
Message-ID: <47029423.6030605@garzik.org>
References: <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53676 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbXJBSzg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 14:55:36 -0400
In-Reply-To: <20071002184958.GC31251@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com

Matthew Garrett wrote:
> Modern laptops with hotswap bays still tend to utilise a PATA interface 
> on a SATA bridge, generally with the host controller in some legacy 
> emulation mode rather than AHCI. This means that the existing hotplug 
> code in libata is unable to work. The ACPI specification states that 
> these devices can send notifications when hotswapped, which avoids the 
> need to obtain notification from the controller. This patch uses the 
> existing libata-acpi code and simply registers a notification in order 
> to trigger a rescan whenever the firmware signals an event.
>                                                                                                                                                                                                         
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>                        
> 
> ---
> 
> This incorporates Jeff's feedback. sdev is checked for NULL, and 
> different notifications are registered for ap-level and dev-level 
> handlers. The core code is split out into a helper function called by 
> both of these. The other change is the removal of the extraneous newline 
> from the end of the notification event, to match the upstream change in 
> the bay driver.

applied


