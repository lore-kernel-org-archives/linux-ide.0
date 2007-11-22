From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA port multiplier Identify/Fail LEDs: driver support
Date: Thu, 22 Nov 2007 10:15:51 +0900
Message-ID: <4744D847.8040005@gmail.com>
References: <1195587606.9402.43.camel@ragnarok.coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:20931 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbXKVBQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Nov 2007 20:16:03 -0500
Received: by nz-out-0506.google.com with SMTP id s18so2107963nze
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2007 17:16:02 -0800 (PST)
In-Reply-To: <1195587606.9402.43.camel@ragnarok.coplanar.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-ide@vger.kernel.org

Jeremy Jackson wrote:
> Hi,
> 
> I have Addonics.com port multiplier which has SiI3726 chip.  I'm pretty
> sure it has LED outputs that are software controllable, to use with RAID
> enclosures for Identifying drives (that have failed for example).
> 
> I wonder if anyone has chipset docs that can be used to write Linux
> drivers for this function?  A brief email to Silicon Images a while back
> wasn't very helpful, IIRC.

Yeah, the chip has built-in enclosure controller and libata doesn't have
support for it yet.  One of the reasons being I can't find any hardware
which uses that feature here.  :-(

-- 
tejun
