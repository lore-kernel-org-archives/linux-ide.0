From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Thu, 06 May 2010 02:30:55 -0700
Message-ID: <4BE28C4F.9000903@linux.intel.com>
References: <4BE27C49.5090809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:9878 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755364Ab0EFJa6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 May 2010 05:30:58 -0400
In-Reply-To: <4BE27C49.5090809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 5/6/2010 1:22, Tejun Heo wrote:
> Hello,
>
> Artem reported on bko#15918 that on his machine ahci probing takes too
> long (well, if you ask me, that's not too long but anyways).  This is
> caused by CAP_SSS disabling parallel scan.  The code was added by
> Arjan in commit 886ad09fc83342aa1c5a02a0b6d3298b78a8067f.  There is a
> module parameter to skip this but I'm curious whether the change was
> based on an actual problem as on most PC hardware by the time ahci
> driver kick in, the BIOS has spun up everything already.

This was based on Jeff's review comments on an earlier patch that did not use SSS.

The thing is, SSS means the system requests (well, demands) that we don't spin up the disks
up in parallel.... which we really really ought to honor... Jeff had a very valid point.

While today some bioses may spin everything up, that's not going to be the case going forward...
the industry as a whole is moving away from that (slowly but steadily).
