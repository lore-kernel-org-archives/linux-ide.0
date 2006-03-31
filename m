From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: fix ich6/m_map_db
Date: Fri, 31 Mar 2006 10:15:06 -0500
Message-ID: <442D477A.8040808@pobox.com>
References: <20060331110150.GC13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37050 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751320AbWCaPPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 10:15:08 -0500
In-Reply-To: <20060331110150.GC13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> MAP tables of ich6 and ich6m are wrong.  Depending on port usage,
> ata_piix may fail to initialize attached devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied...  this may fix some reported regressions.


