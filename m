From: Thomas Evans <tom@23palmer.net>
Subject: RE: sata_sil24 with port multiplier
Date: Fri, 21 Sep 2007 20:00:36 -0400
Message-ID: <E1IYsQE-0003Zt-9r@chronictown.23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:61595 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759452AbXIVAAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 20:00:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org

Applied this patch to my 2.22.1 installation (alpha w/pcix 3124 card. The patch made a huge difference whenprobing devices at start.  No 10 second retries followed by resets.

...tom


-----Original Message-----
From: Tejun Heo <htejun@gmail.com>
Sent: Friday, September 21, 2007 6:55 AM
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

Jon Chelton wrote:
> Hello,
> 
>  
> 
> I am having issues using kernel 2.6.22.1 with your latest patch
> applied.  I am using a Addonics 4 port SATA card with an external
> enclosure  and port multiplier connected to 4 250GB western digital SATA
> drives.   I am receiving this error frequently (on 2 systems with
> identical kernels and hardware). 

Does the attached patch fix the problem?

-- 
tejun
