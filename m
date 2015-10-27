From: Vinayak Kale <vinayak.kale@gmail.com>
Subject: Re: [PATCH v2] libata: add support for NCQ commands for SG interface
Date: Tue, 27 Oct 2015 12:07:43 +0530
Message-ID: <CACLWs=UYOAVkitNW0LOTNXpK+tY95H1Z9RrPbL7Fo7nhM10krQ@mail.gmail.com>
References: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com> <20151027061657.GB2888@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33599 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbJ0GiX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 02:38:23 -0400
In-Reply-To: <20151027061657.GB2888@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Tue, Oct 27, 2015 at 11:46 AM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Oct 27, 2015 at 11:19:15AM +0530, vinayak.kale@gmail.com wrote:
>> From: Vinayak Kale <vinayak.kale@seagate.com>
>>
>> This patch is needed to make NCQ commands with FPDMA protocol value
>> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
>>
>> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
>
> Applied to libata/for-4.4.

Thanks Tejun :-)

>
> Thanks.
>
> --
> tejun
