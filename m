From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 17:25:22 -0500
Message-ID: <4213C852.4070105@pobox.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org> <4213BADF.8000307@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40083 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262105AbVBPWZo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 17:25:44 -0500
In-Reply-To: <4213BADF.8000307@motorola.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ajit Prem <Ajit.Prem@motorola.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

Ajit Prem wrote:
> 
> As a follow-up to my previous email where
> I indicated that int_status on entry into
> vsc_sata_interrupt indicates 0x8300, I
> put in a crude fix in the vsc_sata_interrupt
> handler to read the taskfile status register,
> and to clear the appropriate bits in the
> SATA SError register, and now things work
> just fine.

Wanna post your crude patch to the list?

	Jeff



