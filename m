From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata badness
Date: Mon, 04 Oct 2004 14:01:29 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41618FF9.7080801@pobox.com>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <41617AA0.9020809@pobox.com> <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268342AbUJDSBn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 14:01:43 -0400
In-Reply-To: <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
List-Id: linux-ide@vger.kernel.org
To: William Knop <wknop@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-ide@vger.kernel.org

William Knop wrote:
> 
> I just got another oops while trying to cp from my md/raid5 array (2 of 
> 3 sata drives) to another sata drive on the same controller. This time, 
> though, it said there's a bug in timer.c, line 405, and that the stack's 
> garbage. I'm thinking it has nothing to do with timer.c, and something 
> in md or libata is chomping all over the kernel.

If you are getting random oopses all over the place, I would suspect 
hardware before I suspect buggy code.

Jim's, and others' suggestions were good:  check power connectors (not 
just overall power consumption), test CPU, RAM, temperature, ...

	Jeff



