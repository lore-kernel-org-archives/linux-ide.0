From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 02:27:28 -0400
Message-ID: <4C9C44D0.1030409@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:26959 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750880Ab0IXG1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 02:27:31 -0400
In-Reply-To: <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seed <seedrubbish@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-09-24 01:49 AM, Seed wrote:
> 010 at 3:34 PM, Mark Lord<kernel@teksavvy.com>  wrote:
>> I am totally lost when looking at libahci code though.
>> Anyone got any ideas where the bug might be there??
>
> Maybe in libata-scsi.c function ata_scsi_pass_thru?


No, things are fine there, and work properly for non-AHCI chipsets.
The bug seems to be in the libahci code somewhere.

Cheers
