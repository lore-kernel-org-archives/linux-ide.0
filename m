From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Tue, 03 Jun 2008 14:07:42 -0400
Message-ID: <4845886E.2010505@garzik.org>
References: <20080528143857.GB5585@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47689 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbYFCSHp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 14:07:45 -0400
In-Reply-To: <20080528143857.GB5585@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, akpm@linux-foundation.org

Holger Macht wrote:
> * Differentiate between bay devices in dock stations and others:
> 
>  - When an ACPI_NOTIFY_EJECT_REQUEST appears, just signal uevent to
>    userspace (that is when the optional eject button on a bay device is
>    pressed/pulled) giving the possibility to unmount file systems and to
>    clean up. Also, only send uevent in case we get an EJECT_REQUEST
>    without doing anything else. In other cases, you'll get an add/remove
>    event because libata attaches/detaches the device.
> 
>  - In case of a dock event, which in turn signals an
>    ACPI_NOTIFY_EJECT_REQUEST, immediately detach the device, because it
>    may already have been gone
> 
> * In case of an ACPI_NOTIFY_DEVICE/BUS_CHECK, evaluate _STA to check if
>   the device has been plugged or unplugged. If plugged, hotplug it, if
>   unplugged, just signal event to userspace
>   (initial patch by Matthew Garrett <mjg59@srcf.ucam.org>)
> 
> * Call ACPI _EJ0 for detached devices
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> 
> Changes regarding the previous patch:
> 
>  * Make sure kobj does not go away outside locking
>  * Coding style cleanups
>  * Call _EJ0 for detached devices

Matthew, any comments?

It would be nice if you and Holger could work together to produce a 
single patch[set]...  right now I have patches from both of you, and I 
was sorta waiting on the thread to die down to see if competing patches 
might merge into a single set

