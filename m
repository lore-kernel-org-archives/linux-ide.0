From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IDE connector on Promise 20376 SATA controller
Date: Fri, 24 Sep 2004 17:55:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415497E1.9050207@pobox.com>
References: <1096060840.6059.4.camel@homer.blizzard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264246AbUIXVz7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Sep 2004 17:55:59 -0400
In-Reply-To: <1096060840.6059.4.camel@homer.blizzard.org>
List-Id: linux-ide@vger.kernel.org
To: Jesse Stockall <stockall@magma.ca>
Cc: linux-ide@vger.kernel.org

Jesse Stockall wrote:
> Hi
> 
> I just purchased a board with a Promise 20376 SATA raid controller that
> also has am IDE connector for a single PATA drive. The sata_promise
> driver does not see the drive attached to the IDE connector.
> 
> I found a few old posts where people indicated that it was on Jeff
> Garziks TODO list. 
> 
> kernel version 2.6.9-rc2-mm3

Still on the TODO list.  You (or anyone else) is welcome to work on this 
feature, I can describe to another engineer how to do it.

	Jeff



