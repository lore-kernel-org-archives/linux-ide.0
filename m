From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - another patch.
Date: Wed, 06 Oct 2004 23:38:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4164BA2E.1020806@pobox.com>
References: <20041005182049.E13871@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269671AbUJGDif
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 23:38:35 -0400
In-Reply-To: <20041005182049.E13871@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, John Linville <linville@redhat.com>, linville@tuxdriver.com, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>

Andy Warner wrote:
> Attached are two patchfiles, which implement the following
> features of libata ATA pass-thru:
> 
>  o check condition processing
>  o 12-byte CDB handling
> 
> patch.041005 can be applied to vanilla libata-2.6 trees
> patch-dev.041005 can be applied to libata-dev-2.6 trees


Please resend this as two patches, diff'd against libata-dev-2.6 tree.

I'll apply the error register patch for now, and think about it later 
;-)  That's what libata-dev is for, after all.

I'll generate a new libata-dev patch, too.

	Jeff


P.S.  One patch per email, please.  Mailbombing is acceptable.
