From: Andi Kleen <ak@suse.de>
Subject: Re: ata_exec_internal crash at boot in -git22
Date: Mon, 22 Oct 2007 21:17:00 +0200
Message-ID: <200710222117.00521.ak@suse.de>
References: <200710222008.08095.ak@suse.de> <20071022182645.GE16425@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:46807 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbXJVTRI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 15:17:08 -0400
In-Reply-To: <20071022182645.GE16425@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 22 October 2007 20:26:45 Jens Axboe wrote:
> On Mon, Oct 22 2007, Andi Kleen wrote:
> > 
> > One of the systems tested in autoboot crashes at boot with with -git22.
> > This is a AMD 2 socket Opteron NUMA system.
> > 
> > The tester was a little flakey and happened to hit the x86-merge-broke-
> > compilation window, so the last good data point I have is 2.6.23-rc9.
> 
> Andi, can you test with this patch applied?
> 
> http://brick.kernel.dk/sg-git.patch
Sorry was a mistake (cue: there is no 2.6.23-git22 yet). It turned out
to be an old broken kernel. Current -git seems to boot.
Sorry for the noise.

-Andi


