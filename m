From: Andy Warner <andyw@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - another patch.
Date: Tue, 5 Oct 2004 22:23:31 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041005222331.F13871@florence.linkmargin.com>
References: <20041005182049.E13871@florence.linkmargin.com> <4163623F.4030407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:50174 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266786AbUJFDZZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 23:25:25 -0400
Content-Disposition: inline
In-Reply-To: <4163623F.4030407@pobox.com>; from jgarzik@pobox.com on Tue, Oct 05, 2004 at 11:10:55PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org, John Linville <linville@redhat.com>, linville@tuxdriver.com, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>

Jeff Garzik wrote:
> [...]
> Make sure to split up patches into separate emails, and don't combine 
> e.g. your error register patch with a passthru update patch.
> 
> Separate changes go into separate patches.

Ack.

Apologies.

I was not really sure who the customer is for these: integrators
or folks trying to test this stuff and not wanting them to have
to play find-the-missing-patch.

Won't happen again.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
