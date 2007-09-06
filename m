From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Thu, 06 Sep 2007 02:52:48 -0700
Message-ID: <46DFCDF0.6050107@vc.cvut.cz>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz> <46DC030E.9070704@gmail.com> <46DCB709.902@vc.cvut.cz> <46DE9C20.9030007@vc.cvut.cz> <20070905213006.GH22695@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:44722 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbXIFJwz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Sep 2007 05:52:55 -0400
In-Reply-To: <20070905213006.GH22695@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Richard Scobie <richard@sauce.co.nz>

Robin H. Johnson wrote:
> On Wed, Sep 05, 2007 at 05:08:00AM -0700, Petr Vandrovec wrote:
>>> 3124-2 (norco 4618):
>>> NCQ:
>>> 1TB alone:   82.30, 82.43
>>> 1TB+1TB:     68.36+68.25
>>> noNCQ:
>>> 1TB alone:   82.39, 82.29
>>> 1TB+1TB:     70.33+70.32, 69.47+70.01
>>> Unfortunately that enclosure has only two slots used.  I'll try to not 
>>> forget bring two more disks tomorrow to get it fully populated.
>>  In case you are still follwing this thread, 3124-2 with 4 1TB drives 
>>  delivers 58.5MBps for each drive with NCQ enabled, and 60MBps with NCQ 
>>  disabled - total 235-240MBps read speed.  I would like to see 320MBps, but 
>>  apparently today is not my lucky day...
> Just to confirm, how were you testing the multiple drive combination?

Concurrent hdparm -t, like

hdparm -t /dev/sdd & hdparm -t /dev/sde & hdparm -t /dev/sdf & hdparm -t 
/dev/sdg & sleep 20

(and from hdparm output & visually confirmed that all activity LEDs go 
on & off simultaneously)

So NCQ should not be able to show any (definitely not huge) benefits, 
but there should not be any reason to not get 4x 1 drive speed as long 
as neither PMP link nor PCI-X limits are hit.
								Petr

