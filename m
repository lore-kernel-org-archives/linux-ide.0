From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/12] libata: implement ATA_FLAG_IN_EH port flag
Date: Sun, 22 Jan 2006 04:49:49 -0500
Message-ID: <43D3553D.5080807@pobox.com>
References: <11379167111012-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26854 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932324AbWAVJtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:49:55 -0500
In-Reply-To: <11379167111012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> ATA_FLAG_IN_EH flag is set on entry to EH and cleared on completion.
> This patch just sets and clears the flag.  Following patches will
> build normal qc execution / EH synchronization aroung this flag.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

patches 7, 9, 10 are OK


