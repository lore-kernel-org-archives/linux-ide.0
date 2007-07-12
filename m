From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET 4/4] implement PMP support, take 4
Date: Thu, 12 Jul 2007 16:27:08 -0400
Message-ID: <46968E9C.3060607@garzik.org>
References: <1183287253677-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55758 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758001AbXGLU1L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:27:11 -0400
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Hello, all.
> 
> his is the fourth take of libata-pmp patchset.  This patchset contains
> 15 patches and implements PMP support.
> 
> #01-04: implement libata PMP support
> #05-09: implement sata_sil24 PMP support
> #10-15: implement ahci PMP support
> 
> Changes from the last take[L] are.
> 
> * updated to fit new #upstream
> * ACPI support for PMP fan-out ports added
> * improved general PMP EH behavior
> * various PMP chip specific quirks for smooth handling of first gen
>   products which at times are pretty quirky
> * AHCI PMP support added
> 
> Tested extensively with sil3214/32, ICH9R, JMB360/3 combined with
> sil3726, 4726 and 5744 port multipliers.  Disks from all major vendors
> and an SATAPI device is used as downstream devices.  sil5744 and 3726
> behave very nicely on all controllers.  Hotplugging and suspend/resume
> work well too.  There are some remaining issues.
> 
> * When attached to AHCI controller (ICH9R, JMB360/3), NCQ doesn't
>   work.  Things look okay as long as only one command is in flight but
>   as soon as the second command is issued (to the same device), hell
>   breaks loose and all sorts of errors occur including device abort,
>   bad PMP number and interface fatal error.  This behavior is common
>   across all PMP chips.  I've disabled NCQ if PMP is attached to an
>   ahci controller for now.
> 
> * Sil4726 is a bit too quirky.  Without the first fan-out port
>   occupied, the thing acts really weirdly.  As long as the first port
>   is occupied, it works okay.  This is reportedly fixed by new
>   firmware.  I tried to update the firmware but installing 3124 driver
>   on Windows was just too difficult for me and I gave up after thirty
>   painful minutes.  Anyone up for testing?
> 
> * Again, Sil4726 doesn't like ahci driver initialization sequence.
>   During driver initialization, the whole controller is reset and the
>   PHY seems to go offline and back online.  Sil4726 doesn't like it
>   and goes out for lunch for several secs after that which makes
>   initial probing think that the port is empty.  After probing is
>   complete, Sil4726 comes back and gets detected but at that point
>   detection is asynchronous and if boot device is on one of fan-out
>   ports, it can be a problem.  Again, this might have been fixed by
>   new firmware.  Anyone up for testing?
> 
> * The long boot delay on ASUS boards with on-board PMP chips should be
>   fixed by this patchset but I don't have such a board or Sil4723
>   which is used on those baords, so I'm not sure.  Anyone up for
>   testing?
> 
> This patchset is against
> 
>   libata-dev#upstream (4e1ae96828f6cee7b89ab8ca474c150fe211afd8)
>   + [1] misc-updates patchset
>   + [2] libata-link patchset, take 4
>   + [3] libata-pmp-prep patchset, take 4

patchset overall seems OK to me


