From: Bahadir Balban <bahadir.balban@gmail.com>
Subject: Re: problem mounting a partition on a usb drive
Date: Fri, 27 Jan 2006 14:56:36 +0000
Message-ID: <7ac1e90c0601270656n43c3d499q5dfb1c3adf5f97fc@mail.gmail.com>
References: <7ac1e90c0601270433u3be68c70v582990ce49afd64d@mail.gmail.com>
	 <43DA1906.1060302@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.206]:61395 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751481AbWA0O4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 09:56:38 -0500
Received: by uproxy.gmail.com with SMTP id s2so105924uge
        for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2006 06:56:36 -0800 (PST)
In-Reply-To: <43DA1906.1060302@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gentoopower <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org

On 1/27/06, Gentoopower <gentoopower@yahoo.de> wrote:
> Can we see your kernel config.
>
> I suspect there is no support compiled in for usb storage devices.

Hi,

I don't think this is the problem, because you need usb-storage class
transactions on the bus in order to read the disk. But still, here are
the relevant bits from 2.6.9 .config:

CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_CHR_DEV_SG=y
CONFIG_USB_STORAGE=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y

My debug method would be to insert printk's to the bit of code in the
kernel that reads the partition tables and compare the results on both
kernels. Can you think of any better ways? How do you normally debug
IDE drives?

Many thanks,
Bahadir
