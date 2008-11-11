From: Tejun Heo <tj@kernel.org>
Subject: Re: reenable DMA
Date: Tue, 11 Nov 2008 17:41:21 +0900
Message-ID: <49194531.1000802@kernel.org>
References: <gedae1$ari$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57794 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbYKKIlo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:41:44 -0500
In-Reply-To: <gedae1$ari$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org

kenneth johansson wrote:
> I have a small problem where my DVD player got confused by a disk
> and the ata driver ended up putting the driver in PIO mode. 
> 
> Now I need to get it back into DMA without rebooting the computer. 
> 
>  hdparm -d1 /dev/sr0

Sorry it isn't implemented yet but why does libata get confused in the
first place?  Care to post logs?

Thanks.

-- 
tejun
