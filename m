From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] sata_sis: convert to slave_link
Date: Tue, 08 Sep 2009 21:19:25 -0400
Message-ID: <4AA7029D.1000804@garzik.org>
References: <4A9D2D5E.90209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51559 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbZIIBTZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2009 21:19:25 -0400
In-Reply-To: <4A9D2D5E.90209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Uwe Koziolek <uwe.koziolek@gmx.net>

On 09/01/2009 10:19 AM, Tejun Heo wrote:
> During introduction of slave_link, sata_sis slipped through the crack
> and left with ad-hoc merged SCR access.  As SCR status was shared for
> both the master and slave devices, when only one of the device is
> online, libata EH would think both are online but would only get valid
> device signature for the actually present one, which in turn trigger
> the probing safety net mechanism and make EH retry causing large delay
> during boot.  This patch converts sata_sis to slave_link mechanism.
>
> This bug was reported by TAXI in bko#14075.
>
>   http://bugzilla.kernel.org/show_bug.cgi?id=14075
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: TAXI<taxi@a-city.de>
> Cc: Uwe Koziolek<uwe.koziolek@gmx.net>
> ---
> This is fairly straight-forward fix but I couldn't test it extensively
> and it's way too late in the rc cycle.  I think it would be best to
> put it in #upstream and let it see some testing in linux-next and then
> backport them through -stable.
>
> Thanks.
>
>   drivers/ata/sata_sis.c |   75 ++++++++++++++++---------------------------------
>   1 file changed, 25 insertions(+), 50 deletions(-)

applied


