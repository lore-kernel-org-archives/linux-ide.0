From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil and byte-aligned mmio
Date: Mon, 16 Oct 2006 12:17:11 +0900
Message-ID: <4532F9B7.1070901@gmail.com>
References: <452D69E6.9050606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:27722 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751413AbWJPDRT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 23:17:19 -0400
Received: by nf-out-0910.google.com with SMTP id c2so687963nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 20:17:18 -0700 (PDT)
In-Reply-To: <452D69E6.9050606@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Hello, Kevin.

Kevin Hilman wrote:
> Tejun,
> 
> A while back you provided a patch for sata_sil to use PCI IO space since
> so that it can work on hardware that doesn't support byte-aligned MMIO.
> 
> I'd like to see a fix for this pushed upstream, but IIRC, Jeff Garzik
> prefers that the driver be fixed up to use 32-bit aligned MMIO instead
> of making the driver use IO space.
> 
> If you can point me in the right direction, as to where the
> byte-alignement assumtions are, I can fix up the driver and test it on
> my hardware.

Byte-aligned IO accesses are in the default ATA operations - 
ata_tf_load/read, ata_check_status, ata_exec_command, 
ata_std_dev_select, all the bmdma ops, etc...  Basically, traditional 
ATA interface is designed to use byte-aligned registers to operate.

sil3112 family of controllers allow all those ops implemented using 
32bit ops, so you need to implement sata_sil's own methods to replace 
those standard byte-aligned ops.  I don't think it's gonna be too difficult.

Good luck. :-)

-- 
tejun
