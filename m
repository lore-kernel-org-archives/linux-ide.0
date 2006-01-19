From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: SATA passthrough fails to differentiate between SCSI devices
Date: Thu, 19 Jan 2006 12:28:33 +0100
Message-ID: <58cb370e0601190328j1fc3b2b4r8f27a956f097e2ef@mail.gmail.com>
References: <43CB4908.90502@mit.edu> <43CD4A94.2000708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.194]:21136 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161137AbWASL2g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 06:28:36 -0500
Received: by uproxy.gmail.com with SMTP id s2so183346uge
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2006 03:28:34 -0800 (PST)
In-Reply-To: <43CD4A94.2000708@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: O <xsdg@mit.edu>, linux-ide@vger.kernel.org

Hi,

On 1/17/06, Mark Lord <liml@rtr.ca> wrote:
> O wrote:
> > So, if I do `for dev in /dev/sd?; do smartctl -d ata -i $dev; done`, I get identical output for all 8 SCSI disk devices available (excluding timestamps).  Additionally, if I do `for dev in /dev/sd?1; ...`, I get the identical output for all of the devices with a filesystem probed, but this set of output is for a _different drive_ than the /dev/sd? output.  Output is listed below, after some info about my drives.  lspci and dmesg excerpts follow.
> >
> > All SCSI disk access (including usb-storage) seems to work properly.  Fetching smart data from my ATA drives seems to work fine as well (that is, hda works, and hdc and hdd are reported as not having any SMART data, which is correct also).  As far as I can tell, this problem only arises when the libata passthrough is used.
>
>
> Mmmm.. looks nasty.  Looks impossible, too, after glancing through the code.
> I wonder where the bug is hiding..

Here?

$ls -Hl /dev/sd*
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sda
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sda1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdb
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdb1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdc
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdc1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdd
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sdd1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sde
brw-rw----  1 root disk 8, 33 2006-01-16 03:20 /dev/sde1
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdf
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdg
brw-rw----  1 root disk 8, 16 2006-01-16 03:20 /dev/sdh

If these device nodes are dynamically created by udev
please check your udev rules.

Bartlomiej
