From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Tue, 23 May 2006 07:53:34 -0700
Message-ID: <447321EE.60907@gmail.com>
References: <11480537073074-git-send-email-htejun@gmail.com> <446DEDED.3040200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56034 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932430AbWEWVza (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:30 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1673597nzo
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:30 -0700 (PDT)
In-Reply-To: <446DEDED.3040200@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> Seems like a nice cleanup would be to move scsi_remove_host() into 
> ata_port_detach() ?  It would be nice to remove that tidbit of SCSI host 
> management from the ->remove() hook in various drivers (mostly ahci, 
> sata_sil24, and libata-core).

Will do.

-- 
tejun

