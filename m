From: Fredrik Rinnestam <fredrik@obra.se>
Subject: sata dvd not detected on jmicron with some kernel-configurations.
Date: Thu, 22 Mar 2007 14:04:45 +0100
Message-ID: <20070322130445.GA15539@useful.obra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep04.bredband.com ([195.54.107.79]:63942 "EHLO
	mxfep04.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbXCVNFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 09:05:07 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep04.bredband.com with ESMTP
          id <20070322130505.LZWC2732.mxfep04.bredband.com@ironport.bredband.com>
          for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 14:05:05 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When booting a gnu/linux distribution's install-cd i noticed that the included
[1]kernel (2.6.20.3) would not probe/find my jmicron connected sata-dvd. 

My own [2]kernel-configuration finds the drive just fine but the distributor's
kernel with all sorts of drivers built-in wont. If i connect the dvd-rom to my
ich8r controller, both kernels finds it just fine.

The jmicron controller is configured as AHCI in the systems bios and AHCI is 
built-in in both kernels along with scsi-cdrom support.

[1] http://fredrik.obra.se/linux-2.6.20.3.config
[2] http://fredrik.obra.se/2.6.20.3.config

Any suggestions on what breaks it?

Cheers.
-- 
Fredrik Rinnestam
