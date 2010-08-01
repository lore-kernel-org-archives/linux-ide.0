From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: more PCI IDs for jmicron controllers
Date: Sun, 01 Aug 2010 19:48:46 -0400
Message-ID: <4C5607DE.5050609@garzik.org>
References: <4C529E92.5060506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37612 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0HAXst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Aug 2010 19:48:49 -0400
Received: by ywh1 with SMTP id 1so1072136ywh.19
        for <linux-ide@vger.kernel.org>; Sun, 01 Aug 2010 16:48:48 -0700 (PDT)
In-Reply-To: <4C529E92.5060506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aries Lee <arieslee@jmicron.com>

On 07/30/2010 05:42 AM, Tejun Heo wrote:
> Add support for JMB364 and 369.
>
> Patch-originally-from: Aries Lee<arieslee@jmicron.com>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/pci/quirks.c    |    6 ++++++
>   include/linux/pci_ids.h |    2 ++
>   2 files changed, 8 insertions(+)

applied


