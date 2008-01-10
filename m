From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Wed, 09 Jan 2008 18:33:28 -0600
Message-ID: <478567D8.10601@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
 <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
 <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca>
 <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com>
 <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com>
 <4783493A.7070800@gmail.com> <47838B57.8020407@shaw.ca>
 <47842A54.2060107@gmail.com> <47842ABA.2060605@gmail.com>
 <47844471.4070705@shaw.ca> <47845708.6060900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:3145 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbYAJAdy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 19:33:54 -0500
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUE00C3VK802CC0@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 17:33:36 -0700 (MST)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
 by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUE00DE1K7ZOM20@pd2mr5so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 09 Jan 2008 17:33:36 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUE00JGPK7YVC30@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 17:33:35 -0700 (MST)
In-reply-to: <47845708.6060900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
>> How about putting a bunch of printks inside the interrupt handler? That
>> would tell us if it's even reaching the interrupt handler..
> 
> If you give me a patch, I'll apply it and cause lock up and report the
> result.  Just shoot the patches my way.  But maybe reproducing the lock
> up on your machine would be the better solution.  It isn't difficult at
> all.  Plug in, fire up IO, disconnect, wait.  Connect different drive.
> Rinse and repeat.  It will lock up pretty soon.

Unfortunately my nForce4 machine is my main box with 2 drives, neither 
of which exactly have expendable contents, so random hotplug/unplug 
tests with IO in progress seem a bit risky..

However, how about putting in a printk in nv_adma_interrupt handler here:

/* freeze if hotplugged or controller error */
if (unlikely(status & (NV_ADMA_STAT_HOTPLUG |
		       NV_ADMA_STAT_HOTUNPLUG |
		       NV_ADMA_STAT_TIMEOUT |
		       NV_ADMA_STAT_SERROR))) {
	struct ata_eh_info *ehi = &ap->link.eh_info;
		ata_ehi_clear_desc(ehi);
--->	ata_port_printk("ADMA status 0x%08x: ", status);
	__ata_ehi_push_desc(ehi, "ADMA status 0x%08x: ", status);


That should tell us if it reaches the point of the hotplug/unplug 
interrupt but failed before or during the error handling.

If that doesn't give anything useful, you can try and move that printk 
before the if, but that will likely flood you with a lot of output from 
every interrupt that fires..
