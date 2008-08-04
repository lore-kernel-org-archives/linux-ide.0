From: Tejun Heo <tj@kernel.org>
Subject: Re: Issue with AHCI driver
Date: Mon, 04 Aug 2008 23:44:32 +0900
Message-ID: <489715D0.4000500@kernel.org>
References: <6738527.1217860606852.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46330 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756368AbYHDOp2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 10:45:28 -0400
In-Reply-To: <6738527.1217860606852.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> Thank you for your response, Tejun.  We have figured some things out
> since I first e-mailed.  We have been using IOMeter running on a
> remote Windows system which connects to a Dynamo module running on
> the Linux target.  The Dynamo module uses a file open command with an
> O_DIRECT flag to minimize the effects of caching.  Unfortunately,
> this causes the IO to be totally synchronous which is kinda bad for
> this type of benchmarking.

Ah.. Okay.

> I have another question for you.  Where can I find information on how
> to get the AHCI driver to recognize our new AHCI controller?

If your controller has ahci class code, you don't need to do anything.
If not, you'll need to add the PCI ID to the device id table in ahci.c.
 If the controller needs some quirks, you'll also need to add device id
entry and set its driver data to the appropriate board id (board_ahci_*).

-- 
tejun
