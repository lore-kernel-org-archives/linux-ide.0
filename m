From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE cleanups for 2.6.4-rc1 (2/3)
Date: Tue, 02 Mar 2004 18:08:24 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <404513E8.9010101@pobox.com>
References: <200403022215.07385.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261232AbUCBXIl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Mar 2004 18:08:41 -0500
In-Reply-To: <200403022215.07385.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> [IDE] remove ide_cmd_type_parser() logic
> 
> Set ide_task_t fields (command_type, handler and prehandler) directly.
> Remove unused ide_task_t->posthandler and all ide_cmd_type_parser() logic.
> 
> ide_cmd_type_parser() was meant to be used for ioctls but
> ended up checking validity of kernel generated requests (doh!).
> 
> Rationale for removal:
> - it can't be used for existing ioctls (changes the way they work)
> - kernel shouldn't check validity of (root only) user-space requests
>   (it can and should be done in user-space)
> - it wastes CPU cycles on going through parsers
> - it makes code harder to understand/follow
>   (now info about request is localized)


Without the annoyingly-large 'switch', how do you figure out whether a 
command is non-data, pio-read, pio-write, dma-read, or dma-write?

	Jeff



