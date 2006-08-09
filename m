From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: several fixes against libata-dev#upstream-fixes
Date: Wed, 09 Aug 2006 00:00:46 -0400
Message-ID: <44D95DEE.7050207@pobox.com>
References: <11547243571730-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030336AbWHIEAt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:00:49 -0400
In-Reply-To: <11547243571730-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.
> 
> This patchset contains fixes against libata-dev#upstream-fixes[1].
> 
> #01    : fix ata_port_detach() dangling SCSI host bug
> #02    : fix host_set private_data init bug
> #03    : fix double free of host_set->mmio_base
> #04-05 : fix ata_device_add() error path
> 
> #02, #04-05 are taken from rework-host_set patchset and #01, #03 are
> new.  I left rework-host_set as update to #upstream as it is too much
> for .18-rcX.
> 
> This patchset is available in the following git tree.
> 
>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream-fixes
>   git://htj.dyndns.org/libata-tj tj-upstream-fixes

pulled


