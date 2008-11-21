From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloading
Date: Sat, 22 Nov 2008 00:25:27 +0900
Message-ID: <4926D2E7.60108@kernel.org>
References: <4920292B.5060804@gc-web.de> <4920E909.2030400@kernel.org> <4920FA98.5050108@gc-web.de> <4920FE45.1040504@kernel.org> <49214331.4020400@gc-web.de> <49266B9E.7050402@kernel.org> <4926A4A5.5070204@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40671 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbYKUPZN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 10:25:13 -0500
In-Reply-To: <4926A4A5.5070204@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Alexander Clausen wrote:
> Tejun Heo wrote:
>> So, it's basically a system you assembled, right?
> 
> Yeah. So the storage-fixup thing only works for ready-made systems,>
> like laptops or Macs?

Well, it's basically blacklisting systems w/ certain configuration and
is a very static solution by definition, so can't really be applied to
random systems.  cc'ing Bruce Allen.  I think we definitely need
something more dynamic but still don't have much idea how it should be
done.  :-(

Thanks.

-- 
tejun
