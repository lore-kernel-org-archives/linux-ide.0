From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 09:28:47 +0000 (UTC)
Message-ID: <20121024092847.C536E11FC6B@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46973 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab2JXJ2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 05:28:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 553922038D
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 09:28:50 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 447D120389
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 09:28:49 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #24 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2012-10-24 09:28:47 ---
Reply-To: phillip.wood@talktalk.net

On 10/23/2012 11:17 AM, Borislav Petkov wrote:
> ---
> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> index 09723b76beac..80d594d6e7c8 100644
> --- a/drivers/ata/pata_acpi.c
> +++ b/drivers/ata/pata_acpi.c
> @@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>
>   	/* Now stuff the nS values into the structure */
>   	t = ata_timing_find_mode(adev->dma_mode);
> +	if (!t) {
> +		pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
> +		       __func__, adev->dma_mode);
> +
> +		return;
> +	}
> +
>   	if (adev->dma_mode >= XFER_UDMA_0) {
>   		acpi->gtm.drive[unit].dma = t->udma;
>   		acpi->gtm.flags |= (1 << (2 * unit));
> --

pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

as well here if I build pata_acpi as a module, if I build it into the 
kernel I don't get any message.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.