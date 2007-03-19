From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22] Add LED trigger to libata core
Date: Mon, 19 Mar 2007 12:46:16 +0000
Message-ID: <20070319124616.2fb7494b@lxorguk.ukuu.org.uk>
References: <20070318170605.3751D5B80F1@ganymede.vroon.org>
	<45FE14BD.5090701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:42683 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753468AbXCSLo3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 07:44:29 -0400
In-Reply-To: <45FE14BD.5090701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tony Vroon <chainsaw@gentoo.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 19 Mar 2007 13:42:37 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Tony Vroon wrote:
> > This duplicates the IDE core LED trigger in the libata core.
> > I plan to use this by allowing PMU LED control on G5 towers. My test platform 
> > is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2 (sata_svw) controller.
> 
> I think this fits better in libata-core.c::ata_qc_issue().  Can you move
> it to there?

Gak. I'd rather it stayed out of ata_qc_issue() which is a critical path
for performance. Our command issu is already too heavy and not all
controllers have queueing to absorb that. How many controllers actually
need this hook and can we not have ata_qc_issue_with_led() helpers for
them ?
