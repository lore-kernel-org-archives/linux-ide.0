From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: fix NULL pointer dereference detected by Coverity
Date: Sat, 11 Mar 2006 19:10:18 -0500
Message-ID: <441366EA.1090403@pobox.com>
References: <20060310193414.GT21864@stusta.de> <20060311034754.GA31198@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:27063 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751265AbWCLAKX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:10:23 -0500
In-Reply-To: <20060311034754.GA31198@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Fix NULL pointer dereference detected by the Coverity checker.  Kill
> dev -> pdev -> dev conversion while at it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Adrian Bunk <bunk@stusta.de>

applied to #upstream-fixes


