From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: blacklist FUJITSU MHW2160BH PL
Date: Tue, 10 Jun 2008 16:29:37 +0900
Message-ID: <484E2D61.8000604@gmail.com>
References: <1212512005-13284-1-git-send-email-max@stro.at> <484DEB57.8060508@gmail.com> <20080610071903.GA24102@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:21082 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFJH3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 03:29:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2475290wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 00:29:43 -0700 (PDT)
In-Reply-To: <20080610071903.GA24102@stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Chuck Short <zulcss@ubuntu.com>, Tim Gardner <tim.gardner@canonical.com>

maximilian attems wrote:
> On Tue, 10 Jun 2008, Tejun Heo wrote:
> 
>> maximilian attems wrote:
>>> From: Chuck Short <zulcss@ubuntu.com>
>>>
>>> OriginalAuthor: Chuck Short <zulcss@ubuntu.com>
>>> Bug: #175834
>> OSDL bz #175834 does not exist and even if it did having some
>> explanation on patch itself wouldn't hurt.

Eh... spurious completion check itself was spurious and got removed, so
the patch is not necessary.

Thanks.

-- 
tejun
