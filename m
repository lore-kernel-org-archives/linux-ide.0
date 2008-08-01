From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140,
 simg 3726
Date: Sat, 02 Aug 2008 01:16:32 +0900
Message-ID: <489336E0.7020409@kernel.org>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com> <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org> <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com> <48926F7E.1020807@kernel.org> <48930B2E.9060604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49928 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYHAQRj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 12:17:39 -0400
In-Reply-To: <48930B2E.9060604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: khchen@synology.com, linux-ide@vger.kernel.org

Mark Lord wrote:
> I have exactly zero documentation on those chips,
> but they are supposedly AHCI compliant.
> 
> Looking in drivers/ata/ahci.c, one can see that the chips are indeed
> supported,
> and there the AHCI_HFLAG_NO_PMP is *not* set, so one might expect them
> to work
> with a port-multiplier already.  ?

I bet it's more like nobody tried yet.  :-P

-- 
tejun
