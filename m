From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: port and device of libata.force ID separated
 by point
Date: Fri, 23 Apr 2010 02:37:44 +0200
Message-ID: <4BD0EBD8.9060308@kernel.org>
References: <201004211217.12697.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35434 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609Ab0DWGIN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 02:08:13 -0400
In-Reply-To: <201004211217.12697.roman.fietze@telemotive.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roman Fietze <roman.fietze@telemotive.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 04/21/2010 12:17 PM, Roman Fietze wrote:
> Hello,
> 
> If I understand libata-core correctly, esp. arround line 6572:
> 
> 	/* parse id */
> 	p = strchr(id, '.');
> 	...
> 
> the optional device is separated from the port in the libata.force ID
> by a point or dot instead of by a colon.
> 
> If my assumption is correct, this patch will fix the documentation:
> 
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>

Heh, nice catch.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
