From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata dvd not detected on jmicron with some kernel-configurations.
Date: Mon, 26 Mar 2007 19:54:23 +0900
Message-ID: <4607A65F.2060408@gmail.com>
References: <20070322130445.GA15539@useful.obra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:7110 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965042AbXCZKy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 06:54:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2065334wxd
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 03:54:28 -0700 (PDT)
In-Reply-To: <20070322130445.GA15539@useful.obra.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fredrik Rinnestam <fredrik@obra.se>
Cc: linux-ide@vger.kernel.org

Fredrik Rinnestam wrote:
> When booting a gnu/linux distribution's install-cd i noticed that the included
> [1]kernel (2.6.20.3) would not probe/find my jmicron connected sata-dvd. 

Which distribution are you using?

> My own [2]kernel-configuration finds the drive just fine but the distributor's
> kernel with all sorts of drivers built-in wont. If i connect the dvd-rom to my
> ich8r controller, both kernels finds it just fine.
> 
> The jmicron controller is configured as AHCI in the systems bios and AHCI is 
> built-in in both kernels along with scsi-cdrom support.
> 
> [1] http://fredrik.obra.se/linux-2.6.20.3.config
> [2] http://fredrik.obra.se/2.6.20.3.config
> 
> Any suggestions on what breaks it?

JMB controllers use the same PCI ID for AHCI and SFF parts and causes
some distribution initrd's fail to load proper module for it.  2.6.21
will match PCI class instead of PCI function number which should be much
easier on those inird's.

So, not really a kernel bug.  Please report it to maintainers of your
distribution.

-- 
tejun
