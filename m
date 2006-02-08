From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata-dev: minor fix for irq-pio with Tejun's EH patches
Date: Wed, 08 Feb 2006 16:34:08 +0800
Message-ID: <43E9AD00.8070900@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:34028 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161076AbWBHIeY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 03:34:24 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188YEJh015816
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:34:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188W9n7179492
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:32:09 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188YDxM032203
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:34:13 -0700
In-Reply-To: <43E9AAE0.8020302@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Dear all,

Minor fix for the irq-pio branch with Tejun's EH patches.

1/4: Fix array index value in ata_rwcmd_protocol()
2/4: Use new ata_queue_pio_task() for PIO polling task.
3/4: Use new AC_ERR_* flags
4/4: Minor comment fix

Patch against the irq-pio branch of libata-dev tree
(f6ef65e6d004b77d516037424c7ccc209d0d3509).

For your review, thanks.

Albert



