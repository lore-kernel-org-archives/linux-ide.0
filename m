From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core: blacklist drives from using NCQ
Date: Tue, 18 Dec 2007 00:00:15 +0000
Message-ID: <20071218000015.38307406@the-village.bc.nu>
References: <20071217221759.GA17766@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47932 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752489AbXLRAHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Dec 2007 19:07:42 -0500
In-Reply-To: <20071217221759.GA17766@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 17 Dec 2007 16:17:59 -0600
David Milburn <dmilburn@redhat.com> wrote:

> Blacklist "HITACHI HDS7225SCSUN250G*" and "SEAGATE STN7225SASUN250G*"
> drives from using NCQ.
> 
> Signed-off-by David Milburn <dmilburn@redhat.com>

Tejun fixed the bug causing the false reporting of NCQ errors so these
blacklist entries should no longer be needed.
