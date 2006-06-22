From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Thu, 22 Jun 2006 16:34:02 +0900
Message-ID: <449A47EA.90601@gmail.com>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com> <200606220916.18020.boac@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:64265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932826AbWFVHdz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jun 2006 03:33:55 -0400
Received: by nz-out-0102.google.com with SMTP id f1so715871nzc
        for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2006 00:33:55 -0700 (PDT)
In-Reply-To: <200606220916.18020.boac@wanadoo.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Aalderd Bouwman wrote:
> Hello Tejun,
> 
> Is the NCQ-patch already in libata-dev git and how could I update my 
> libata-dev tree?

No, the turn-off-NCQ-for-vt8251 patch isn't yet in libata-dev #upstream. 
  To apply the patch, simply checkout #upstream and apply the patch.

> Now the port is disabled by the driver :'( so I am unable to use this port for 
> an another drive and I think that is not what you want. When this module 
> is 'build in' you should reboot your machine.

You can tell the driver to rescan by issuing scan request via sysfs. 
For instruction, please read the following.

http://home-tj.org/wiki/index.php/Libata-tj-stable#README

About the disabling on hardreset failure...  Maybe there is some room 
for improvement - e.g. leave PHY status interrupts alive if it's not 
causing interrupt storm, but I'm not sure whether the benefits would 
outweigh the cost.

Leaving the port frozen (disabled & interrupts plugged) is a safety 
measure libata implements.  The driver isn't sure in what state the 
controller and the attached device are in as they are not responding 
even to the 'hard' reset, so it assumes the worst and shuns the port.

As I wrote above, you can ask libata to retry by explicitly telling 
libata to rescan the bus.  I thought that should be enough when I was 
implementing it.  At any rate, I doubt it will help your case as your 
controller gets completely stuck during EH and only controller-wide 
reset brings it back.

Also, I checked and the oops you've reported earlier shouldn't happen in 
the current #upstream.  It's been taken care of when the hotplug support 
was added.  So, you should at least be able to load and unload ahci as 
you wish.  :-(

-- 
tejun
