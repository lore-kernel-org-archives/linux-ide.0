From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: prepare ata_sg_clean() for invocation from
 EH
Date: Tue, 28 Nov 2006 04:02:50 -0500
Message-ID: <456BFB3A.3060308@pobox.com>
References: <11635120303659-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:1155 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935726AbWK1JCw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:02:52 -0500
In-Reply-To: <11635120303659-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ata_sg_clean() global and don't allow NCQ for internal commands.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


