From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/12] libata: implement standard reset component operations
 and ->probe_reset
Date: Fri, 27 Jan 2006 20:58:54 -0500
Message-ID: <43DACFDE.3070703@pobox.com>
References: <1138089922407-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17860 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422789AbWA1B65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 20:58:57 -0500
In-Reply-To: <1138089922407-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Implement SRST, COMRESET and standard postreset component operations
> for ata_drive_probe_reset(), and use these three functions to
> implement ata_std_probe_reset.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


