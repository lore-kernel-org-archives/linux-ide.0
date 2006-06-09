From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 09 Jun 2006 12:43:37 +0900
Message-ID: <4488EE69.7050907@gmail.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488EB4A.4050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:14727 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWFIDnn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 23:43:43 -0400
Received: by py-out-1112.google.com with SMTP id t32so716013pyc
        for <linux-ide@vger.kernel.org>; Thu, 08 Jun 2006 20:43:43 -0700 (PDT)
In-Reply-To: <4488EB4A.4050501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> I'm still not sure I follow you?
> 
> When AHCI runs out of commands to execute, it transitions from H:Idle to 
> Ccc:SetIS.
> 
> IMPORTANT NOTE:  In order for CCC to be effective on AHCI, ahci.c and 
> libata (and sata_sil24) must be updated to support queuing a list of 
> non-NCQ commands onto the controller, and recovering from errors in the 
> case where a command list full of non-NCQ commands is present.

I thought about it but am not really sure whether it's worth the 
trouble.  We'll be saving on inter-command latency and interrupt 
handling which is great but not so sure how noticeable the improvement 
would be.  NCQ is already all around.  How about doing CCC only during 
NCQ command phase?

Hmmm... maybe those SSDs would benefit from CCC during non-NCQ commands 
though if they don't support NCQ, which they don't really need.

-- 
tejun
