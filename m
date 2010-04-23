From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: kill ata_bus_reset()
Date: Fri, 23 Apr 2010 02:43:29 +0200
Message-ID: <4BD0ED31.5050101@kernel.org>
References: <201004222003.36076.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35436 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755971Ab0DWGIO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 02:08:14 -0400
In-Reply-To: <201004222003.36076.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 04/22/2010 06:03 PM, Sergei Shtylyov wrote:
> ... since I see no callers of it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Hooray!

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
