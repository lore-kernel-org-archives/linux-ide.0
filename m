From: Andy Warner <andyw@pobox.com>
Subject: Re: libata - error register patch.
Date: Mon, 4 Oct 2004 16:44:30 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041004164430.A9775@florence.linkmargin.com>
References: <20040929175011.L15041@florence.linkmargin.com> <4161BFDD.1070509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:37598 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S268677AbUJDVqU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 17:46:20 -0400
Content-Disposition: inline
In-Reply-To: <4161BFDD.1070509@pobox.com>; from jgarzik@pobox.com on Mon, Oct 04, 2004 at 05:25:49PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> I'm still thinking about this one.
> 
> I need to check and see the behavior of this register, as we have a 
> separate ata_chk_err() as well.

I think the existing behaviour is odd.

I can see a case for either removing any read of the error
register in ata_tf_read_xxx() and relying solely on ata_chk_err()
or going with my patch.

I can's see any case for leaving it as it is - I can find no
code that uses tf->hob_feature after calling ata_tf_read_xxx().

Looks to me like a cut and paste error from way back that got
mashed by LBA48 support.

Reads of the error register are not destructive (at least
according to the specs.)
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
