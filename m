From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 13:29:27 -0400
Message-ID: <4F8EF9F7.5040202@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com> <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com> <4F8EF57E.4070603@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64731 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2DRR3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 13:29:33 -0400
Received: by qcro28 with SMTP id o28so4663973qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2012 10:29:32 -0700 (PDT)
In-Reply-To: <4F8EF57E.4070603@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
> Fix: I got my 3TB disk detected by this single command:
>
> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/control
> #
>
> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc3 kernel.
>
> I can do some more testing if you want me to.
> Best,
> Martin


Can you test this one-line patch from Lin Ming?  Hopefully there is zero 
sysfs twiddling required with this one...

--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
  	device_enable_async_suspend(dev);
  	pm_runtime_set_active(dev);
  	pm_runtime_enable(dev);
+	pm_runtime_forbid(dev);

  	transport_add_device(dev);
  	transport_configure_device(dev);


