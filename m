From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 02 Jun 2004 18:30:31 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086222631.3085.12.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>  <1086019779.3144.6.camel@patibmrh9><1086134487.12245.0.
	camel@patibmrh9>  <1086209532.8016.2.camel@patibmrh9><1086215808.16228.6.ca
	mel@patibmrh9>  <1086220390.3285.2.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:54757 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265405AbUFCAah
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 20:30:37 -0400
In-Reply-To: <1086220390.3285.2.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> From: Jeff Garzik ...
> till listening to you, though :)

Of course I stand ready to blog elsewhere if we prefer that.

Did the ata_check_bmdma patch reach you?

> atapi_sense_pio worked...
> immediately after op xA1 ATA_CMD_ID_ATAPI, ...
> [without] reference to struct ata_queued_cmd * qc.

If I try atapi_sense_pio near the ata_qc_complete source line:

        cmd->result = SAM_STAT_CHECK_CONDITION;

then still my kernel goes down after the message:

        ata_exec: ata2: cmd 0xA0

If I remember correctly, it doesn't even reach the message:

        ata_exec_command_pio: ata2: cmd 0xA0

Somehow, sometime after the op xA1 "IDENTIFY" completes, we switch into
a mode where provoking an extra interrupt by writing an extra command
from ata_host_intr halts me violently ...

Pat LaVarre


