From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sat, 29 Mar 2008 22:38:38 +0900
Message-ID: <47EE465E.80401@gmail.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:30835 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbYC2Nit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 09:38:49 -0400
Received: by wf-out-1314.google.com with SMTP id 28so641221wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 06:38:48 -0700 (PDT)
In-Reply-To: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, zboszor@dunaweb.hu, hancockr@shaw.ca

akpm@linux-foundation.org wrote:
> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> 
> unchangelogged patch.
> 
> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> Cc: Robert Hancock <hancockr@shaw.ca>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Nacked-by: Tejun Heo <htejun@gmail.com>

Sorry, there are remaining issues to resolve before enabling ADMA by 
default.

-- 
tejun
