From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] libata: improve EH internal command timeout
 handling
Date: Mon, 19 May 2008 19:35:06 +0100
Message-ID: <20080519193506.6811bdb3@core>
References: <12112174741373-git-send-email-htejun@gmail.com>
	<12112174751449-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56139 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbYESSq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 14:46:59 -0400
In-Reply-To: <12112174751449-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, Tejun Heo <htejun@gmail.com>

> IDENTIFYs use 5s - 10s - 30s timeout and all other commands use 5s -
> 10s timeouts.

Cache flushes need more but they now come via the libata-scsi code right ?

> 
> This patch significantly cuts down the needed time to handle failure
> cases while still allowing libata to work with nut job devices through
> retries.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

