From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: blacklist FUJITSU MHT2060BH for NCQ
Date: Thu, 01 Mar 2007 20:16:53 -0500
Message-ID: <45E77B05.7020308@garzik.org>
References: <20070228062123.GJ20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46238 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161152AbXCBBQz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:16:55 -0500
In-Reply-To: <20070228062123.GJ20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, maccetta@laurelnetworks.com

Tejun Heo wrote:
> Blacklist FUJITSU MHT2060BH for NCQ.  On this drive, NCQ works iff
> queue depth is equal to or less than 4.  Just turn it off.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mike Accetta <maccetta@laurelnetworks.com>

applied


