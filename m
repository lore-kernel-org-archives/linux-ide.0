From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/6] ata: i.MX PATA: add devicetree support
Date: Thu, 11 Apr 2013 19:38:25 -0400
Message-ID: <51674971.6010005@pobox.com>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de> <1365067509-10186-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:51468 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab3DKXi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Apr 2013 19:38:27 -0400
Received: by mail-qc0-f177.google.com with SMTP id u28so942339qcs.8
        for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2013 16:38:27 -0700 (PDT)
In-Reply-To: <1365067509-10186-5-git-send-email-s.hauer@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On 04/04/2013 05:25 AM, Sascha Hauer wrote:
> Not much to do here, only the compatible entries have to be added.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   Documentation/devicetree/bindings/ata/imx-pata.txt | 17 +++++++++++++++++
>   drivers/ata/pata_imx.c                             |  9 +++++++++
>   2 files changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

applied 1-4



