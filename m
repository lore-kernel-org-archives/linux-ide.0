From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 12:49:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040929124954.C26650@tuxdriver.com>
References: <20040928001633.A8363@florence.linkmargin.com> <20040928003911.B8363@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:43529 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S268762AbUI2SDR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2004 14:03:17 -0400
Content-Disposition: inline
In-Reply-To: <20040928003911.B8363@florence.linkmargin.com>; from andyw@pobox.com on Tue, Sep 28, 2004 at 12:39:11AM -0500
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>

On Tue, Sep 28, 2004 at 12:39:11AM -0500, Andy Warner wrote:

> 2. Curtis has said that a new rev of the proposal is
>    in process. Specifically, the *.En bits are being
>    removed to make room for something else.

Andy,

It looks like you are expecting everything below the *.En bit to be
shifted up by 1 byte.  Am I reading that right?

I guess I would have expected that space to become reserved for
something else?

Just comfirming...

John
-- 
John W. Linville
linville@tuxdriver.com
