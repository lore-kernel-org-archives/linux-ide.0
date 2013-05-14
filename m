From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #for-3.10] libata: export ata_port port_no attribute via
 /sys
Date: Tue, 14 May 2013 11:00:33 -0700
Message-ID: <20130514180033.GL6795@mtj.dyndns.org>
References: <1367962842-32299-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:34874 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab3ENSAj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 May 2013 14:00:39 -0400
Received: by mail-yh0-f44.google.com with SMTP id 29so172096yhl.17
        for <linux-ide@vger.kernel.org>; Tue, 14 May 2013 11:00:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367962842-32299-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com, hare@suse.de

Hello,

On Tue, May 07, 2013 at 04:40:42PM -0500, David Milburn wrote:
> While registering host controller track port number based upon number
> of ports available on the controller, export port_no attribute through
> /sys.
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

No objection but can you please include in the commit message why this
is necessary and who's gonna make use of it?

Thanks.

-- 
tejun
