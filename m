From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata-dev: add flush task to ata_exec_internal()
Date: Tue, 21 Mar 2006 20:40:10 -0500
Message-ID: <4420AAFA.9000002@pobox.com>
References: <44163628.2000001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63418 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751938AbWCVBkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 20:40:14 -0500
In-Reply-To: <44163628.2000001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Add ata_port_flush_task() to ata_exec_internal().
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied


