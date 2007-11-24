From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET] libata: update EH speed down logic, take #2
Date: Fri, 23 Nov 2007 20:04:59 -0500
Message-ID: <474778BB.5030909@garzik.org>
References: <1194241515653-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53243 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572AbXKXBFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:05:01 -0500
In-Reply-To: <1194241515653-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> This is the second take of update-EH-speed-down-logic patchset.
> Changes from the last take[1] are...
> 
> * Updated to apply & build against the current linus#master.  Recently
>   committed error-passthhrough-for-non-IO-command change broke build
>   with this patchset applied.
> 
> This patchset is against the current linux#master (b55d1b18).

ACK patchset (I think I already did this, but just to reinforce)

comments follow with next patchset response...


