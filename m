From: Mike Accetta <maccetta@laurelnetworks.com>
Subject: Re: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Tue, 27 Feb 2007 14:37:40 -0500
Message-ID: <2172.1172605060@mdt.dhcp.pit.laurelnetworks.com>
References: <45E44626.6060800@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from paperclip.laurelnetworks.com ([63.94.127.69]:33465 "EHLO
	paperclip.laurelnetworks.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbXB0Tqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 14:46:38 -0500
In-reply-to: Your message of "Tue, 27 Feb 2007 23:54:30 +0900."
             <45E44626.6060800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo writes:
> Mike Accetta wrote:
> > The version of hdparm on this box gives
> >     dev/sdb:
> >      operation not supported on SCSI disks
> > against the SCSI disk name.  With the controller in compatible mode,
> > here is the 'hdparm -I /dev/hdb' output on the same disk:
> > 
> > ATA device, with non-removable media
> >         Model Number:       FUJITSU MHT2060BH
> >         Serial Number:      NR0YT53258G8
> >         Firmware Revision:  0000104A
> 
> Sorry about late late late response.  :-)
> 
> 2.6.21 will behave better and turn off NCQ automatically in such cases.
>  It also reports proper model and firmware revision, so we'll be able to
> blacklist it from info contained in the dmesg.
> 
> Does your drive always work reliably if queue depth is set to one?  And
> often fails when queue depth is 31?

Hey, better late than never :-)

The drive actually seems to work fine at queue depth 4 and that is
what we are currently running it at.  I stopped at 4 when that worked and
never went any lower.  It always fails above 4 eventually.  The larger
the number, the quicker it seems to fail.  A raid re-resync operation
was the trigger.  On a 60Gb disk, I don't think I ever saw it complete
without error at NCQ > 4.  Sometimes the re-sync would logically succeed,
but with timeout errors, retries and downshifts logged to the console.
Other times, it would get the timeouts and do the retry/downshift until
it ran out of modes and then seem to get stuck in a retry loop.
--
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)
