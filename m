From: Tejun Heo <tj@kernel.org>
Subject: Re: Issue with AHCI driver
Date: Fri, 01 Aug 2008 13:06:54 +0900
Message-ID: <48928BDE.9050806@kernel.org>
References: <29493114.1215703025597.JavaMail.root@elwamui-lapwing.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58250 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYHAEHa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 00:07:30 -0400
In-Reply-To: <29493114.1215703025597.JavaMail.root@elwamui-lapwing.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> Sorry about the multiple e-mails Jeff, but our IT group has seen fit
> to deny me the ability to send e-mail to vger.kernel.org so I'm
> trying again from my own personal account. 
> -------------------------------------------------------------------
> 
> 
> My name is Bob Hoffman.  I am a software engineer for Micron
> Technology in Minneapolis.  I have been working on AHCI drivers.  We
> recently installed kernel build 2.6.19.0 (unpatched) of Linux on an
> Intel motherboard system which includes the ICH9 SATA controller.  We
> have been running some benchmarks and found that the SATA harddrives
> looked slow.  When I attached a SATA analyzer it shows that we are
> only getting one command "in flight" or "outstanding" at a time, and
> it is always slot (or tag) zero.  The AHCI driver doesn't seem to be
> taking advantage of the 32 deep queue.
> 
> I checked the queue depth using the info at
> http://linux-ata.org/faq.html#io32 and it shows "NCQ (depth 31/32)".
> I'm wondering if there is something else I need to know.
> 
> I've copied our "Linux guru", Bob Ward, who knows more about the
> kernel stuff than I do.
> 
> Thank you for any help you can provide. Bob (Hoffman) ; ) -- To
> unsubscribe from this list: send the line "unsubscribe linux-ide" in 
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
> 

What kind of workload are you testing?  If you're doing multiple random
IOs, using deadline io scheduler will give you a better result.  Can't
say whether that would help on any realistic workload tho.

-- 
tejun
