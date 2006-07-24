From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/12] libata: implement interface power management infrastructure
Date: Mon, 24 Jul 2006 17:02:15 +0900
Message-ID: <44C47E87.1060806@gmail.com>
References: <11531191522798-git-send-email-htejun@gmail.com> <44BE8BD0.90907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:4892 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932095AbWGXJ4o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:44 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506082pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:11 -0700 (PDT)
In-Reply-To: <44BE8BD0.90907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Hi,

Jeff Garzik wrote:
> NAK.
> 
> Module parameters in libata are largely for turning off/on major 
> features, during a transitional testing period.  They largely provide 
> users with workaround solutions to "it won't boot" type problems.
> 
> I also think you have been seduced by the relative ease of adding this 
> control to libata, as opposed to the preferred alternative:  digging 
> through sysfs objects to find the right one to which attributes should 
> be added.
> 
> As an aside, in addition to per-controller (or per-port) sysfs powersave 
> controls, libata should [eventually] recognize the external "laptop 
> mode" setting.  When laptop mode == ON, program powersave aggresively.

* I agree that cross-port synchronization is not a particularly nice 
thing to implement, but it's a nice thing to have from user's POV. 
Also, it is necessary to implement any kind of global control like 
laptop_mode.  I think it's a necessary evil.

* I want to export per-port and eventually per-link powersave interface 
but the problem is that libata doesn't have any sysfs representation 
other than what's supplied by SCSI, which means empty links don't have 
anything to represent them in sysfs.  Unfortunately, sysfs is tied to 
driver implementation ATM, so we can't start building sysfs tree on 
as-needed basis.

So, until sysfs representation is detached from internal driver data 
structure or ATA moves out of SCSI, I don't really see how we can add 
those fine-grained knobs.  Also, although having fine knobs is a good 
thing, I think powersave with global control goes a long way by itself 
and global control is needed with or without fine knobs.

However, one thing I can think of is to implement (yet) bogus ATA bus 
and add global controls there.  e.g. /sys/bus/ata/powersave.  What do 
you think about this?

* For global control, overloading laptop_mode doesn't seem to be a good 
idea.  That's a VM-specific knob with very specific role.  I think we 
should add system-wide sysfs node - maybe /sys/power/powersave? - which 
advises the kernel about power consumption.  It can propagate powersave 
requests using notifier chain and both VM and libata can hook into it to 
control laptop_mode and libata powersaving respectively.

> In general, though, we should peek to minimize power usage for the 
> general case, where feasible.  People with huge server closets like 
> Google need every ounce of power savings possible.

I'm not too sure about enabling powersave by default, if that's what you 
mean.  Yeah, people with large server farms will definitely benefit from 
powersave.  That's why I'm thinking of implementing full powersave 
including both HIPS and DIPS on PMP.  But powersave also has the 
possibility of causing malfunctions on devices which used to work okay.

I've seen sil3112 family of controllers malfunction when powersave kicks 
in and won't be surprised to see other controllers and drives show 
erratic behavior on powersave.

Another problem is that, however minute, powersave does introduce extra 
delay when waking up and thus can negatively affect performance.  The 
performance drop should be negligible on most non-SSD devices but it's 
still there.

> With regards to the patch content:  other than the control interface, 
> the implementation looks OK.

Nice, thanks.

-- 
tejun

