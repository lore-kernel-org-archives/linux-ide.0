From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash on accessing
 DVD-RAM
Date: Thu, 31 Jan 2008 18:09:31 -0600
Message-ID: <47A2633B.8080807@shaw.ca>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:61559 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934555AbYBAAJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 19:09:36 -0500
In-reply-to: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander <aledin@mail.ru>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Alexander wrote:
> Hello!
> 
> The problem described at https://bugzilla.redhat.com/show_bug.cgi?id=351451 and
> at http://ubuntuforums.org/showthread.php?t=655772 and supposedly fixed by the
> patch http://kerneltrap.org/mailarchive/linux-kernel/2007/11/25/445094 is still
> there. I have compiled 2.6.24-rc7 kernel and booted my PC with it just to find
> out that my SATA DVD-RW is
> 
> sr0: scsi3-mmc drive: 0x/0x caddy
> 
> as it was before with 2.6.23.12 and earlier 2.6 kernels compiled for x86_64.
> Trying to use sr0 after this results in dead hang or reboot.
> When I put sata_nv.adma=0 or mem=4096M then it's all ok:

Can you (or others experiencing this problem) test the latest patch 
attached to the RH Bugzilla entry here:

https://bugzilla.redhat.com/show_bug.cgi?id=351451

and see if it resolves the problem? I have one report of success so far.
