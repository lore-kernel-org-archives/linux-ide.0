From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PROPOSAL] ata: Report 16/32bit PIO as best we can
Date: Thu, 16 Apr 2009 15:29:06 -0400
Message-ID: <49E78702.5080308@garzik.org>
References: <20090409163107.3744.14309.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41988 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404AbZDPT3K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:29:10 -0400
In-Reply-To: <20090409163107.3744.14309.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> The legacy old IDE API for this is a bit primitive so we try and map stuff
> sensibly onto it.
> 
> - Set PIO over DMA devices to report 32bit
> - Add ability to change the PIO32 settings if the controller permits it
> - Add that functionality into the sff drivers
> - Add that functionality into the VLB legacy driver
> - Turn on the 32bit PIO on the ninja32 and add support there
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/libata-scsi.c  |   30 ++++++++++++++++++++++++++----
>  drivers/ata/libata-sff.c   |   27 +++++++++++++++++++++++++++
>  drivers/ata/pata_legacy.c  |   33 ++++++++++++++++++++-------------
>  drivers/ata/pata_ninja32.c |    4 +++-
>  include/linux/libata.h     |    8 ++++++++
>  5 files changed, 84 insertions(+), 18 deletions(-)

applied to #upstream-fixes


