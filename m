From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCHSET] new Power Management for libata
Date: Tue, 13 Jun 2006 14:28:19 +0800
Message-ID: <1150180099.7132.23.camel@forrest26.sh.intel.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10425 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932926AbWFMGkq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 02:40:46 -0400
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:

> Zhao, can you port your AHCI PM stuff over this?  This should solve
> the problem you talked about in the other mail.  Recent changes update
> ahci such that it listens to more PHY events for hotplug and that
> causes EH to kick in after resuming.  The original PM implementation
> didn't synchronize w/ EH and thus caused problems.
> 

I'm doing the porting work, but not sure if I should send out patch
ASAP, or not send it out until your PM patches are merged into
#upstream.

Forrest
