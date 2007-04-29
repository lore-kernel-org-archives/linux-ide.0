From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATCH: libata: add support for ATA_16 on ATAPI
Date: Sun, 29 Apr 2007 16:46:15 +0900
Message-ID: <46344D47.4070005@gmail.com>
References: <4633C0E0.60706@rtr.ca> <4633C14B.6030403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:64038 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbXD2Hqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 03:46:36 -0400
Received: by an-out-0708.google.com with SMTP id b33so995573ana
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 00:46:36 -0700 (PDT)
In-Reply-To: <4633C14B.6030403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> resending.. again.. with a Subject line this time :)
> 
> This patch adds support for issuing ATA_16 passthru commands
> to ATAPI devices managed by libata.  It requires the previous
> CDB length fix patch.
> 
> A boot/module parameter, "ata16_passthru=1" can be used to
> globally disable this feature, if ever desired.
> 
> Signed-Off-By: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
