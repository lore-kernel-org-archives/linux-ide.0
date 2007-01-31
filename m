From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Wed, 31 Jan 2007 04:16:25 -0500
Message-ID: <45C05E69.8060208@garzik.org>
References: <20070131021051.GA3403@bounceswoosh.org> <45C013B8.8030600@gmail.com> <45C020F7.7000305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55042 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbXAaJQ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 04:16:28 -0500
In-Reply-To: <45C020F7.7000305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> [The previous replay mysteriously didn't include Eric in To:, sorry,
> quoting whole message here.]
> 
> Tejun Heo wrote:
>> Hello, Eric.
>>
>> Eric D. Mudama wrote:
>>> Per Jeff's suggestion, this patch rearranges the info printed for ATA
>>> drives into dmesg to add the full ATA firmware revision and model
>>> information, while keeping the output to 2 lines.
>>>
>>> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>
>> The patch is formatted and applies perfectly.  I'm glad to see this
>> change.  Just a few nits below.
>>
>>>  	char revbuf[7];		/* XYZ-99\0 */
>>> +	char fwrevbuf[9];
>>> +	char modelbuf[41];
>> Please use ATA_ID_FW_REV_LEN + 1 and ATA_ID_PROD_LEN + 1.
> 
> This depends on to which version this patch applies.  For
> #upstream-fixes (2.6.20-rc6), you have to use raw numbers as you did.
> For #upstream, there are above two constants to use.  I think this patch
> is good for 2.6.20 as it's safe && will help us analyzing bug reports
> for 2.6.20.  So, ignore this part of the comment.

We have time to revise.  I only want to commit true bug fixes at this 
point, to 2.6.20.

	Jeff



