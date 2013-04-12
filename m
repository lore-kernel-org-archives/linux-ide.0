From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [RFC PATCH] AHCI: Workaround for ATAPI on buggy AHCI controller
Date: Fri, 12 Apr 2013 20:58:41 +0000
Message-ID: <robbat2-20130412T205648-528799016Z@orbis-terrarum.net>
References: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40030 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab3DLU6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Apr 2013 16:58:42 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id AA6DD33E42E
	for <linux-ide@vger.kernel.org>; Fri, 12 Apr 2013 20:58:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

On Fri, Apr 12, 2013 at 12:34:24PM -0700,  Marc C wrote:
> Hello Jeff,
..
> index 4e73e1b..383de21 100644
> --- a/linux/drivers/ata/libata-core.c
> +++ b/linux/drivers/ata/libata-core.c
> @@ -4827,6 +4827,12 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  {
>      struct ata_port *ap = qc->ap;
> 
> +    if (ata_is_atapi(qc->tf.protocol)) {
> +        void ahci_apply_atapi_workaround(struct ata_queued_cmd *qc);
This prototype really doesn't belong here.

Should probably be in include/linux/libata.h

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
