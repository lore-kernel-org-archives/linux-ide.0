From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: waiting for the drives to settle
Date: Thu, 20 Aug 2009 11:55:47 -0400
Message-ID: <4A8D7203.50006@garzik.org>
References: <54773205.20090820114051@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58886 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbZHTPzt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Aug 2009 11:55:49 -0400
In-Reply-To: <54773205.20090820114051@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

On 08/20/2009 05:40 AM, Andrei Martynov wrote:
> Hi,
>
> what would be the right place in modern pata driver to implement the
> following old code from function do_probe() in ide-probe.c ?
>
> /*
>   *  ColdFire platforms boot up so quick that most hard drives
>   *  have not completed there own self tests. Pause here for
>   *  a couple of seconds if it looks like there is a drive
>   *  present...
>   */
> if (IN_BYTE(IDE_SELECT_REG) != drive->select.all) {
>    printk("IDE: waiting for drives to settle...\n");
>    for (rc = 0; (rc<  400); rc++) {
>      SELECT_DRIVE(hwif,drive);
>      ide_delay_50ms();
>      if (IN_BYTE(IDE_SELECT_REG) == drive->select.all)
>       break;
>   }
> }
>
> It has to be executed once, so placing it into command handler is
> probably not the right solution.

Have you verified this is needed, under libata?  We already have several 
waits...

	Jeff



