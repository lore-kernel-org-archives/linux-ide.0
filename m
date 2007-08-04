From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCHSET] libata: implement ata_link, take 6
Date: Sat, 04 Aug 2007 08:04:10 -0500
Message-ID: <1186232650.3439.1.camel@localhost.localdomain>
References: <11862169601938-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:53969 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761329AbXHDNEM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 09:04:12 -0400
In-Reply-To: <11862169601938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Sat, 2007-08-04 at 17:42 +0900, Tejun Heo wrote:
> This is the sixth take of implement ata_link patchset.  This patchset
> contains 14 patches which can be categorized as follows.
> 
> #01-02: implement ata_link
> #03-06: make libata deal with link instead of port
> #07-09: misc link stuff (link init, reset_tries, ata_link_abort())
> #10-14: add ap->pmp_link[] and update libata to deal with multiple
> 	links
> 
> ata_link abstracts PHY and sits between ata_port and ata_device.  The
> following attributes are moved to ata_link from ata_port.
> 
> - active command state (active_tag, sactive)
> - [hw_]sata_spd_limit
> - eh_info and eh_context
> - device array
> 
> With above and a few extra fields, a link can handle attached devices
> including qc management and EH/hotplug.  This patchset makes libata
> ready to handle PMP links.
> 
> Changes from the last take[L] are.
> 
> * adapted to the current upstream
> 
> This patchset is against
> 
>   libata-dev#upstream (80c51b13d8a73b9346ebe849cdeac6f539066fc2)

Sorry; there's another piece now: libsas:  drivers/scsi/libsas/sas_ata.c
will need similar treatment to ipr.

James


