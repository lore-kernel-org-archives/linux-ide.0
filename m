From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: [git patches] 2.6.x libata updates
Date: Wed, 04 Jan 2006 20:35:18 +0000
Message-ID: <43BC3186.8060103@projecthugo.co.uk>
References: <20060103164319.GA402@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host81-138-64-234.in-addr.btopenworld.com ([81.138.64.234]:17606
	"HELO alesi.projecthugo.co.uk") by vger.kernel.org with SMTP
	id S965231AbWADUf0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jan 2006 15:35:26 -0500
In-Reply-To: <20060103164319.GA402@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:

>Please pull from 'upstream' branch of
>master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
>to receive the following updates:
>  
>
<snip>

Well I've been using this update now for a few days.

For my own personal problem (sata_mv stability) I see both positive and 
negative results over both 2.6.15-rc5-mm3 and 2.6.15

First postitive:

The bug I was experiening of a raid array 5 array not being visiable or 
startable due to array disks being not being seen as part of the array 
after a reboot appears to have gone. I say appears to as I can't test 
this %100 due to the negative aspect of this kernel. the array starts 
building - no problems gets about %35 through, and the whole machine 
just hangs total lock up.

The reason this is still positive is because when I reboot the box, the 
unfinished md starts rebuilding again, suggesting that this kernel 
actually sees all the disks in the array after a reboot (which 
2.6.15-rc5-mm3 wasn't)

the hang of the system is pretty fatal though.

I'd be interested in what other people are seeing with this kernel tree.

I'm about to test a theroy of building the array with 2.6.15-rc5-mm3 
which can build the array fine, but it dissapears after a reboot, but on 
reboot I'll reboot into the latest libata-git kernel to see if the disks 
are visible.

thoughts or personal experiences (or requests for info on solving some 
of these problems) welcome.

Thanks,

Matt



