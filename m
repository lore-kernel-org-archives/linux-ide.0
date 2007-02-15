From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clear TF before IDENTIFYing
Date: Thu, 15 Feb 2007 18:08:58 -0500
Message-ID: <45D4E80A.1010300@garzik.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com> <20070207193513.GA1929@artsapartment.org> <45CA2DBF.9040403@pobox.com> <45CA3895.5010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60275 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161668AbXBOXJG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:09:06 -0500
In-Reply-To: <45CA3895.5010108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, stable@kernel.org

Tejun Heo wrote:
> Some devices chock if Feature is not clear when IDENTIFY is issued.
> Set ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE for IDENTIFY such that whole
> TF is cleared when reading ID data.
> 
> Kudos to Art Haas for testing various futile patches over several
> months and Mark Lord for pointing out the fix.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Art Haas <ahaas@airmail.net>
> Cc: Mark Lord <mlord@pobox.com>
> ---
> I think this should go into -stable but a little bit hesitant because
> the code hasn't been tested widely.  This patch should really be
> harmless but who knows.  Jeff, Mark, what do you think?

applied


