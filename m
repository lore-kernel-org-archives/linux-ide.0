From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: make ULi M5288 ignore interface fatal error bit
Date: Wed, 24 Jan 2007 01:57:49 -0500
Message-ID: <45B7036D.1030405@pobox.com>
References: <20070123061339.GA8673@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54116 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933172AbXAXG5x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 01:57:53 -0500
In-Reply-To: <20070123061339.GA8673@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> As with JMicron controllers, ULi M5288 sets interface fatal error bit
> on device error including ATAPI CC.  This makes libata hardreset the
> port on ATAPI CC thus making it impossible to use.  Ignore interface
> fatal error bit on ULi M5288.  This fixes bugzilla bug #7837.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this is a regression.  Please commit to both #upstream and
> #upstream-fixes.  Thanks.

applied


