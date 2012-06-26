From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/1] ahci: Enable SB600 64bit DMA on MSI K9AGM2 (MS-7327)
Date: Tue, 26 Jun 2012 14:48:27 +0400
Message-ID: <4FE9937B.7080503@mvista.com>
References: <4FE92267.60106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44575 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2FZKtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2012 06:49:10 -0400
Received: by lbbgm6 with SMTP id gm6so7843345lbb.19
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2012 03:49:08 -0700 (PDT)
In-Reply-To: <4FE92267.60106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, tj@kernel.org

Hello.

On 26-06-2012 6:45, Mark Nelson wrote:

> Like e65cc194f7628ecaa02462f22f42fb09b50dcd49

    Please also specify that commit's summary in parens.

> this patch enables 64bit DMA
> for the AHCI SATA controller of a board that has the SB600 southbridge. In
> this case though we're enabling 64bit DMA for another MSI motherboard, the
> K9AGM2 or MS-7327. It is new enough that all of the BIOS releases since
> the initial release (1.0 from 2007-02-09) work correctly with 64bit DMA enabled.

> Signed-off-by: Mark Nelson <mdnelson8@gmail.com>

MBR, Sergei
