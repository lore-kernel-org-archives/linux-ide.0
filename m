From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: Add MODULE_PARM_DESC to prefer_ms_hyperv
Date: Mon, 04 Mar 2013 17:15:32 -0500
Message-ID: <51351D04.4010009@pobox.com>
References: <774443881.7195405.1361473310424.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38500 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab3CDWPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 17:15:35 -0500
In-Reply-To: <774443881.7195405.1361473310424.JavaMail.root@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rado Vrbovsky <rvrbovsk@redhat.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff <jgarzik@redhat.com>

On 02/21/2013 02:01 PM, Rado Vrbovsky wrote:
> From: Andrew Brownfield <abrownfi@redhat.com>
>
> In reference to the commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c
> "ata_piix: defer disks to the Hyper-V drivers by default",
> this trivial patch adds a description to prefer_ms_hyperv.
>
> [rvrbovsk@redhat.com: MODULE_PARM_DESC() string formatting modified]
>
> Signed-off-by: Andrew Brownfield <abrownfi@redhat.com>
> Signed-off-by: Radomir Vrbovsky <rvrbovsk@redhat.com>
>
> ---
>   drivers/ata/ata_piix.c | 4 ++++
>   1 file changed, 4 insertions(+)

applied [manually]



