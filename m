From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Mon, 7 Jul 2014 16:06:10 -0400
Message-ID: <20140707200610.GA1283@mtj.dyndns.org>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
 <1404628121-8158-2-git-send-email-haokexin@gmail.com>
 <CAPcyv4gLb6i5PSi9_uxHv-UQA8-w=a55eOP1GtkXmvTzY5P+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:54784 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaGGUGN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 16:06:13 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so4218813qga.31
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 13:06:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPcyv4gLb6i5PSi9_uxHv-UQA8-w=a55eOP1GtkXmvTzY5P+7A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kevin Hao <haokexin@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Jul 07, 2014 at 11:19:25AM -0700, Dan Williams wrote:
> This change may cause the compiler to do a full divide where
> previously it could optimize to power-of-2 math with the visibility of
> the ATA_MAX_QUEUE constant.  How about converting
> ap->host->queue_depth to ap->host->queue_depth_mask?  ...then this
> becomes:
> 
>     tag = (i + ap->last_tag + 1) & max_queue_mask

Given how inefficient the test_and_set bit is, I don't think a single
moduls matters.  Plus, we don't even need modulus there.  We can
simply use >= max_depth.

Thanks.

-- 
tejun
