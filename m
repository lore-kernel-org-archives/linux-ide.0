From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/13] libata-hp: implement hotplug
Date: Fri, 19 May 2006 12:04:40 -0400
Message-ID: <446DEC98.4050200@pobox.com>
References: <11480537071808-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2218 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932420AbWESQE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:04:58 -0400
In-Reply-To: <11480537071808-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ATA part of hotplug.  To avoid probing broken devices over
> and over again, disabled devices are not automatically detached.  They
> are detached only if probing is requested for the device or the
> associated port is offline.  Also, to avoid infinite probing loop,
> Each device is probed only once per EH run.
> 
> As SATA PHY status is fragile, devices are detached only after it has
> used up its recovery chances unless explicitly requested by LLDD or
> user (LLDD may request direct detach if, for example, it supports cold
> presence detection).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 1-2


