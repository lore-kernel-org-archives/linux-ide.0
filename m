From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix libata-core.c kernel-doc warning
Date: Mon, 10 Aug 2015 11:44:35 -0400
Message-ID: <20150810154435.GB23408@mtj.duckdns.org>
References: <55C80060.8030308@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36747 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbbHJPoi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2015 11:44:38 -0400
Content-Disposition: inline
In-Reply-To: <55C80060.8030308@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, Aug 09, 2015 at 06:37:36PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning in libata-core.c:
> 
> Warning(..//drivers/ata/libata-core.c:4763): No description found for parameter 'tag'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to libata/for-4.3.

Thanks.

-- 
tejun
