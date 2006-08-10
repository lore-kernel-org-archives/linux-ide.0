From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
	init model
Date: Thu, 10 Aug 2006 13:36:05 +0100
Message-ID: <1155213365.22922.5.camel@localhost.localdomain>
References: <1154919840689-git-send-email-htejun@gmail.com>
	 <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>
	 <44D98388.8030005@pobox.com>
	 <1155121214.5729.153.camel@localhost.localdomain>
	 <44DADC67.5060707@tw.ibm.com>  <44DADFC9.7010700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16789 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030517AbWHJMRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 08:17:51 -0400
In-Reply-To: <44DADFC9.7010700@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, mlord@pobox.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Ar Iau, 2006-08-10 am 03:27 -0400, ysgrifennodd Jeff Garzik:
> hehe :)
> 
> Well I am more than willing to rename it, though its a bit low priority.
> 
> What would people prefer?  libata-sff.c ?

Looking at the non-PCI cases I think it needs a three way split

- Libata core as it is now basically (no bus specific code at all)
- Libata register compatibility stuff (ST506) in a file (no
dependancies) [libata-legacy] ??
- Libata BMDMA, SFF PCI in a file (dep CONFIG_PCI)  [libata-sff]

Alan

