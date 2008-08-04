From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Mon, 4 Aug 2008 15:18:41 -0400 (EDT)
Message-ID: <30565143.1217877521998.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:34898 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761738AbYHDTTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 15:19:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com

We do have the AHCI class code - PCI offset 09h = 010601h.  We are detected as an AHCI controller under Vista.  I even tried adding our vendor/device id to ahci.c but that didn't make any difference.  Is there something else I'm missing?

A little background...

We have a PCIe plug-in card that identifies itself as an AHCI controller as mentioned above.  We used a PCIe analyzer card to look at traffic as we booted Linux (build 2.6.19).  We saw various PCI reads & writes as the system initialized PCI resources but we never saw what would amount to an 'Identify Device' command which I'm assuming the libata driver should do.  Any ideas?

Thanks again for your help so far
Bob

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Aug 4, 2008 10:44 AM
>To: the4hoffmans@earthlink.net
>Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> Thank you for your response, Tejun.  We have figured some things out
>> since I first e-mailed.  We have been using IOMeter running on a
>> remote Windows system which connects to a Dynamo module running on
>> the Linux target.  The Dynamo module uses a file open command with an
>> O_DIRECT flag to minimize the effects of caching.  Unfortunately,
>> this causes the IO to be totally synchronous which is kinda bad for
>> this type of benchmarking.
>
>Ah.. Okay.
>
>> I have another question for you.  Where can I find information on how
>> to get the AHCI driver to recognize our new AHCI controller?
>
>If your controller has ahci class code, you don't need to do anything.
>If not, you'll need to add the PCI ID to the device id table in ahci.c.
> If the controller needs some quirks, you'll also need to add device id
>entry and set its driver data to the appropriate board id (board_ahci_*).
>
>-- 
>tejun

