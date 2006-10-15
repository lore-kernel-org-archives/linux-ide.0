From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] implement ata_link, take 3
Date: Mon, 16 Oct 2006 07:56:09 +0900
Message-ID: <4532BC89.1020805@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:21436 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422921AbWJOW4S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:56:18 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626959nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:56:17 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

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

Forgot about git tree, sorry.  This patchset can be accessed via the 
following git tree.

   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=link
   git://htj.dyndns.org/libata-tj link

-- 
tejun
