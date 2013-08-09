From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH 1/2] ata: pata_arasan: Staticize local symbols
Date: Fri, 9 Aug 2013 10:13:25 -0400
Message-ID: <20130809141325.GE20515@mtj.dyndns.org>
References: <000001ce94c2$30c95430$925bfc90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55289 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967887Ab3HIONb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:13:31 -0400
Received: by mail-qa0-f49.google.com with SMTP id cr7so925071qab.1
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:13:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000001ce94c2$30c95430$925bfc90$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>

On Fri, Aug 09, 2013 at 02:35:00PM +0900, Jingoo Han wrote:
> These local symbols are used only in this file.
> Fix the following sparse warnings:
> 
> drivers/ata/pata_arasan_cf.c:657:6: warning: symbol 'arasan_cf_error_handler' was not declared. Should it be static?
> drivers/ata/pata_arasan_cf.c:686:14: warning: symbol 'arasan_cf_qc_issue' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.12.

Thanks.

-- 
tejun
