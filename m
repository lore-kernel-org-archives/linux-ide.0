From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: prevent hba lockup when pass-through
 ATA commands are used
Date: Thu, 10 Jan 2008 16:56:20 -0500
Message-ID: <47869484.3090503@garzik.org>
References: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com> <47842EAD.9010302@gmail.com> <4785A4E6.90107@garzik.org> <4785BF9C.4010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33741 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbYAJV4W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:56:22 -0500
In-Reply-To: <4785BF9C.4010503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gwendal Grignou <gwendal@google.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> From: Gwendal Grignou <gwendal@google.com>
> 
> Fix commands timeout with Sil3124/3132 based HBA when pass-through ATA
> commands [where ATA_QCFLAG_RESULT_TF is set] are used while other
> commands are active on other devices connected to the same port with a
> Port Multiplier.  Due to a hardware bug, these commands must be sent
> alone, like ATAPI commands.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Acked-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_sil24.c |   37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

applied


