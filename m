From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 1/1] AHCI: Optimize interrupt processing
Date: Tue, 2 Apr 2013 14:03:12 +0200
Message-ID: <20130402120312.GA19112@dhcp-26-207.brq.redhat.com>
References: <cover.1362568800.git.agordeev@redhat.com>
 <7aaa7f37e742bf57e3043be865774b8a1f033d86.1362568800.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760746Ab3DBL6j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Apr 2013 07:58:39 -0400
Content-Disposition: inline
In-Reply-To: <7aaa7f37e742bf57e3043be865774b8a1f033d86.1362568800.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Mar 06, 2013 at 12:26:47PM +0100, Alexander Gordeev wrote:
> Split interrupt service routine into hardware context handler and
> threaded context handler. That allows to protect ports with individual
> locks rather than with a single host-wide lock, which results in better
> parallelism.

Hi Jeff,

Any comment on this change?
Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
