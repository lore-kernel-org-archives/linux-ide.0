From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] new EH framework
Date: Mon, 3 Apr 2006 03:34:19 +0900
Message-ID: <20060402183419.GP13172@htj.dyndns.org>
References: <1144002668278-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:13551 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbWDBSeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:34:23 -0400
Received: by zproxy.gmail.com with SMTP id o37so1551166nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:34:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mon, Apr 03, 2006 at 03:31:08AM +0900, Tejun Heo wrote:
> Hello, all.
> 
> New EH, finally.  New EH will be posted as two patchsets -
> eh-framework and eh.  As the name suggests, the first one implements
> EH framework in libata core layer and the second one implements
> helpers, drivers, stock routines for bmdma controllers and converts
> several drivers (ata_piix, ahci, sata_sil) to new EH.
> 
> This is the first take of eh-framework patchset.  This patchset
> contains 13 patches and against
> 
>   upstream [1]
>   + scsi_eh_schedule patchset, take 2 [2][3]
>   + ahci softreset presence detection patch [4]
> 
> Brief description of new EH framework follows.
> 

Will post eh patchset tomorrow.  Still gotta write patch descriptions
for those patches and just cannot stay awake anymore.  See ya
tomorrow.  Good ngiht.

-- 
tejun
