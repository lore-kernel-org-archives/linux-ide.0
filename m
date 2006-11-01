From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] sata_sil: implement Mod15Write workaround by split
 request processing
Date: Wed, 01 Nov 2006 18:16:11 +0900
Message-ID: <454865DB.1060000@gmail.com>
References: <11612370993859-git-send-email-htejun@gmail.com> <4547FF96.4070808@pobox.com> <454803BB.6000006@gmail.com> <454806F1.8010703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:31501 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946716AbWKAJQU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:16:20 -0500
Received: by nf-out-0910.google.com with SMTP id c2so734987nfe
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:16:18 -0800 (PST)
In-Reply-To: <454806F1.8010703@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Sorry, I just think it adds too much complexity to sata_sil itself.  If 
> the driver ever grows PIO-DMA support, it may make sense in that case, 
> since you would need the complexity (sil context) anyway.
> 
> Seeing the patch, and comparing with the current driver, really weights 
> in favor of the current more-simple driver.  There are a lot of 
> "early-rev hardware bug" things that we just don't bother with in Linux, 
> and I think this is one of them.

Okay, I'll maintain it out-of-tree then.

-- 
tejun
