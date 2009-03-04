From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Wed, 04 Mar 2009 02:03:34 -0500
Message-ID: <49AE27C6.5050205@pobox.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46717 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbZCDHDm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Mar 2009 02:03:42 -0500
In-Reply-To: <200903032029.29073.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, stf_xl@wp.pl

Sergei Shtylyov wrote:
> Declare and use constants for CFA specific identify data words 162 and 163.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is against the current pata-2.6 series. I'd prefer that Bart merged
> it thru his tree as my next patch adding CF mode support to IDE depends on it.

ACK, that's fine with me


