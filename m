From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: PIIX libata ?
Date: Tue, 18 Apr 2006 19:32:44 -0700
Message-ID: <20060418193244.858d6147.rdunlap@xenotime.net>
References: <loom.20060418T155655-644@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:27811 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750719AbWDSCaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Apr 2006 22:30:18 -0400
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 18 Apr 2006 19:30:17 -0700
In-Reply-To: <loom.20060418T155655-644@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frido Ferdinand <frido@zolder.org>
Cc: linux-ide@vger.kernel.org

On Tue, 18 Apr 2006 13:59:05 +0000 (UTC) Frido Ferdinand wrote:

> Hi,
> 
> How can i see that PIIX is either from libata or the usual IDE drivers. I have
> both enabled in the kernel but not sure which takes presedence, will the drives
> show up as /dev/sda ? disks used are non-sata/normal ide disks.

If both are built into the kernel (=y and not modules), legacy
IDE drivers take precedence since ide/ is ahead of scsi/ in
drivers/Makefile (libata drivers are in scsi/).

I have no idea about precedence if you are using initrd or initramfs.

And if legacy ide and scsi are both modules, you won't boot...
(without using initrd or initramfs).

---
~Randy
