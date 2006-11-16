From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] clear garbage after CDBs on SG_IO
Date: Wed, 15 Nov 2006 20:52:25 -0500
Message-ID: <455BC459.50905@pobox.com>
References: <20061116005227.GD27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12708 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1162155AbWKPBwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2006 20:52:44 -0500
In-Reply-To: <20061116005227.GD27684@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, dougg@torque.net, mfluhr@nero.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ATAPI devices transfer fixed number of bytes for CDBs (12 or 16).
> Some ATAPI devices choke when shorter CDB is used and the left bytes
> contain garbage.  Block SG_IO cleared left bytes but SCSI SG_IO
> didn't.  This patch makes SCSI SG_IO clear it and simplify CDB
> clearing in block SG_IO.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mathieu Fluhr <mfluhr@nero.com>

ACK


