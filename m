From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Fri, 02 Mar 2007 18:31:20 -0500
Message-ID: <45E8B3C8.2090009@garzik.org>
References: <20070302083001.GK20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54702 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992741AbXCBXbW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:31:22 -0500
In-Reply-To: <20070302083001.GK20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Some LLDs were missing scsi device PM callbacks while having host/port
> suspend support.  Add missing ones.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3, though I agree with Alan that a non-ifdef solution should 
be sought (by the PM & PCI people?), where possible


