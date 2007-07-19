From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata bustage with CONFIG_PM=n
Date: Thu, 19 Jul 2007 16:04:04 +0900
Message-ID: <469F0CE4.90302@gmail.com>
References: <20070718235934.a3545271.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:48249 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbXGSHEK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 03:04:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so519799wah
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 00:04:09 -0700 (PDT)
In-Reply-To: <20070718235934.a3545271.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Andrew Morton wrote:
> ahci_port_start() calls ahci_port_resume() which doesn't exist if !CONFIG_PM.
> 

Patch already sent Jeff's way.

-- 
tejun
