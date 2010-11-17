From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] libata: remove scsi host lock and serial number usage
Date: Wed, 17 Nov 2010 10:15:54 -0800
Message-ID: <AANLkTimwwCDfXSk5aEfHv3qzcvTzOQUB5fOCU4c5JJ8V@mail.gmail.com>
References: <20101117172111.GA26812@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52320 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933148Ab0KQSQX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2010 13:16:23 -0500
In-Reply-To: <20101117172111.GA26812@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de

On Wed, Nov 17, 2010 at 9:21 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Much better... =A0Just updated #upstream-fixes with the below patch.

Yes. This looks like a real improvement and actually gets rid of that
silly lock entirely. Good.

                       Linus
