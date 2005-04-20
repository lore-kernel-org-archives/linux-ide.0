From: Brett Russ <russb@emc.com>
Subject: Re: sending commands to the SATA drive
Date: Wed, 20 Apr 2005 06:26:50 -0400
Message-ID: <42662E6A.6030509@emc.com>
References: <OFC848C2D3.F3F922F3-ON48256FE8.002B7BD9@adtx.com.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:57545 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261542AbVDTK1B
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Apr 2005 06:27:01 -0400
In-Reply-To: <OFC848C2D3.F3F922F3-ON48256FE8.002B7BD9@adtx.com.ph>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laddie Michael C Zarsuelo/adtxp <lzarsuelo@adtx.com.ph>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Laddie Michael C Zarsuelo/adtxp wrote:
> I'm quite new to Linux and I need to create a monitoring program for our
> SATA hdd's.  I have to be able to send smart status commands to the drive.
> Is there a way to do this? I tried the HDIO_DRIVE_CMD in IOCTL but it wont
> work.  Is there a library function header file that I can include in my
> program so that I can access the libata functions and its variables?

Look into smartmontools at http://smartmontools.sf.net/  It's both a 
monitoring daemon (smartd) and a command line utility program 
(smartctl).  It uses a combination of ioctls including HDIO_DRIVE_CMD, 
HDIO_DRIVE_TASK, and HDIO_DRIVE_TASKFILE if I remember correctly.

BR
