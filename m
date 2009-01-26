From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 19:35:50 +0000
Message-ID: <20090126193550.27eef301@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0F76.6020606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41340 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751870AbZAZTg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:36:26 -0500
In-Reply-To: <497E0F76.6020606@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru


> > +	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
> > +		return 0;
> > +	return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;
> 
>     Refer to afa_dev_cf_sata() on how it's done in really optimal way.

To what ? - there is no ata or afa_dev_cf_sata ?

