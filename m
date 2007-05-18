From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: remove libata.spindown_compat
Date: Thu, 17 May 2007 20:58:42 -0400
Message-ID: <464CFA42.3080907@garzik.org>
References: <464C6A0E.7020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43726 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336AbXERA6t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 20:58:49 -0400
In-Reply-To: <464C6A0E.7020601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Daniel Drake <dsd@gentoo.org>, Francesco Pretto <ceztko@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, hmh@hmh.eng.br, pkg-sysvinit-devel@lists.alioth.debian.org

Tejun Heo wrote:
> With STANDBYDOWN tracking added, libata.spindown_compat isn't
> necessary anymore.  If userspace shutdown(8) issues STANDBYNOW, libata
> warns.  If userspace shutdown(8) doesn't issue STANDBYNOW, libata does
> the right thing.  Userspace can tell whether kernel supports spindown
> by testing whether sysfs node manage_start_stop exists as before.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> As many distros don't do anything to libata devices on shutdown which
> means we can avoid a lot of trouble by tracking spindown status (done)
> and which, in turn, obsoletes libata.spindown_compat.  I should have
> researched better before staring this mess.  Sorry but the situation
> is much better now.  :-)
> 
> I'll attach the updated version of http://linux-ata.org/shutdown.html
> as a reply to this mail.
> 
> If you find any problem in the updated scheme, please let me know.
> 
> Thanks.
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 498ff31..5c8695a 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -328,21 +328,20 @@ Who:   Adrian Bunk <bunk@stusta.de>
>  
>  ---------------------------
>  
> -What: libata.spindown_compat module parameter
> +What: libata spindown skipping and warning
>  When: Dec 2008
> -Why:  halt(8) synchronizes caches for and spins down libata disks
> -      because libata didn't use to spin down disk on system halt
> -      (only synchronized caches).
> -      Spin down on system halt is now implemented and can be tested
> -      using sysfs node /sys/class/scsi_disk/h:c:i:l/manage_start_stop.
> +Why:  Some halt(8) implementations synchronize caches for and spin
> +      down libata disks because libata didn't use to spin down disk on
> +      system halt (only synchronized caches).
> +      Spin down on system halt is now implemented.  sysfs node
> +      /sys/class/scsi_disk/h:c:i:l/manage_start_stop is present if
> +      spin down support is available.
>        Because issuing spin down command to an already spun down disk
> -      makes some disks spin up just to spin down again, the old
> -      behavior needs to be maintained till userspace tool is updated
> -      to check the sysfs node and not to spin down disks with the
> -      node set to one.
> -      This module parameter is to give userspace tool the time to
> -      get updated and should be removed after userspace is
> -      reasonably updated.
> +      makes some disks spin up just to spin down again, libata tracks
> +      device spindown status to skip the extra spindown command and
> +      warn about it.
> +      This is to give userspace tools the time to get updated and will
> +      be removed after userspace is reasonably updated.
>  Who:  Tejun Heo <htejun@gmail.com>
>  
>  ---------------------------


applied

you forgot diffstat

