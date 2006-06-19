From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ICH7 fails to wakeup drive sata drive on ACPI resume
Date: Mon, 19 Jun 2006 15:05:57 +0800
Message-ID: <1150700758.7132.110.camel@forrest26.sh.intel.com>
References: <1150700546.6346.16.camel@mlap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33601 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932173AbWFSHTl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 03:19:41 -0400
In-Reply-To: <1150700546.6346.16.camel@mlap>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milosz Tanski <mtanski@wideopenwest.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2006-06-19 at 03:02 -0400, Milosz Tanski wrote:
> That's what lead me to believe that drive doesn't resume, now I know
> there is a recent patch added 6/3 to wait till drive spins up
> (http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=d9ec5ad24ce80b7ef69a0717363db661d13aada5) I am wondering if this has anything to with this line, and just waiting for ever for the drive to resume.
> 

This line has nothing to do with resume in AHCI mode. It's related to
resume in piix mode.

There's no support for AHCI resume in either stock kernel or libata-dev
git tree now.

The patches for AHCI suspend/resume is at here:
http://marc.theaimsgroup.com/?l=linux-ide&m=114958999517565&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114958968123198&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114958999523165&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114959199902868&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114959199906103&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114958984425832&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=114958984425521&w=2

Thanks,
Forrest
