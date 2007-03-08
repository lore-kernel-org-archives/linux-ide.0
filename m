From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata-nv hotplug feature
Date: Thu, 08 Mar 2007 17:21:01 +0900
Message-ID: <45EFC76D.9020408@gmail.com>
References: <200703072039.18588.rweeks@razorwire.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:5765 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030228AbXCHIVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 03:21:01 -0500
Received: by wr-out-0506.google.com with SMTP id 58so717225wri
        for <linux-ide@vger.kernel.org>; Thu, 08 Mar 2007 00:21:01 -0800 (PST)
In-Reply-To: <200703072039.18588.rweeks@razorwire.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rweeks@razorwire.ca
Cc: linux-ide@vger.kernel.org

Russ Weeks wrote:
> uname -a:
> Linux backfire 2.6.19.2-smp #2 SMP Sat Mar 3 13:06:28 PST 2007 x86_64 x86_64 
> x86_64 GNU/Linux
> 
> lspci shows this:
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
> 
> lsmod shows that libata and sata-nv are present.
> 
> rescan-scsi-bus.sh shows this (after I boot with 1 drive plugged in and then 
> try to plug in the other 2):
> OLD: Host: scsi2 Channel: 00 Id: 00 Lun: 00
>       Vendor: ATA      Model: ST3250824AS      Rev: 3.AA
>       Type:   Direct-Access                    ANSI SCSI revision: 05
> 
> (this seems correct, just that 2 other drives are missing)
> 
> The hardware is a Tyan Thunder K8W 2895 motherboard with an onboard 
> controller.  3 250Gb Seagate Barracudas are attached, 2 are in removable 
> drive trays made by some company called 'ByteCC'.

I suppose it isn't a CK804 as just pluggin/unplugging should work on it.
 Rescanning should do the job tho.  Can you post the result of 'dmesg'
after boot?

-- 
tejun
