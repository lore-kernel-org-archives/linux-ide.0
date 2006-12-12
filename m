From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: do not mangle saved HOST_CAP while resetting
 controller
Date: Tue, 12 Dec 2006 12:15:19 +0000
Message-ID: <20061212121519.3dda1286@localhost.localdomain>
References: <20061123051815.GD18344@dosa.chappati.org>
	<20061212111732.GF18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43414 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbWLLMHb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 07:07:31 -0500
In-Reply-To: <20061212111732.GF18947@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Manoj Kasichainula <manoj@io.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, 12 Dec 2006 20:17:32 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Do not mangle with HOST_CAP while resetting controller.  The code is
> there for a historical reason.  The mangling breaks controller feature
> detection and 0 PORTS_IMPL workaround code.
> 
> This problem was spotted by Manoj Kasichainula.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Manoj Kasichainula <manoj@io.com>

Acked-by: Alan Cox <alan@redhat.com>
