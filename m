From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/13] ata_piix: convert ata_piix to new probing	mechanism
Date: Fri, 12 May 2006 01:02:06 +0900
Message-ID: <44635FFE.6040405@gmail.com>
References: <11473615273443-git-send-email-htejun@gmail.com> <1147363104.26130.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:56195 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030300AbWEKQCN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:02:13 -0400
Received: by py-out-1112.google.com with SMTP id f28so295868pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:02:13 -0700 (PDT)
In-Reply-To: <1147363104.26130.49.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2006-05-12 at 00:32 +0900, Tejun Heo wrote:
>> Convert ata_piix to new probing mechanism.  Automatic hotplug is not
>> supported due to hardware limitation (no PHY event interrupt), but
>> warm plugging works.
> 
> True for the SATA ports but don't try it on the PATA ones. The PATA side
> requires the right buffers are present, and also in some situations that
> IORDY is not in use before the unplug.
> 

Yeap, also the power plug is troublesome too.  It doesn't have spike
protection and the machine goes out quite often if hot plugged.
ata_piix PATA warm plugging is mainly for notebook users with hotswap
bays and people with PATA->SATA bridges attached.

In the long term, we need to establish use cases and conventions for
warm/hot plugging.  Even SATA hot plugging can destroy filesystems on
unrelated disks if power supply cannot hold 12v steady while the hot
plugged drive spins up.  To be on the safe side, disks need to be
flushed and held before hotplugging and released after the new device
reaches stable state.  Sturdy machines including most servers with
decent power supplies should be okay though.

So, kernel IO holding support and nice CLI/GUI programs to show the
current configuration and drive plugging sequence would be nice, I think.

-- 
tejun
