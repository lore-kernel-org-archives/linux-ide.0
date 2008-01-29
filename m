From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/8] ide: always set DMA masks in ide_pci_setup_ports()
Date: Tue, 29 Jan 2008 23:02:50 +0300
Message-ID: <479F866A.1030207@ru.mvista.com>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain> <20080106170255.6861.36960.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:8877 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753845AbYA2UB4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 15:01:56 -0500
In-Reply-To: <20080106170255.6861.36960.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Always set DMA masks in ide_pci_setup_ports() to make sure that the valid
> masks for a host are set.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
