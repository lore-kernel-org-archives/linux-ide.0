From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [BUG 2.6.21-rc3-git9] SATA NCQ failure with Samsum HD401LJ
Date: Fri, 16 Mar 2007 07:56:33 -0600
Message-ID: <45FAA211.5030402@shaw.ca>
References: <fa.wBi/iM3CKSfrll7UnPHTbU0scEQ@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47474 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933848AbXCPN4p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 09:56:45 -0400
In-reply-to: <fa.wBi/iM3CKSfrll7UnPHTbU0scEQ@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

(linux-ide cc'ed)

Max Kellermann wrote:
> Hi,
> 
> I have been trying to upgrade my 2.6.19 kernel for a while now,
> without success.  All kernel versions since 2.6.20 failed with a
> timeout while trying to write to my SATA hard disk.  After I wait for
> a while (during which all I/O to the hard disk blocks), the kernel
> message "NCQ disabled due to excessive errors" appears, and the system
> seems to work perfectly.
> 
> My system is an Athlon64 X2 on an Asus A8N-Premium.  I'm using the
> sata_nv driver for the on-board SATA controller.  My only hard disk is
> a Samsum HD401LJ (400 GB).
> 
> The kernel is build statically, and the only module is nvidia.ko.  If
> someone believes it may make a difference, I can try the kernel
> without the proprietary module.
> 
> Please see the kernel config and dmesg attached to this email.
> 
> I don't know the libata subsystem well, but I suspect my hard drive
> has to be added to the NCQ blacklist.
> 
> Max

This does indeed look like a drive side issue to me (the controller is 
reporting CPBs with response flags 2 which as far as I can tell 
indicates it's still waiting for the drive to complete the request).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

