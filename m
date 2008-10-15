From: Tejun Heo <tj@kernel.org>
Subject: Re: VIA SATA/PATA problem
Date: Wed, 15 Oct 2008 11:33:26 +0900
Message-ID: <48F55676.1070806@kernel.org>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>	 <48F3FFD3.6090009@kernel.org> <1223990866.13924.182.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58726 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbYJOCfT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 22:35:19 -0400
In-Reply-To: <1223990866.13924.182.camel@jetpack.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan Hourihane wrote:
> 00:0a.3 RAID bus controller [0104]: VIA Technologies, Inc. VT6421 IDE
> RAID Controller [1106:3249] (rev 50)              
> 
> I still need to do Mikael's suggestion of plugging it into an x86 box
> and checking it's PCI config space.

I was hoping it was 5287 which sata_via currently doesn't fully support.
 I think you'll need to try the PCI config space trick.

Thanks.

-- 
tejun
