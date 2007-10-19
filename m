From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_sis: fix SCR read breakage
Date: Fri, 19 Oct 2007 11:23:32 +0900
Message-ID: <47181524.6080905@gmail.com>
References: <20071018025339.GB18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:32439 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759953AbXJSCXi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 22:23:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so329299rvb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 19:23:37 -0700 (PDT)
In-Reply-To: <20071018025339.GB18322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> SCR read for controllers which uses PCI configuration space for SCR
> access got broken while adding @val argument to SCR accessors.  Fix
> it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

JFYI, reporter of bug 9164 confirmed the fix.

-- 
tejun
