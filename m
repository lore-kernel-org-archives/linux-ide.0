From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: ZBC_IN command translation
Date: Wed, 7 Jun 2017 18:03:52 +0900
Message-ID: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdFGJEJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2017 05:04:09 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>

Tejun, Hannes,

Currently, in libata-scsi.c, the function ata_scsi_zbc_in_xlat
translating ZBC REPORT ZONES into the ZAC version returns an error if
the scsi command buffer length is not aligned on 512. This is possible
since the ZBC version allows report zones buffer as a multiple of 64B,
while the ZAC version of the same command requires 512B size alignment
of the command buffer.

However, SAT-4, in section 9.13.3 says:

"The SATL shall send the ATA REPORT ZONES EXT command with the ATA
RETURN PAGE COUNT field set to INT((ALLOCATION LENGTH + 511)/512)."

So clearly, instead of returning an error, we need to bounce the scsi
command buffer to a bigger 512B size aligned temporary buffer for the
ZAC report zones. I do not see any code ready to use to do so easily,
but I may be missing it. Is there something that can be used to do so or
do I need to cook something ?

Best regards.

-- 
Damien Le Moal,
Western Digital
