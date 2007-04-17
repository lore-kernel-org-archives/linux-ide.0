From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: kill type mismatch compile warning
Date: Tue, 17 Apr 2007 10:49:47 -0400
Message-ID: <4624DE8B.704@garzik.org>
References: <20070412043811.GG10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39780 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030522AbXDQOtu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:49:50 -0400
In-Reply-To: <20070412043811.GG10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> kill the following compile warning.
> 
> drivers/ata/libata-core.c:1786: warning: comparison of distinct pointer types lacks a cast
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


