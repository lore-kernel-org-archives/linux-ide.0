From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/11] ide-pmac: don't check kauai_lookup_timing()	return
 value
Date: Sun, 29 Jul 2007 21:26:05 +0400
Message-ID: <46ACCDAD.1000302@ru.mvista.com>
References: <200707222020.55609.bzolnier@gmail.com> <1185141244.5439.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56993 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764112AbXG2RYG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 13:24:06 -0400
In-Reply-To: <1185141244.5439.58.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>kauai_lookup_timing() should always return non-zero return value:

>>* BUG() in kauai_lookup_timing() if the timing info cannot be found.

>>* Remove code checking for zero return value from all callers.

> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
