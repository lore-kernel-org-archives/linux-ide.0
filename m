From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] implement ata_link, take 3
Date: Tue, 31 Oct 2006 21:26:43 -0500
Message-ID: <454805E3.4000504@pobox.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46294 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946446AbWKAC0q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:26:46 -0500
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of implement ata_link patchset.  This patchset
> contains 18 patches which can be categorized as follows.
> 
> #01-03: prep
> #04-05: implement ata_link
> #06-09: make libata deal with link instead of port
> #10-12: misc link stuff (link init, reset_tries, ata_link_abort())
> #13-19: add ap->pmp_link[] and update libata to deal with multiple
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
> With above and a few extra fields, a link can fully host attached
> devices including qc management and EH/hotplug.  This patchset makes
> libata ready to handle PM links.
> 
> Changes from the last take[L] are.
> 
> * updated to fit new #upstream
> * __dev1 trick removed
> 
> This patchset is against
> 
>   upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
>   + [1] hp-poll patchset, take #5
>   + [2] vt8251-ahci patchset, take #2

ACK patchset


