From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Fri, 11 Jul 2014 10:47:01 -0400
Message-ID: <20140711144701.GB27706@htj.dyndns.org>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
 <53BFD10D.3080005@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:60246 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaGKOrG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 10:47:06 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so1070704qcy.3
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 07:47:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53BFD10D.3080005@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Kevin Hao <haokexin@gmail.com>, linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Fri, Jul 11, 2014 at 03:57:01PM +0400, Sergei Shtylyov wrote:
> >-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> >-		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
> >+	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
> >+		tag = tag < max_queue ? tag : 0;
> 
>    Assigning 'tag' back to 'tag' is quite stupid, don't you think? Why not:
> 
> 		if (tag >= max_queue)
> 			tag = 0;

I don't really mind it and the explicit if block isn't more readable
in any way.

Thanks.

-- 
tejun
