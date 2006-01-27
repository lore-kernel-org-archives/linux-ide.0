From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/13] libata: implement ATA_FLAG_IN_EH port flag
Date: Thu, 26 Jan 2006 23:00:44 -0500
Message-ID: <43D99AEC.9050506@pobox.com>
References: <11379893773050-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:7098 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750851AbWA0EAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:00:47 -0500
In-Reply-To: <11379893773050-git-send-email-htejun@gmail.com>
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

patches 11-12 OK, but failed to apply due to previous dropped patches

