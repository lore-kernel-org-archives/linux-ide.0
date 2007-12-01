From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/8] libata: rearrange ATA_DFLAG_*
Date: Sat, 01 Dec 2007 18:05:52 -0500
Message-ID: <4751E8D0.8070801@garzik.org>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593391512-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53047 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbXLAXFz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:05:55 -0500
In-Reply-To: <11961593391512-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Tejun Heo wrote:
> Area for DFLAGs which are cleared on INIT is full.  Extend it by 8
> bits.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  include/linux/libata.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

applied 1-8 to #upstream


