From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 12/12] pata_amd: update mode selection for NV PATAs
Date: Tue, 27 Nov 2007 11:23:10 +0000
Message-ID: <20071127112310.5662b3d5@the-village.bc.nu>
References: <11961602293422-git-send-email-htejun@gmail.com>
	<11961602321707-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40846 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753013AbXK0L0a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 06:26:30 -0500
In-Reply-To: <11961602321707-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue, 27 Nov 2007 19:43:49 +0900
Tejun Heo <htejun@gmail.com> wrote:

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

Acked-by: Alan Cox <alan@redhat.com>
