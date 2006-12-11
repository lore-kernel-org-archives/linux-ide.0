From: Tejun Heo <htejun@gmail.com>
Subject: Re: Oops in pata_pdc2027x
Date: Mon, 11 Dec 2006 22:55:59 +0900
Message-ID: <457D636F.9020806@gmail.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>	 <457790F0.2070208@tw.ibm.com> <1165651032.1103.123.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:46032 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762918AbWLKN4I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 08:56:08 -0500
Received: by an-out-0708.google.com with SMTP id b33so239651ana
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 05:56:07 -0800 (PST)
In-Reply-To: <1165651032.1103.123.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: albertl@mail.com, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, ppc-dev <linuxppc-dev@ozlabs.org>

Benjamin Herrenschmidt wrote:
> Could that be related to the fix
> 
> [PATCH] libata: fix oops with sparsemem
> 
> That Arnd Bergmann just posted ? I'm copying it below in case you
> haven't seen it.

Seems to be the same problem to me.  I'll reply in the original thread.

Thanks.

-- 
tejun
