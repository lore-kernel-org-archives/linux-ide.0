From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 09:02:46 -0500
Message-ID: <D19C1FEA-C06F-4958-979D-27FC9D52FADE@kernel.crashing.org>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net> <4A70A78D.7070601@gmail.com> <16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net> <E8D39D04-E4B6-4420-AD54-6A95BE35EB30@kernel.crashing.org> <16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43490 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZG3OE5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 10:04:57 -0400
In-Reply-To: <16444A0F3094A24C83EAB7836A12C63B032E5C@zin33exm20.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Jul 30, 2009, at 8:58 AM, Kalra Ashish-B00888 wrote:

> Hello Kumar,
>
> >> > This doesn't look like it should change anything. sata_fsl_ops
> >> inherits
> >> > from sata_pmp_port_ops, which inherits from sata_port_ops, which
> >> already
> >> > sets qc_defer to ata_std_qc_defer.
> >> Oh, yes. Actually this patch was for older kernels where there
> >> inheritence was not there. As you mentioned, this patch is not
> >> required now.
> >>
> >How old?  Should we be asking for this to be applied to some of the
> >stable kernel series?
>
> I believe that the inheritence stuff was added in 2.6.26, thus, this  
> patch is
> required for quite old kernels ( < 2.6.26 ).

Ok, than I'm not going to worry about it.

- k
