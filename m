From: Andi Kleen <ak@suse.de>
Subject: Re: PATA handling on ICH5R in 2.6.8rc2
Date: Wed, 4 Aug 2004 19:36:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040804193608.0a330d1f.ak@suse.de>
References: <20040804184504.21dcb386.ak@suse.de>
	<20040804172610.GA5978@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267361AbUHDRk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2004 13:40:26 -0400
In-Reply-To: <20040804172610.GA5978@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, jun.nakajima@intel.com

On Wed, 4 Aug 2004 19:26:10 +0200
Jens Axboe <axboe@suse.de> wrote:


> Can't you set it to enhanced mode in the bios, then shows up as a
> seperate device id and just works. I had the same issue until Jeff
> walked me through it :-)

If that really solves all problems why does quirk_intel_ide_combined
not do that automatically? 

It seems very user unfriendly to me to require such magic BIOS 
settings.

-Andi
