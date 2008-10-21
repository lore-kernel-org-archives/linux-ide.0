From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Tue, 21 Oct 2008 14:02:39 +0400
Message-ID: <48FDA8BF.20206@ru.mvista.com>
References: <20081020214830.1586704c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58048 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752128AbYJUKCp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 06:02:45 -0400
In-Reply-To: <20081020214830.1586704c@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

Hello.

Arjan van de Ven wrote:

> Use the newly introduced pci_ioremap_bar() function in drivers/ide.
> pci_ioremap_bar() just takes a pci device and a bar number, with the goal
> of making it really hard to get wrong, while also having a central place
> to stick sanity checks.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


