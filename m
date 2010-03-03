From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 08/11] ahci: Introduce ahci_set_em_messages()
Date: Wed, 03 Mar 2010 15:52:33 -0500
Message-ID: <4B8ECC11.3020009@pobox.com>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru> <20100303171745.GH12362@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f204.google.com ([209.85.210.204]:51434 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0CCUwf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 15:52:35 -0500
In-Reply-To: <20100303171745.GH12362@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/03/2010 12:17 PM, Anton Vorontsov wrote:
> Factor out some ahci_em_messages handling code from ahci_init_one().
> We would like to reuse it for non-PCI devices.
>
> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> ---
>   drivers/ata/ahci.c |   41 ++++++++++++++++++++++++-----------------
>   1 files changed, 24 insertions(+), 17 deletions(-)

applied patches 1-8 (ie. up to and including this patch) to 
libata-dev.git#upstream.  Will drop all other patches, awaiting revision 
and resend.


