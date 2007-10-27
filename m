From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/9] ide: replace ide_pci_device_t by struct ide_port_info
Date: Sat, 27 Oct 2007 21:05:36 +0400
Message-ID: <47236FE0.6020606@ru.mvista.com>
References: <200709242247.27459.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:2397 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755463AbXJ0RF1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 13:05:27 -0400
In-Reply-To: <200709242247.27459.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Rename struct ide_pci_device_s to struct ide_port_info.

    I'm not sure that ide_port_info name fits the data indeed, as those are 
not applicable only to the ports but to a chip as a whole, so ide_chip_info 
would seem a better name... but well, it's too late anyway.

> * Remove ide_pci_device_t typedef.

> While at it:

> * Fix __ide_pci_register_driver() comment.

> * Fix aec62xx_init_one() comment.

> * Remove unused 'cds' field from ide_hwgroup_t.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Well, it's too late for ACK. :-)

MBR, Sergei
