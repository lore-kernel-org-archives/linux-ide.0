From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes] libata: set device class to NONE if phys_offline
Date: Wed, 22 Oct 2008 14:23:31 +0400
Message-ID: <48FEFF23.5090006@ru.mvista.com>
References: <48FDF5D6.20707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31132 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751424AbYJVKXh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 06:23:37 -0400
In-Reply-To: <48FDF5D6.20707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Tejun Heo wrote:

> Reset methods don't have access to phys link status for slave links
> and may incorrectly indicate device presence causing unnecessary probe
> failures for unoccupied links.  This patch clears device class to NONE
> during post-reset processing if phys link is offline.
>
> As on/offliness semantics is strictly defined and used in multiple
>   

   More grammar nitpicking: it's either on/offline or on/offlineness. :-)

MBR, Sergei


