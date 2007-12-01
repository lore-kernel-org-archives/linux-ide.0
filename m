From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/12] pata_amd: update mode selection for NV PATAs
Date: Sat, 01 Dec 2007 18:22:42 -0500
Message-ID: <4751ECC2.2050000@garzik.org>
References: <11961602293422-git-send-email-htejun@gmail.com> <11961602321707-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55735 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbXLAXWo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:22:44 -0500
In-Reply-To: <11961602321707-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> Cable detection on NV PATA hosts isn't implemented and the CBLID-
> cable isn't wired according to the sepc either, so both host-side and
> generic drive-side cable detections are broken.  Till now,
> nv_cable_detect() relied on peeking BIOS and ACPI configurations to
> upgrade to 80C but this often results in misdetection of 40C cable as
> 80C.  Also, the original implementation was broken in that by the time
> BIOS configuration is read it has already been cleared by programming
> PIO0 during reset.
> 
> This patch reimplements NV mode selection such that...
> 
> * BIOS configuration value is stored during driver attach and restored
>   on detach.
> 
> * Cable type is fixed to ATA_CBL_PATA_IGN and mode selection is soley
>   done by nv_mode_filter() which peeks both BIOS and ACPI
>   configurations and filter accordingly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/pata_amd.c |  129 ++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 93 insertions(+), 36 deletions(-)

Yeah, I think this is a better way to do things long term.  Thanks...


