From: Andy Warner <andyw@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 13:19:36 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040929131936.A14759@florence.linkmargin.com>
References: <20040928001633.A8363@florence.linkmargin.com> <20040928003911.B8363@florence.linkmargin.com> <20040929124954.C26650@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:20181 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S268775AbUI2SVh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 14:21:37 -0400
Content-Disposition: inline
In-Reply-To: <20040929124954.C26650@tuxdriver.com>; from linville@tuxdriver.com on Wed, Sep 29, 2004 at 12:49:54PM -0400
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>

John W. Linville wrote:
> [...]
> It looks like you are expecting everything below the *.En bit to be
> shifted up by 1 byte.  Am I reading that right?
> 
> I guess I would have expected that space to become reserved for
> something else?

Are you checking this against Rev 3 of the spec ?

I'll double check my end of things, but everything shifted
by 1 byte between revs 2 & 3, to make room for the control byte.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
