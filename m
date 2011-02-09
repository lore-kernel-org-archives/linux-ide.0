From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 16:36:01 +0100
Message-ID: <20110209153601.GJ3770@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53724 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1BIPgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 10:36:07 -0500
Received: by bwz15 with SMTP id 15so1086454bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 07:36:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110209153714.558133d7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phillip Susi <psusi@cfl.rr.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Feb 09, 2011 at 03:37:14PM +0000, Alan Cox wrote:
> Probably the fakeraid layers need a way to see the geometry reported
> before unlock, then they can make their own decisions. The lock/unlock in
> hardware is just a hardware hack. We can still do the unlocking of
> hardware and using whatever values we choose in software at different
> points.
> 
> "Should we unlock" is almost an academic debate given we are the OS and
> control the commands sent to the drive anyway.

Agreed.  We're screwed whether we unlock or leave it alone.  I think
the best way is to export the original size via sysfs and always
unlock and let dmraid and whatever stuff which expects metadata at the
end use the bios size.  I seem to recall actually implementing it.
Wondering where it went....

-- 
tejun
