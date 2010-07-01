From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] libahci: Fix bug in storing EM messages
Date: Thu, 01 Jul 2010 15:35:46 -0400
Message-ID: <4C2CEE12.608@pobox.com>
References: <1277350463.8158.3.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44275 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab0GATfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 15:35:51 -0400
Received: by mail-gy0-f174.google.com with SMTP id 5so46757gye.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Jul 2010 12:35:50 -0700 (PDT)
In-Reply-To: <1277350463.8158.3.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org, shane.Huang@amd.com

On 06/23/2010 11:34 PM, Harry Zhang wrote:
> In function ahci_store_em_buffer(), if the input (signed char*) buffer
> contains negative data, the constructed 32-bit long message data may
> be wrong.
>
> Signed-off-by: Harry Zhang<harry.zhang@amd.com>
> ---
>   drivers/ata/libahci.c |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)

applied


