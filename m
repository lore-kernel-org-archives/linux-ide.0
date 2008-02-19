From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_mv: remove iounmap in mv_platform_remove and use
 devm_iomap
Date: Wed, 20 Feb 2008 08:25:00 +0900
Message-ID: <47BB654C.10103@gmail.com>
References: <12033601481951-git-send-email-saeed@marvell.com> <47B9D534.3090902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:58315 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYBSXZJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 18:25:09 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2307527wra.23
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 15:25:07 -0800 (PST)
In-Reply-To: <47B9D534.3090902@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, mlord@pobox.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, byron.bbradley@gmail.com, tbm@cyrius.com

Mark Lord wrote:
> Saeed Bishara wrote:
>> this will fix crash bug when doing rmmod to the driver, this is
>> because the
>> port_stop function get called later and it could access the device's
>> registers.
>>
>> Signed-off-by: Saeed Bishara <saeed@marvell.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
