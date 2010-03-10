From: Tomasz Palac <palac@uci.agh.edu.pl>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Wed, 10 Mar 2010 10:40:34 +0100 (CET)
Message-ID: <Pine.GSO.4.63.1003101012480.8035@galaxy.agh.edu.pl>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl>
 <4B95AEF6.8030906@kernel.org> <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl>
 <4B97323E.1040807@kernel.org> <Pine.GSO.4.63.1003100853360.21647@galaxy.agh.edu.pl>
 <4B97595C.7010104@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galaxy.agh.edu.pl ([149.156.96.9]:59898 "EHLO galaxy.agh.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391Ab0CJJkf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 04:40:35 -0500
In-Reply-To: <4B97595C.7010104@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wed, 10 Mar 2010, Tejun Heo wrote:

>> How do you calculate geometry from newer Windows partition tables (cases
>> W-1, W-2 and W-3)?
>
> By solving the equations matching CHSs and LBAs.  It only works if the
> first partition ends before the CHS address limit (2 variables to
> solve for so we need 2 different equations).

Thanks for explanation. So with 64/32 geometry this should work for 
partitions smaller than 1 GiB. With 255/63 geometry this limit is 8 GiB 
and there are partitions bigger than that. Maybe for bigger partitions 
BIOSes use ending CHS?

> The only reason we're talking about geometry is for compatibility w/ 
> older operating systems.  So, at this point, diddling with geometry just 
> doesn't make any sense at all.

If we "do as Windows do" and make partitions aligned at 1 MiB but not 
aligned at cylinder boundary, then there is no way to boot Windows 2000 or 
older OS. If we use 64/32 geometry, there is a chance (maybe small) that 
BIOS will calculate or assume correct CHS values and older OS can boot. 
And this geometry cannot hurt newer OSes.

-- 
Tomasz Palac, AGH University of Science and Technology
