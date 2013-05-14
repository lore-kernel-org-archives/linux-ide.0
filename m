From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 #for-3.10] libata: export ata_port port_no attribute
 via /sys
Date: Tue, 14 May 2013 11:44:56 -0700
Message-ID: <20130514184456.GO6795@mtj.dyndns.org>
References: <1368557320-15735-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f181.google.com ([209.85.213.181]:43211 "EHLO
	mail-ye0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab3ENSpD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 May 2013 14:45:03 -0400
Received: by mail-ye0-f181.google.com with SMTP id l8so166336yen.26
        for <linux-ide@vger.kernel.org>; Tue, 14 May 2013 11:45:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368557320-15735-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com, hare@suse.de

On Tue, May 14, 2013 at 01:48:40PM -0500, David Milburn wrote:
> While registering host controller track port number based upon number
> of ports available on the controller, export port_no attribute through
> /sys. This patch is needed by udev for composing persistent links in
> /dev/disk/by-path.
> 
> # pwd
> /sys/devices/pci0000:00/0000:00:1f.2/ata8/ata_port/ata8
> # ll
> total 0
> lrwxrwxrwx. 1 root root    0 Mar  6 12:43 device -> ../../../ata8
> -r--r--r--. 1 root root 4096 Mar  6 12:43 idle_irq
> -r--r--r--. 1 root root 4096 Mar  6 12:43 nr_pmp_links
> -r--r--r--. 1 root root 4096 Mar  6 12:43 port_no
> drwxr-xr-x. 2 root root    0 Mar  6 12:42 power
> lrwxrwxrwx. 1 root root    0 Mar  6 12:41 subsystem -> ../../../../../../class/ata_port
> -rw-r--r--. 1 root root 4096 Mar  6 12:40 uevent
> # cat port_no
> 1
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

Applied to libata/for-3.11.

Thanks.

-- 
tejun
