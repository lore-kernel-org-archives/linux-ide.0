From: Tejun Heo <tj@kernel.org>
Subject: Re: sata error on ICH8M
Date: Wed, 12 Nov 2008 10:43:58 +0900
Message-ID: <491A34DE.5030406@kernel.org>
References: <alpine.DEB.2.00.0811040833110.24370@dirac.rather.puzzling.org> <49199029.8070802@kernel.org> <4919976E.6020205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41840 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbYKLBoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 20:44:08 -0500
In-Reply-To: <4919976E.6020205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tim Connors <tconnors@rather.puzzling.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
>> I really need to see how the recovery attempt failed.  Can you please
>> reproduce the problem and report the kernel log?  Also, please report
>> how reproducible the problem is.
> ...
> 
> 
> I wonder if this is another scenario, where a full reset of the AHCI host
> would recover the system, similar to the one I emailed you about last
> month.. ?

The one you emailed me last month didn't require host reset after all.
It just needed small adjustment to reset protocol and the upstream
kernel worked fine with it w/o any modification.

Thanks.

-- 
tejun
