From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: add @timeout to ata_exec_internal[_sg]()
Date: Tue, 09 Oct 2007 21:41:38 -0400
Message-ID: <470C2DD2.70702@garzik.org>
References: <20071009060544.GL12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41758 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbXJJBlk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:41:40 -0400
In-Reply-To: <20071009060544.GL12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add @timeout argument to ata_exec_internal[_sg]().  If 0, default
> timeout ata_probe_timeout is used.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patchset kills polling PMP register access callbacks ->pmp_read
> and ->pmp_write and use standard ata_exec_internal() mechanism.  This
> patchset is generated on top of the following six patches.
> 
>   http://article.gmane.org/gmane.linux.ide/23464
>   http://article.gmane.org/gmane.linux.ide/23465
>   http://article.gmane.org/gmane.linux.ide/23466
>   http://article.gmane.org/gmane.linux.ide/23467
>   http://article.gmane.org/gmane.linux.ide/23468
>   http://article.gmane.org/gmane.linux.ide/23469
> 
>  drivers/ata/libata-acpi.c |    2 +-
>  drivers/ata/libata-core.c |   32 ++++++++++++++++++++------------
>  drivers/ata/libata-eh.c   |    4 ++--
>  drivers/ata/libata.h      |    5 +++--
>  4 files changed, 26 insertions(+), 17 deletions(-)

applied 1-3, thanks


