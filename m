From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Mon, 17 May 2004 17:34:20 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A92FDC.5070309@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com> <1084828840.3211.26.camel@patibmrh9> <40A92F69.6030309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262279AbUEQVed
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 17:34:33 -0400
In-Reply-To: <40A92F69.6030309@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Consider:  what data direction will a vendor-reserved SCSI opcode 
> require?  The OS driver cannot know.


s/OS driver/bridge/ obviously...



