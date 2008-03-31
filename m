From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Mon, 31 Mar 2008 13:34:31 +0900
Message-ID: <47F069D7.3010702@gmail.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:7287 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYCaEel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 00:34:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1825447wah.23
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 21:34:40 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, Robert Hancock <hancockr@shaw.ca>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

Kuan Luo wrote:
> For ADMA, I lean to disable it for default because stability is more
> important to our customers. At least, bug in this link:
> http://www.gossamer-threads.com/lists/linux/kernel/885929  is not
> resolved.

Robert, what do you think?  Should we disable ADMA by default from 
2.6.26-rcX?

-- 
tejun
