From: Bryan Boatright <boatright@ieee.org>
Subject: Re: AHCI NCQ on ESB2 (8086:2681) (RESOLVED)
Date: Mon, 01 Jan 2007 08:32:39 -0600
Message-ID: <45991B87.90905@ieee.org>
References: <4597B34C.1090606@omega71.com> <45987E06.1070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:40493 "HELO
	smtp106.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755215AbXAAOjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jan 2007 09:39:22 -0500
In-Reply-To: <45987E06.1070101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Thanks.  The new ahci_reset_controller proc solved the problem.  
HOST_CAP is now correct for both NCQ and phy speed capability.

Bryan


Tejun Heo wrote:
> Bryan Boatright wrote:
>>
>> I hope this is an appropriate place to ask this question.  Googling for
>> answers turned up nothing.
>>
>> I am using kernel 2.6.19.1 and am trying to get NCQ support working.  My
>> Intel chipset (ESB2, see details below) should support NCQ, but it is
>> not returning the NCQ capabilities bit in the HBA Capabilities
>> register.  Here's the relevant dmesg output:
>
> Please test the latest Linus git-tree.  ahci used to clear CAP while
> resetting controller expecting it to set supported feature bits again.
> Apparently some controllers don't do it resulting in disabled NCQ.
> This was fixed recently by the following commit.
>
> Commit: 551c012d7eea3dc5ec063c7ff9c718d39e77634f
> Author: Tejun Heo <htejun@gmail.com>  2006-12-12 20:17:32
> Committer: Jeff Garzik <jeff@garzik.org>  2006-12-17 00:13:29
> Branches: upstream-fixes, upstream, quilt-init
> Follows: v2.6.19
> Precedes:
>
>    [PATCH] ahci: do not mangle saved HOST_CAP while resetting controller
>
>    Do not mangle with HOST_CAP while resetting controller.  The code is
>    there for a historical reason.  The mangling breaks controller feature
>    detection and 0 PORTS_IMPL workaround code.
>
>    This problem was spotted by Manoj Kasichainula.
>
>    Signed-off-by: Tejun Heo <htejun@gmail.com>
>    Cc: Manoj Kasichainula <manoj@io.com>
>    Signed-off-by: Jeff Garzik <jeff@garzik.org>
>
> Happy new year.
>
