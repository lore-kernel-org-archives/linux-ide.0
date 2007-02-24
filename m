From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.20] libata: Support HDIO_DRIVE_TASKFILE ioctl
Date: Sat, 24 Feb 2007 13:29:27 +0900
Message-ID: <45DFBF27.1060707@gmail.com>
References: <31e4e9500702211813g6d3d6431oda1f6191f056a02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:47054 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385AbXBXE3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 23:29:33 -0500
Received: by py-out-1112.google.com with SMTP id a29so353568pyi
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 20:29:33 -0800 (PST)
In-Reply-To: <31e4e9500702211813g6d3d6431oda1f6191f056a02e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: anand.kulkarni.remove.this@banashankari.net
Cc: linux-ide@vger.kernel.org, Anand.Kulkarni@hitachigst.com

Hello,

Anand Kulkarni wrote:
> Hi,
> 
> Attached is a patch to allow HDIO_DRIVE_TASKFILE ioctl calls to libata
> devices so that arbitrary ATA commands that need PIO data transfers in
> either direction can be issued. I have tested it with linux kernel
> 2.6.20. The format of the input arguments is the same as for the
> regular ATA HDIO_DRIVE_TASKFILE ioctl : Code that makes ioctl calls to
> ATA devices on /dev/hda can be sent as is to SATA devices on /dev/sda.
> 
> Since this is the first time I am sending a patch, please let me know
> if I should do anything differently.

I was kind of hoping we could drop HDIO_DRIVE_TASKFILE.  Please take a
look at the HDIO_DRIVE_TASKFILE section of Documentation/ioctl/hdio.txt.
 That's one scary scary ioctl and we still haven't sorted out which are
features and which are bugs.

For backward compatibility HDIO_DRIVE_CMD and HDIO_DRIVE_TASK are
implemented and most applications seem to be happy with it.  If you need
real fine control over command execution, the recommended way is to use
SAT via SG_IO.

-- 
tejun
