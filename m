From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/11] libata-eh-fw: implement freeze/thaw
Date: Tue, 16 May 2006 19:30:43 +0900
Message-ID: <4469A9D3.5030006@gmail.com>
References: <11473504441058-git-send-email-htejun@gmail.com> <4469A63F.3040705@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:50905 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751757AbWEPKav (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:30:51 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1442900wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 03:30:50 -0700 (PDT)
In-Reply-To: <4469A63F.3040705@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> With the new ata_drive_probe_reset(), my old Acer 787E drive still got "irq nobody cared"
> when probed. (dmesg attached. The problem only seen on this drive; other CD-ROM drives works ok.)
> The pata_pdc2027x driver has been converted to the ->probe_reset() interface.
> Is there anything else I should do for pata_pdc2027x driver to avoid the "irq nobody cared"?

You need to implement both ->probe_reset() and ->error_handler() & 
friends to avoid "irq nobody cared".  Note that hotplug merges probing 
into ->error_handler() and removes ->probe_reset().

The actual part which helps avoiding "irq nobody cared" during 
initialization is proper implementation of ->freeze() and ->thaw().  If 
the controller can detect spurious interrupts, freezing on spurious 
interrupts can help avoiding screaming interrupts, too.

-- 
tejun
