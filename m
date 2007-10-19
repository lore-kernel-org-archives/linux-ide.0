From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier Support for sata_sil24
Date: Sat, 20 Oct 2007 08:56:40 +0900
Message-ID: <47194438.5000601@gmail.com>
References: <200710191934.38349.greg@gkmweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:34305 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763347AbXJSX4p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 19:56:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so598653rvb
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 16:56:44 -0700 (PDT)
In-Reply-To: <200710191934.38349.greg@gkmweb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Meyer <greg@gkmweb.com>
Cc: linux-ide@vger.kernel.org

Greg Meyer wrote:
> Hi.  I was very excited to see port multiplier support for the sata_sil24 
> module in your patchset, but it does not appear to be working here, and I am 
> not sure if I am doing something wrong or if it still is not supported.  I am 
> working on a project to get a RAID enclosure that came with a Silicon Image 
> eSATA controller with a port multiplier. It is a MicroNet SR42000E.
> 
> We are using Ubuntu Gutsy 7.10 (upgraded to release version), with a 
> self-compiled 2.6.23.1 kernel, patched with libata-tj-2.6.23-20071011.  I 
> don't recall any special compile time options during the config, and modinfo 
> doesn't display anything that looks like a runtime option.
> 
> Interestingly, the device nodes are created for the 4 separate disks (which is 
> what we want), but no disk partitioning utility, like fdisk, cfdisk or 
> qparted can open the devices.  sata_sil24 is loaded.

Log looks fine.  What do "fdisk -l" and "ls -l /dev/sd*" say?

-- 
tejun
