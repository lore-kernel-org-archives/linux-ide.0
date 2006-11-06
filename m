From: John Woznack <jwoznack@d-a-s.com>
Subject: Re: Supported chipsets with sata_sil24?
Date: Mon, 6 Nov 2006 08:36:16 -0500
Message-ID: <pv5ttji1w0qr$.1ftk6q36he52r.dlg@40tude.net>
References: <fnjo4zvd52iy.1rdumsth8vh91$.dlg@40tude.net> <454D27EB.1070907@gmail.com>
Reply-To: jwoznack@d-a-s.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44202 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1753095AbWKFNhL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2006 08:37:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gh4dz-0002ln-89
	for linux-ide@vger.kernel.org; Mon, 06 Nov 2006 14:36:07 +0100
Received: from static-64-83-36-8.t1.cavtel.net ([64.83.36.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Nov 2006 14:36:07 +0100
Received: from jwoznack by static-64-83-36-8.t1.cavtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Nov 2006 14:36:07 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, 05 Nov 2006 08:53:15 +0900, Tejun Heo wrote:

> John Woznack wrote:
>> Out of curiosity, which Silicon Image chipsets are supported by the
>> sata_sil24 driver? (3124/3132 obviously,but what about 3512, 3112, 3531,
>> and 3726?)
> 
> sata_sil24	: 3124, 3132, 3131, 3531
> sata_sil	: 3112, 3114, 3512 and some other variants
> 
> 3726 and 4726 are port multipliers and supported by pending PMP patchset.

Thanks Tejun. Just what I was looking for.

After checking out http://linux-ata.org/driver-status.html, I've got Just a
few more questions: 

1. The sata_sil24 shows it supports NCQ. Out of curiosity, how can I tell
if it's using NCQ? 

2. The sata_sil24 and sata_sil drivers support suspend. Can you explain
this in more detail? (Like, is it always on or do I have to enable it? Can
I set the idle timeout-to-suspend somehow? etc.)

Thanks!

