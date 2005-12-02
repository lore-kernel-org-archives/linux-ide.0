From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: cpu consumption
Date: Thu, 01 Dec 2005 21:02:44 -0500
Message-ID: <438FAB44.5030807@pobox.com>
References: <5d96567b0511260545j61970a01j3b5c435766a51a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28637 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964782AbVLBCCr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 21:02:47 -0500
In-Reply-To: <5d96567b0511260545j61970a01j3b5c435766a51a6d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: linux-ide@vger.kernel.org

Raz Ben-Jehuda(caro) wrote:
> Hello Jeff.
> Here is my problem.
> 
> When I issue a READ operation over a SATA disk in linux i have
> huge cpu consumption , about 90% cpu usage.
> 
> I am using MAXTOR disks in a supermicro machine.
> the cpu test was made when i "raw read" from the DISK using DIRECT_IO.

I dunno... do some profiling (in-kernel profiler, or oprofile) and see 
where the CPU is being consumed.

Are you also seeing a lot of interrupts?

	Jeff



