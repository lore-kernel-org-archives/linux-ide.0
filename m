From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support V2
Date: Wed, 28 Dec 2005 21:23:11 +0000
Message-ID: <200512282123.12839.arnd@arndb.de>
References: <20051228184014.571997000@localhost.localdomain> <20051228185412.951490000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:7387 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964914AbVL1VXe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Dec 2005 16:23:34 -0500
In-Reply-To: <20051228185412.951490000@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Anderson Briglia <anderson.briglia@indt.org.br>, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

On Wednesday 28 December 2005 18:40, Anderson Lizardo wrote:
> 
> Implement MMC password reset and forced erase support. It uses the sysfs
> mechanism to send commands to the MMC subsystem. Usage:
> 
> Forced erase:
> 
> echo erase > /sys/bus/mmc/devices/mmc0\:0001/lockable
> 
> Remove password:
> 
> echo remove > /sys/bus/mmc/devices/mmc0\:0001/lockable

The MMC password support seems to be a subset of the operations
possible on modern ATA drives. IMHO, any interface you introduce
should be usable for both types of devices.

The only interface I could find for ATA is through HDIO_DRIVE_CMD.
This is currently used by hdparm, but it does not look like it
fits the MMC problem well.

Has anyone already done an ioctl or sysfs implementation of ATA
password user interfaces, or is perhaps the one proposed here
sufficient for ATA drives as well?

	Arnd <><
