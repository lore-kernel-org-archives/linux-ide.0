From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] ahci: un-staticize ahci_dev_classify
Date: Fri, 17 Aug 2012 13:27:41 -0400
Message-ID: <502E7F0D.2050201@pobox.com>
References: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com> <1345215111-11051-2-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57297 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994Ab2HQR1r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:27:47 -0400
Received: by yenl14 with SMTP id l14so4214878yen.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:27:44 -0700 (PDT)
In-Reply-To: <1345215111-11051-2-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-ide@vger.kernel.org, probinson@gmail.com, jonathon@jonmasters.org, dmarlin@redhat.com, Rob Herring <rob.herring@calxeda.com>

On 08/17/2012 10:51 AM, Mark Langsdorf wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Make ahci_dev_classify available to the ahci platform driver for custom
> hard reset function.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>   drivers/ata/ahci.h    |    1 +
>   drivers/ata/libahci.c |    3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)

applied



