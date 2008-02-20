From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/11v2] ata: fix sparse warnings in pata_legacy.c
Date: Wed, 20 Feb 2008 12:09:37 -0500
Message-ID: <47BC5ED1.30809@garzik.org>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>	 <1202966072.2748.27.camel@brick>  <20080214120206.1a52f77d@core> <1203010593.2748.43.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56914 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbYBTRJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:09:40 -0500
In-Reply-To: <1203010593.2748.43.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> Use ld_qdi and ld_winbond to avoid shadowing static int
> variables qdi and winbond.  The ld_ prefix refers to
> legacy_data.
> 
> drivers/ata/pata_legacy.c:777:21: warning: symbol 'qdi' shadows an earlier one
> drivers/ata/pata_legacy.c:128:12: originally declared here
> drivers/ata/pata_legacy.c:811:21: warning: symbol 'qdi' shadows an earlier one
> drivers/ata/pata_legacy.c:128:12: originally declared here
> drivers/ata/pata_legacy.c:848:21: warning: symbol 'qdi' shadows an earlier one
> drivers/ata/pata_legacy.c:128:12: originally declared here
> drivers/ata/pata_legacy.c:882:21: warning: symbol 'qdi' shadows an earlier one
> drivers/ata/pata_legacy.c:128:12: originally declared here
> drivers/ata/pata_legacy.c:1040:21: warning: symbol 'winbond' shadows an earlier one
> drivers/ata/pata_legacy.c:129:12: originally declared here
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
> Alan Cox's suggestion of using a ld_ prefix incorporated.

applied

