From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Mon, 7 Jul 2014 13:56:59 -0700
Message-ID: <CAPcyv4jNXtjn4p0MKa0fFkuGGLNs4iyFNaaufGKJWFHa65jBZA@mail.gmail.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
	<1404628121-8158-2-git-send-email-haokexin@gmail.com>
	<CAPcyv4gLb6i5PSi9_uxHv-UQA8-w=a55eOP1GtkXmvTzY5P+7A@mail.gmail.com>
	<20140707200610.GA1283@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62265 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaGGU5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 16:57:00 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so1317666iec.8
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 13:57:00 -0700 (PDT)
In-Reply-To: <20140707200610.GA1283@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kevin Hao <haokexin@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Jul 7, 2014 at 1:06 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Jul 07, 2014 at 11:19:25AM -0700, Dan Williams wrote:
>> This change may cause the compiler to do a full divide where
>> previously it could optimize to power-of-2 math with the visibility of
>> the ATA_MAX_QUEUE constant.  How about converting
>> ap->host->queue_depth to ap->host->queue_depth_mask?  ...then this
>> becomes:
>>
>>     tag = (i + ap->last_tag + 1) & max_queue_mask
>
> Given how inefficient the test_and_set bit is, I don't think a single
> moduls matters.  Plus, we don't even need modulus there.  We can
> simply use >= max_depth.

True, sounds good.
