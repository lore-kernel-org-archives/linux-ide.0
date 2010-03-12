From: Tejun Heo <tj@kernel.org>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Fri, 12 Mar 2010 10:37:20 +0900
Message-ID: <4B999AD0.2090309@kernel.org>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl> <4B95AEF6.8030906@kernel.org> <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl> <4B97323E.1040807@kernel.org> <Pine.GSO.4.63.1003100853360.21647@galaxy.agh.edu.pl> <4B97595C.7010104@kernel.org> <Pine.GSO.4.63.1003101012480.8035@galaxy.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51945 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab0CLBh2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 20:37:28 -0500
In-Reply-To: <Pine.GSO.4.63.1003101012480.8035@galaxy.agh.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Palac <palac@uci.agh.edu.pl>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/10/2010 06:40 PM, Tomasz Palac wrote:
>> By solving the equations matching CHSs and LBAs.  It only works if the
>> first partition ends before the CHS address limit (2 variables to
>> solve for so we need 2 different equations).
> 
> Thanks for explanation. So with 64/32 geometry this should work for
> partitions smaller than 1 GiB. With 255/63 geometry this limit is 8 GiB
> and there are partitions bigger than that. Maybe for bigger partitions
> BIOSes use ending CHS?

I suspect more BIOSs would just assume 255/63 regardless of the
partition layout these days.  For bigger partitions, the ending CHS is
just a marker saying that it's off the limit and there really isn't
any information to calculate from.

>> The only reason we're talking about geometry is for compatibility w/
>> older operating systems.  So, at this point, diddling with geometry
>> just doesn't make any sense at all.
> 
> If we "do as Windows do" and make partitions aligned at 1 MiB but not
> aligned at cylinder boundary, then there is no way to boot Windows 2000
> or older OS. If we use 64/32 geometry, there is a chance (maybe small)
> that BIOS will calculate or assume correct CHS values and older OS can
> boot. And this geometry cannot hurt newer OSes.

Going forward, I think it would be simply better and less painful to
stick to the simpler scheme which is also employed by Windows and
allowing some way to use the old alignment for certain partitions for
those few special cases where really old OSs need to be used.  The
benefit of 64/32 or any other custom geometry seems marginal at best
and mostly imaginary to me.

Thanks.

-- 
tejun
